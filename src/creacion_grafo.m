s = size(Matrizdeadyacencia);
G =graph(Matrizdeadyacencia,string(1:s(1)));
G.Nodes.Etiqueta = Resumen.Nodo_ID;

figure ('Name', 'Grafo_matriz');
plot(G)

bins = conncomp(G); 
num_componentes = max(bins); 

componentes={}; %genera componentes para obtener el componente con más nodos
for i = 1:num_componentes
    [v,x]=find(bins == i);
    comp{i} = subgraph(G,x);
    Cellboxes_Comp = boxcoveringmemb(adjacency(comp{i}));
    if diameter(comp{i}) >= 3
        subgrafos_r ={};
        for r = 1:length(Cellboxes_Comp)
            boxes = Cellboxes_Comp{r};
            subgrafos = {};
            for l = 1:length(boxes) 
                nodos = boxes{l};
                subgrafos{l} = subgraph(comp{i},nodos);
            end
            subgrafos_r{r} = subgrafos;
        end
        componentes{i} = subgrafos_r; 
    else
        componentes{i} = comp{i};
    continue;
 end
end

nodosBuscados = Resumen.ID(Resumen.Burst > 0);
nodosBuscados = arrayfun(@num2str, nodosBuscados, 'UniformOutput', false);
Resumen.ID = string(Resumen.ID);

arreglos = struct(); %crea estructura para almacenar cada nivel de cobertura como un arreglo
for i = 1:numel(componentes{1}) 
    arreglo_grafos = {}; 
    tabla_gyn = table();
    for j = 1:numel(componentes{1,1}{1,i})
        G = componentes{1,1}{1,i}{1,j};
        for k = 1:numel(nodosBuscados)
            nodoindividual = nodosBuscados{k,1};
            idx = findnode(G, nodoindividual);
            if idx > 0
                nueva_fila = table({G}, {nodoindividual}, 'VariableNames', {'Grafo', 'Nodo'});
                tabla_gyn = [tabla_gyn; nueva_fila];
            end
        end
    end
    arreglos.(sprintf('nivel_cobertura_%d', i)) = tabla_gyn;
end

arreglos = calculo_BC(arreglos); %calcula betweeness centrality

for i = 1:numel(componentes{1}) %agrega el valor de burstness al nodo que corresponda
    caja = sprintf('nivel_cobertura_%d', i); 
    tablaActual = arreglos.(caja); 
    tablaActual.Burst = NaN(height(tablaActual), 1);
    for j = 1:height(tablaActual)
        nodo = tablaActual.Nodo(j); 
        idx = find(strcmp(Resumen.ID, nodo), 1); 
        if ~isempty(idx)
            tablaActual.Burst(j) = Resumen.Burst(idx); 
        end
    end
    arreglos.(caja) = tablaActual;
end

for i = 1:numel(componentes{1}) %agrega el valor de sigma de citespace al nodo que corresponda
    caja = sprintf('nivel_cobertura_%d', i); 
    tablaActual = arreglos.(caja); 
    tablaActual.SigmaCS = NaN(height(tablaActual), 1);
    for j = 1:height(tablaActual)
        nodo = tablaActual.Nodo(j); 
        idx = find(strcmp(Resumen.ID, nodo), 1); 
        if ~isempty(idx)
            tablaActual.SigmaCS(j) = Resumen.Sigma(idx); 
        end
    end
    arreglos.(caja) = tablaActual;
end

arreglos = calculo_sigma(arreglos); %calcula Sigma

tabla_completa = table(); %permite la manipulación de la información en una única tabla con todos los resultados

for i = 1:numel(componentes{1})
    caja = sprintf('nivel_cobertura_%d', i); 
    tabla_actual = arreglos.(caja);     
    tabla_actual.Nivel_Cobertura = repmat({caja}, height(tabla_actual), 1);
    tabla_completa = [tabla_completa; tabla_actual];
end 

% Genera promedio de Sigma agrupado por nodo
tabla_completa.Nodo = str2double(tabla_completa.Nodo);
T_promedios = groupsummary(tabla_completa, 'Nodo', 'mean', 'Sigma');
T_promedios.Properties.VariableNames{'mean_Sigma'} = 'AVGSigma';
tabla_completa = outerjoin(tabla_completa, T_promedios(:, {'Nodo', 'AVGSigma'}), 'Keys', 'Nodo', 'MergeKeys', true);

% Genera integral de Sigma agrupado por nodo
if iscell(tabla_completa.Nodo) || ischar(tabla_completa.Nodo)
    tabla_completa.Nodo = str2double(tabla_completa.Nodo);
end
tabla_completa.Sigma = fillmissing(tabla_completa.Sigma, 'linear'); %Hay valores con NaN, se llenan los faltantes para realizar el cálculo
T_integrales = varfun(@(x) trapz(x(~isnan(x))), tabla_completa, ...
                      'GroupingVariables', 'Nodo', 'InputVariables', 'Sigma');
T_integrales.Properties.VariableNames{'Fun_Sigma'} = 'IntegralSigma';
tabla_completa = outerjoin(tabla_completa, T_integrales(:, {'Nodo', 'IntegralSigma'}), ...
                           'Keys', 'Nodo', 'MergeKeys', true);

amplitud = 12; %Considera los niveles de cobertura del 1 al 13
grupos = findgroups(tabla_completa.Nodo);
max_sigma_por_nodo = splitapply(@max, tabla_completa.Sigma, grupos);
integral_sigma_por_nodo = splitapply(@(x) trapz(x), tabla_completa.Sigma, grupos);
tabla_completa.maxSigma = max_sigma_por_nodo(grupos);
tabla_completa.IntegralSigma = integral_sigma_por_nodo(grupos);
tabla_completa.SigmaNormalizada = tabla_completa.IntegralSigma ./ (tabla_completa.maxSigma * amplitud);



