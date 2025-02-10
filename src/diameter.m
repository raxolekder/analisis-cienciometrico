function d=diameter(G)
     dis=distances(G,'Method','unweighted');
     d=max(dis(isfinite(dis)));
end