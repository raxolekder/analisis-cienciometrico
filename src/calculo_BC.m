function arreglos = calculo_BC(arreglos)
    for i = 1:13
        caja = sprintf('nivel_cobertura_%d', i);
        for j = 1:height(arreglos.(caja))
            grafo = arreglos.(caja).Grafo{j, 1};
            n = numnodes(grafo);
            par_de_nodos = n * (n - 1) / 2;
            bc = centrality(grafo, 'betweenness');
            nodoEvaluado = arreglos.(caja).Nodo(j);
            idx = findnode(grafo, nodoEvaluado);

            if idx > 0
                bc_citespace_validacion = (bc(idx) / par_de_nodos) * 2;
                if isnan(bc_citespace_validacion)
                    arreglos.(caja).BC(j, 1) = 0;
                else
                    redondeo = round(bc_citespace_validacion, 2);
                    arreglos.(caja).BC(j, 1) = redondeo;
                end
            end
        end
    end
end



 
  
       