% Crear la carpeta de guardado si no existe
carpeta_guardado = fullfile(getenv('USERPROFILE'), 'Desktop', 'graficas_nodos');
if ~exist(carpeta_guardado, 'dir')
    mkdir(carpeta_guardado);
end

% Obtener nodos únicos
nodos_unicos = unique(tabla_completa.Nodo);

for i = 1:length(nodos_unicos)
    nodo_actual = nodos_unicos(i);  % Tomar un nodo único

    % ✅ Asegurar compatibilidad de tipos
    if iscell(tabla_completa.Nodo)
        nodo_actual_str = num2str(nodo_actual); % Convertir nodo a string si es necesario
        filas_nodo = tabla_completa(strcmp(tabla_completa.Nodo, nodo_actual_str), :);
    elseif isnumeric(tabla_completa.Nodo)
        filas_nodo = tabla_completa(tabla_completa.Nodo == nodo_actual, :);
    else
        error('El tipo de dato de Nodo en tabla_completa no es compatible.');
    end

    % ✅ Verificar si el nodo tiene datos
    if isempty(filas_nodo)
        disp(['El nodo ' num2str(nodo_actual) ' no tiene datos en la tabla.']);
        continue;
    end
    
    % Convertir nodo_actual a string para comparar
    nodo_actual_str = num2str(nodo_actual); 

    % Obtener Nodo_ID desde Resumen
    nodo_id_fila = strcmp(Resumen.ID, nodo_actual_str);  % Comparar como string
    if any(nodo_id_fila)
        nodo_id = Resumen.Nodo_ID(nodo_id_fila);
    else
        nodo_id = "Desconocido"; 
    end

    % Extraer número de caja
    if iscell(filas_nodo.Nivel_Cobertura)
        filas_nodo.Caja_Numero = cellfun(@(x) str2double(regexp(x, '\d+', 'match', 'once')), filas_nodo.Nivel_Cobertura);
    else
        filas_nodo.Caja_Numero = str2double(regexp(filas_nodo.Nivel_Cobertura, '\d+', 'match', 'once'));
    end
    filas_nodo = sortrows(filas_nodo, 'Caja_Numero');

    % Obtener valores de Sigma
    valores_sigma = filas_nodo.Sigma;
    ejes_x = 1:height(filas_nodo);

    % Graficar
    figure;
    plot(ejes_x, valores_sigma, '-o', 'LineWidth', 2, 'DisplayName', sprintf('Nodo %s', nodo_id));
    xlabel('Nivel de cobertura/Longitud');
    ylabel('Sigma');
    title(['Variación de Sigma para el Nodo ' char(nodo_id)]);
    legend('show');
    grid on;

    % Guardar gráfico
    nombre_archivo = fullfile(carpeta_guardado, sprintf('Nodo_%s.png', char(nodo_id)));
    saveas(gcf, nombre_archivo);
    close(gcf);
end
