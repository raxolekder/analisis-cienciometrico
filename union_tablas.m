
tabla_completa = table();

for i = 1:13
    caja = sprintf('caja_%d', i); 
    tabla_actual = arreglos.(caja);     
    tabla_actual.Caja = repmat({caja}, height(tabla_actual), 1);
 
    tabla_completa = [tabla_completa; tabla_actual];
end
