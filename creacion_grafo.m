s = size(Matrizdeadyacencia);
G =graph(Matrizdeadyacencia,string(1:s(1)));
G.Nodes.Etiqueta = Resumen.Nodo_ID;

figure ('Name', 'Grafo_matriz');
plot(G)

bins = conncomp(G); %identificar las componentes conexas de un grafo (la variable indica el componente al que cada nodo pertenece)
num_componentes = max(bins); 

componentes={};
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

arreglos = struct();

for i = 1:numel(componentes{1}) % 13 cajas
    arreglo_grafos = {}; 
    tabla_gyn = table();
    for j = 1:numel(componentes{1,1}{1,i})
        G = componentes{1,1}{1,i}{1,j};
        for k = 1:numel(nodosBuscados)
            nodoindividual = nodosBuscados{k,1};
            idx = findnode(G, nodoindividual);
            if idx > 0
                nueva_fila = table({G}, {nodoindividual}, 'VariableNames', {'Grafo', 'Nodo'});
                tabla_gyn = [tabla_gyn; nueva_fila]; % Agregar la fila a la tabla
            end
        end
    end
    arreglos.(sprintf('caja_%d', i)) = tabla_gyn;
end