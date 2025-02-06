function [H_nodos, H_max_nodos] = entropia_por_nodo(subgrafoE)
   %subgrafoE = arreglos.caja_3.Grafo{1}
    n = numnodes(subgrafoE);
    H_nodos = zeros(n,1);      % Entropía real por nodo
    H_max_nodos = zeros(n,1);  % Entropía máxima por nodo

    for i = 1:n
        vecinos = neighbors(subgrafoE, i);
        d_i = length(vecinos); % Grado del nodo

        if d_i == 0
            continue; % Si no tiene vecinos, entropía = 0
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
    figure ('Name', 'Grafo_entropia');
    plot(subgrafoE);
end
