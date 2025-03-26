
carpeta_guardado = [getenv('USERPROFILE') '\Desktop\graficas_nodos'];
if ~exist(carpeta_guardado, 'dir')
    mkdir(carpeta_guardado);
end

nodos_unicos = unique(tabla_completa.Nodo);

for i = 1:length(nodos_unicos)
    nodo_actual = nodos_unicos{i};
    filas_nodo = tabla_completa(strcmp(tabla_completa.Nodo, nodo_actual), :);
    
    if isempty(filas_nodo)
        disp(['El nodo ' nodo_actual ' no tiene datos en la tabla.']);
        continue;
    end
    
    nodo_id_fila = Resumen.ID == nodo_actual;
    if any(nodo_id_fila)
        nodo_id = Resumen.Nodo_ID(nodo_id_fila);
    else
        nodo_id = "Desconocido"; 
    end
   
    filas_nodo.Caja_Numero = cellfun(@(x) str2double(regexp(x, '\d+', 'match', 'once')), filas_nodo.Caja);
    filas_nodo = sortrows(filas_nodo, 'Caja_Numero');
    
    valores_sigma = filas_nodo.Sigma;
    ejes_x = 1:height(filas_nodo);
    

    figure;
    plot(ejes_x, valores_sigma, '-o', 'LineWidth', 2, 'DisplayName', sprintf('Nodo %s', nodo_id));
    xlabel('L (diametro)');
    ylabel('Sigma');
    title(['Variación de Sigma para el Nodo ' nodo_id]);
    legend('show');
    grid on;
    
  
    nombre_archivo = fullfile(carpeta_guardado, sprintf('Nodo_%s.png', nodo_id));
    saveas(gcf, nombre_archivo);
    close(gcf); 
end

