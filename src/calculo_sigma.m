function arreglos = calculo_sigma(arreglos)
    for i = 1:13
        caja = sprintf('caja_%d', i);
        for j = 1:height(arreglos.(caja))
            valor_bc = arreglos.(caja).BC(j);
            valor_burstness = arreglos.(caja).Burst(j);
            valor_sigma = (valor_bc + 1).^valor_burstness;
            arreglos.(caja).Sigma(j) = valor_sigma;
        end
    end
end
