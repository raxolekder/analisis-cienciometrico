Este software fue desarrollado por el Instituto Politécnico Nacional y está registrado en el Instituto Nacional del Derecho de Autor (INDAUTOR), México, con el número de registro 03-2025-060611211800-01 con fecha: 27 de Junio de 2025.

Se distribuye bajo la Apache License 2.0. Consulta el archivo LICENSE para más detalles.

# **Redefinición de indicador de cienciometría para la novedad científica**

📅 **Fecha**: 2025 
👨‍🎓 **Autor**: David Parra 
🏫 **Universidad**: Instituto Politécnico Nacional 
📚 **Programa**: Maestría en informática 

---

## **📌 Descripción**

 
Este proyecto forma parte de mi tesis titulada *"Redefinición de indicador de cienciometría para la novedad científica"*. Cuyo objetivo es redefinir el indicador cienciométrico de novedad científica "sigma"; aplicando el método de cubrimiento de cajas, a un gran volumen de artículos científicos, tal que, de la serie de datos resultante se obtenga el área bajo la curva de sigma, la cual oriente sobre la novedad científica del volumen de artículos analizado; siendo esto la redefinición propia del indicador "sigma".

---

## **📁 Estructura del Proyecto**

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
 ├── 📂 results/                 # Resultados obtenidos
 │   ├── Gráficos/               # Gráficos generados
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
git clone https://github.com/raxolekder/analisis-cienciometrico.git
cd analisis-cienciometrico
```

En MATLAB, carga en el workspace los archivos "Matrizdeadyacencia.txt" y "Resumen.xlsx" y abre `creacion_grafo.m` y ejecuta:

```matlab
run('creacion_grafo.m')
```
---

📌 **Ejemplo de salida esperada**:  
![Ejemplo de gráfica](results/Gráficos/Nodo_Abul%20Bashar%20M%20798.png)

---

## **📝 Contacto**

📌 **Contacto**
Para preguntas o comentarios, puedes escribirme a:  
📧 [dparrav2200@alumno.ipn,mx](mailto:dparrav2200@alumno.ipn.mx)  

---

## **⚖️ Licencia**
Este proyecto fue desarrollado como trabajo de tesis para el Instituto Politécnico Nacional - Unidad Profesional Interdisciplinaria de Ingeniería y Ciencias Sociales y Administrativas (UPIICSA) . Todos los derechos reservados © 2025 IPN.
