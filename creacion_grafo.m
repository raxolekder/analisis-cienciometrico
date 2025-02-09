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