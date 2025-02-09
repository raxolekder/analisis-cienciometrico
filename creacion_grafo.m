s = size(Matrizdeadyacencia);
G =graph(Matrizdeadyacencia,string(1:s(1)));
G.Nodes.Etiqueta = Labels.Nodo_ID;

figure ('Name', 'Grafo_matriz');
plot(G);
[size,namenodesingiant]=giantComponent(G);
G1 = subgraph(G,namenodesingiant);
plot(G1);
Cellboxes = boxcoveringmemb(adjacency(G1));