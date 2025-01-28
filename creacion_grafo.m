s = size(Matrizdeadyacencia);
G =graph(Matrizdeadyacencia,string(1:s(1)));

figure ('Name', 'Grafo_matriz');

[size,namenodesingiant]=giantComponent(G);
G1 = subgraph(G,namenodesingiant);
plot(G1);
Cellboxes = boxcoveringmemb(adjacency(G1));