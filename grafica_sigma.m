nodo_seleccionado = input('Nodo a graficar ', 's');

filas_nodo = tabla_completa(strcmp(tabla_completa.Nodo, nodo_seleccionado), :);

if isempty(filas_nodo)
    disp(['El nodo seleccionado (' nodo_seleccionado ') no existe en la tabla.']);
else
    
    filas_nodo.Caja_Numero = cellfun(@(x) str2double(regexp(x, '\d+', 'match', 'once')), filas_nodo.Caja);
    
    filas_nodo = sortrows(filas_nodo, 'Caja_Numero');

    valores_sigma = filas_nodo.Sigma;
    ejes_x = 1:height(filas_nodo);
    figure;
    plot(ejes_x, valores_sigma, '-o', 'LineWidth', 2, 'DisplayName', sprintf('Nodo %s', nodo_seleccionado));
    
    xlabel('L (diametro)');
    ylabel('Sigma');
    title(['Sigma del Nodo ' nodo_seleccionado ' Navarro-Hellín H (2016) a través de las diferentes longitudes']);
    legend('show');
    grid on;

    dcm = datacursormode(gcf); 
    set(dcm, 'UpdateFcn', @(obj, event_obj) customDataCursor(event_obj, valores_sigma, filas_nodo));
end

function output_txt = customDataCursor(event_obj, valores_sigma, filas_nodo)
    idx = get(event_obj, 'DataIndex');

    sigma_val = valores_sigma(idx);
    caja_val = filas_nodo.Caja(idx);
    output_txt = {
        ['Caja: ', char(caja_val)], ...
        ['Sigma: ', num2str(sigma_val)]
    };
end


