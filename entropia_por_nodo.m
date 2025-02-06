function [tabla_entropia] = entropia_por_nodo(subgrafoE)
    n = numnodes(subgrafoE);
    H_nodos = NaN(n, 1);      % Entropía real por nodo, inicializada a NaN
    H_max_nodos = NaN(n, 1);  % Entropía máxima por nodo, inicializada a NaN

    % Verificar si los nodos tienen nombres (usando 'Name' o 'ID')
    if isprop(subgrafoE, 'Nodes') && isfield(subgrafoE.Nodes, 'Name')
        nodos = subgrafoE.Nodes.Name; % Si los nodos tienen un campo 'Name'
    elseif isprop(subgrafoE, 'Nodes') && isfield(subgrafoE.Nodes, 'ID')
        nodos = string(subgrafoE.Nodes.ID); % Si los nodos tienen un campo 'ID'
    else
        nodos = string(1:n);  % Si no hay nombres o IDs, usar índices numéricos
    end

    for i = 1:n
        vecinos = neighbors(subgrafoE, i);
        d_i = length(vecinos); % Grado del nodo

        if d_i == 0
            continue; % Si no tiene vecinos, se omite este nodo
        end

        % Probabilidad uniforme
        P = ones(d_i, 1) / d_i;

        % Entropía real
        P_vecinos = degree(subgrafoE, vecinos) / sum(degree(subgrafoE, vecinos)); % Probabilidad basada en los grados
        P_vecinos(P_vecinos == 0) = []; % Evitar log(0)
        H_nodos(i) = -sum(P_vecinos .* log2(P_vecinos));

        % Entropía máxima
        H_max_nodos(i) = log2(d_i);
    end

    % Crear tabla con los resultados usando los nombres o IDs de los nodos
    tabla_entropia = table(nodos', H_nodos, H_max_nodos);

    % Graficar el grafo
    figure ('Name', 'Grafo_entropia');
    plot(subgrafoE);
end




