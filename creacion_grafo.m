s = size(Matrizdeadyacencia);
G =graph(Matrizdeadyacencia,string(1:s(1)));
G.Nodes.Etiqueta = Labels.Nodo_ID;

figure ('Name', 'Grafo_matriz');

[size,namenodesingiant]=giantComponent(G);
G1 = subgraph(G,namenodesingiant);

[~, idx] = ismember(namenodesingiant, G.Nodes.Name);
G1.Nodes.Etiqueta = G.Nodes.Etiqueta(idx, :);

p1 = plot(G1);
%labelnode(p1, 1:numnodes(G1), G1.Nodes.Etiqueta);

Cellboxes = boxcoveringmemb(adjacency(G1));

bins = conncomp(G); %identificar las componentes conexas de un grafo (la variable indica el componente al que cada nodo pertenece)
num_componentes = max(bins); 

figure
plot(G)

componentes={};
for i = 1:num_componentes
    [v,x]=find(bins == i);
    comp{i} = subgraph(G,x);
    % plot(comp{i})
    Cellboxes_Comp = boxcoveringmemb(adjacency(comp{i}));
     if diameter(comp{i}) >= 3
        subgrafos_r ={};
        for r = 1:length(Cellboxes_Comp)
        boxes = Cellboxes_Comp{r};
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