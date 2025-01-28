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