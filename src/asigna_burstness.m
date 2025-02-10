% agrega valor de burstness
for i = 1:13
    caja = sprintf('caja_%d', i); 
    tablaActual = arreglos.(caja); 

    tablaActual.Burst = NaN(height(tablaActual), 1);

    for j = 1:height(tablaActual)
        nodo = tablaActual.Nodo(j); 

       idx = find(strcmp(Resumen.ID, nodo), 1); 

        if ~isempty(idx)
            tablaActual.Burst(j) = Resumen.Burst(idx); 
        end
    end
    
    arreglos.(caja) = tablaActual;
end
