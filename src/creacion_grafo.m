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

arreglos = struct(); %crea estructura para almacenar cada caja como un arreglo
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
    arreglos.(sprintf('caja_%d', i)) = tabla_gyn;
end

arreglos = calculo_BC(arreglos); %calcula betweeness centrality

for i = 1:numel(componentes{1}) %agrega el valor de burstness al nodo que corresponda
    caja = sprintf('caja_%d', i); 
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

arreglos = calculo_sigma(arreglos); %calcula sigma

tabla_completa = table(); %permite la manipulación de la información en una única tabla con todos los resultados
for i = 1:numel(componentes{1})
    caja = sprintf('caja_%d', i); 
    tabla_actual = arreglos.(caja);     
    tabla_actual.Caja = repmat({caja}, height(tabla_actual), 1);
    tabla_completa = [tabla_completa; tabla_actual];
end 