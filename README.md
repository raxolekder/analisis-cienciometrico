# **Redefinición de indicador de cienciometría para la novedad científica**

📅 **Fecha**: 2025 
👨‍🎓 **Autor**: David Parra 
🏫 **Universidad**: Instituto Politécnico Nacional 
📚 **Programa**: Maestría en informática 

---

## **📌 Descripción**

 
Este proyecto forma parte de mi tesis titulada *"Redefinición de indicador de cienciometría para la novedad científica"*. Cuyo objetivo es redefinir el indicador cienciométrico de novedad científica "sigma"; aplicando el método de cubrimiento de cajas, a un gran volumen de artículos científicos, tal que, de la serie de datos resultante se se obtenga el promedio y el área bajo la curva de sigma, la cual oriente sobre la novedad científica del volumen de artículos analizado; siendo esto la redefinición propia del indicador "sigma".

---

## **📁 Estructura del Proyecto**
Explicación de la organización de los archivos y carpetas.

```plaintext
📂 Tesis
 ├── 📜 README.md               # Este archivo
 ├── 📜 TESIS_DIPV.pdf          # Documento final de la tesis
 ├── 📂 src/                    # Código fuente
 │   ├── creacion_grafo.m        # Código principal
 │   ├── boxcoveringmemb.m       # Genera las cajas del algoritmo
 │   ├── calculo_BC.m            # Función para calcular betweeness centrality
 │   ├── calculo_sigma.m         # Función para calcular sigma
 │   ├── diameter.m              # Función para calcular el diametro de la red
 │   ├── grafica_sigma.m         # Código para generar gráficas
 │   ├── memb.m                  # Cálculo del algoritmo MEMB
 ├── 📂 data/                    # Datos utilizados
 │   ├── Matrizdeadyacencia.txt  # Archivo con la matriz de adyacencia obtenida de CiteSpace
 │   ├── Resumen.xlsx            # Información obtenida de CiteSpace
 ├── 📂 results/                # Resultados obtenidos
 │   ├── burstness_results.mat  # Matriz con valores de burstness
 │   ├── visualizaciones/       # Gráficos generados
 ├── 📜 requirements.txt        # Librerías necesarias
 ├── 📜 LICENSE                 # Licencia del proyecto
```

---

## **🛠 Requisitos y Configuración**
Se requiere de MATLAB para ejecutar los scripts

### **🔧 Requisitos**
- **MATLAB** (Versión mínima recomendada: R2024b)  
- **Toolboxes**: Statistics and Machine Learning, Graph Theory Toolbox   

### **💻 Instalación**

```bash
git clone https://github.com/usuario/tesis-burstness.git
cd tesis-burstness
```

En MATLAB, abre `.m` y ejecuta:

```matlab
run('creacion_grafo.m')
```

---

## **🚀 Uso del Código**
Explica cómo ejecutar el código y los posibles parámetros.

```matlab
resultados = burstness(datos, alfa, gamma);
```

📌 **Parámetros**:  
- `datos`: Archivo con referencias científicas.  
- `alfa`: Parámetro del modelo de Kleinberg.  
- `gamma`: Peso de transición en la cadena de Markov.  

📌 **Ejemplo de ejecución**:  

```matlab
data = load('data/referencias.csv');
resultados = burstness(data, 2.0, 1.0);
```

---

## **📊 Resultados y Ejemplos**
Incluye ejemplos de salida y gráficos.

```matlab
plot(resultados.anios, resultados.burstness);
xlabel('Año');
ylabel('Intensidad del Burstness');
title('Evolución del Burstness en Citas Científicas');
```

📌 **Ejemplo de salida esperada**:  
![Ejemplo de gráfica](results/visualizaciones/burstness_plot.png)

---

## **📝 Contribuciones y Contacto**

📌 **Contacto**
Para preguntas o comentarios, puedes escribirme a:  
📧 [dparrav2200@alumno.ipn,mx](mailto:dparrav2200@alumno.ipn.mx)  

---

## **⚖️ Licencia**
Este proyecto fue desarrollado como trabajo de tesis para el Instituto Politécnico Nacional - Unidad Profesional Interdisciplinaria de Ingeniería y Ciencias Sociales y Administrativas (UPIICSA) . Todos los derechos reservados © 2025 IPN.
