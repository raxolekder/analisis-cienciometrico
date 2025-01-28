
clc 
close 

num_elementos = numel(Cellboxes);

for i = 1:numel(Cellboxes)
  grafo = Cellboxes{i};
  var_name = sprintf('grafo_%d', i);
  eval([var_name ' = grafo;']);
end

g2 = [];
for k = 1:numel(grafo_2)    
 x = grafo_2{k};
 g2 = [g2(1:k-1),x,g2(k:end)];
end

h = [];
for k = 1:numel(grafo_2)
  h{k} = subgraph(G1,grafo_2{k});
  %figure
  %plot(h{k},'Layout','force')
end 

diametro = diameter(G); %mayor distancia mínima entre cualquier par de nodos dentro de la red.

bins = conncomp(G); %identificar las componentes conexas de un grafo (la variable indica el componente al que cada nodo pertenece)
num_componentes = max(bins); 

figure
plot(G)

componentes={};
for i = 1:num_componentes
    [v,x]=find(bins == i);
    comp{i} = subgraph(G,x);
    % plot(comp{i})
    Cellboxes = boxcoveringmemb(adjacency(comp{i}));
     if diameter(comp{i}) >= 3
        subgrafos_r ={};
        for r = 1:length(Cellboxes)
        boxes = Cellboxes{r};
        subgrafos = {};
            for l = 1:length(boxes) 
            nodos = boxes{l};
            subgrafos{l} = subgraph(comp{i},nodos);
            %plot(subgrafos{l})
            end
            subgrafos_r{r} = subgrafos; 
        end
        componentes{i} = subgrafos_r; 
     else
         componentes{i} = comp{i};
        continue;
     end
end

subgrafos = {diametro+1,numnodes(G)};

nodosBuscados = EtiquetasnodosconID.ID(EtiquetasnodosconID.Burst > 0);
nodosBuscados = arrayfun(@num2str, nodosBuscados, 'UniformOutput', false);
EtiquetasnodosconID.ID = string(EtiquetasnodosconID.ID);