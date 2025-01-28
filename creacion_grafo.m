clear bc d G H

s = size(Matrizdeadyacencia);
G =graph(Matrizdeadyacencia,string(1:s(1)));

figure ('Name', 'Grafo_matriz');

%bc_citespace = betweeness_centrality_CS(G);
d = degree(G);

[size,namenodesingiant]=giantComponent(G);
G1 = subgraph(G,namenodesingiant);
plot(G1);
Cellboxes = boxcoveringmemb(adjacency(G1));