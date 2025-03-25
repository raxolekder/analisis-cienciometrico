# **Redefinición de indicador de cienciometría para la novedad científica**

📅 **Fecha**: 2025 
👨‍🎓 **Autor**: David Parra 
🏫 **Universidad**: Instituto Politécnico Nacional 
📚 **Programa**: Maestría en informática 

---

## **📌 Descripción**

 
Este proyecto forma parte de mi tesis titulada *"Redefinición de indicador de cienciometría para la novedad científica"*. Redefinir el indicador cienciométrico de novedad científica "sigma"; aplicando el método de cubrimiento de cajas, a un gran volumen de artículos científicos, tal que, de la serie de datos resultante se obtenga la entropía máxima, la cual oriente sobre la novedad científica del volumen de artículos analizado; siendo esto la redefinición propia del indicador "sigma".

---

## **📁 Estructura del Proyecto**
Explicación de la organización de los archivos y carpetas.

```plaintext
📂 Tesis-Burstness
 ├── 📜 README.md               # Este archivo
 ├── 📜 TESIS_DIPV.pdf          # Documento final de la tesis
 ├── 📂 src/                    # Código fuente
 │   ├── burstness.m            # Implementación del algoritmo de Kleinberg
 │   ├── procesar_datos.m       # Preprocesamiento de datos
 │   ├── visualizar_grafos.m    # Función para graficar los resultados
 ├── 📂 data/                   # Datos utilizados
 │   ├── referencias.csv        # Archivo con citas de artículos
 │   ├── nodos_componentes.mat  # Información de nodos en MATLAB
 ├── 📂 results/                # Resultados obtenidos
 │   ├── burstness_results.mat  # Matriz con valores de burstness
 │   ├── visualizaciones/       # Gráficos generados
 ├── 📜 requirements.txt        # Librerías necesarias
 ├── 📜 LICENSE                 # Licencia del proyecto
```

---

## **🛠 Requisitos y Configuración**
Lista de herramientas, software y librerías necesarias para ejecutar el código.

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
run('burstness.m')
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
Si el código estará disponible públicamente:

📌 **Cómo contribuir**
1. Haz un **fork** del repositorio.
2. Crea una nueva rama: `git checkout -b feature-nueva-funcionalidad`
3. Sube los cambios y haz un **pull request**.

📌 **Contacto**
Para preguntas o comentarios, puedes escribirme a:  
📧 [tuemail@ejemplo.com](mailto:tuemail@ejemplo.com)  

---

## **⚖️ Licencia**
Este proyecto fue desarrollado como trabajo de tesis para el Instituto Politécnico Nacional - Unidad Profesional Interdisciplinaria de Ingeniería y Ciencias Sociales y Administrativas (UPIICSA) . Todos los derechos reservados © 2025 IPN.

---

### **📌 Buenas Prácticas Generales**
✔ **Claro y conciso**: No más largo de lo necesario.  
✔ **Formato estructurado**: Usa secciones bien definidas.  
✔ **Ejemplos y código**: Incluye fragmentos listos para copiar y pegar.  
✔ **Referencias**: Si usaste papers o herramientas, cítalas.  
