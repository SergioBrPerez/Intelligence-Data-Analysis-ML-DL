# Proyecto Final: Análisis Inteligente de Datos en E-commerce

## Descripción del Proyecto
Este proyecto aborda un problema logístico real utilizando técnicas de Machine Learning y Deep Learning. El objetivo principal es analizar una base de datos de comercio electrónico para intentar **predecir el retraso de los pedidos** (Clasificación) y **estimar el tiempo real de envío** (Regresión). 

Como valor añadido y para aumentar la complejidad del reto, el proyecto integra el procesamiento de imágenes, obligando al sistema a inferir características espaciales (como las provincias o estados) a partir de imágenes numéricas generadas sintéticamente mediante Redes Neuronales Convolucionales (CNN).

## Objetivos Alcanzados
* **Análisis Exploratorio de Datos (EDA):** Detección de patrones geográficos y logísticos.
* **Preparación de Datos:** Limpieza de nulos, eliminación de *outliers* mediante clustering (K-Means) e ingeniería de características (volumen, temporalidad).
* **Deep Learning:** Inferencia de datos tabulares a partir de tensores de imágenes (`.pt`) de dígitos combinados (basados en MNIST).
* **Modelado de Clasificación:** Intento de predicción de retrasos (binario) utilizando LightGBM, Optuna y AutoML.
* **Modelado de Regresión:** Predicción de los días reales de entrega utilizando modelos de Gradient Boosting (LGBM, CatBoost), superando ampliamente las estimaciones originales de la empresa.

## Fuente de Datos
* **Olist Dataset:** Dataset público de la empresa brasileña de e-commerce Olist, obtenido a través de [Kaggle](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce).
* **MNIST Dataset:** Utilizado para la generación de la base de datos de imágenes numéricas de dos dígitos (representando los códigos de estado/provincia).

## Tecnologías y Dependencias Principales
El proyecto está desarrollado principalmente en **Python 3** (se recomienda versión 3.12).

* **Entorno:** Jupyter Notebooks, Visual Studio Code.
* **Manipulación y Análisis de Datos:** `pandas`, `numpy`.
* **Machine Learning (Scikit-Learn, Optuna, AutoML):** `KMeans`, `LinearRegression`, `BayesianRidge`, `HistGradientBoosting`.
* **Modelos de Boosting:** `LightGBM`, `XGBoost`, `CatBoost`.
* **Deep Learning:** Entorno para el entrenamiento de la CNN y manejo de archivos `.pt` (típicamente `PyTorch`).
* **Despliegue y Automatización:** `Docker`, `Docker Compose`, `Shell Scripting`.

## Estructura del Proyecto
El flujo de trabajo se divide en 5 fases principales, ordenadas en carpetas secuenciales:

* 📁 **0_Exploracion_y_Generacion:**
    * `0.0`: Exploración inicial (Business & Data Understanding).
    * `0.1`: Generación de imágenes numéricas (MNIST).
    * `0.2`: Fusión de datos y creación de tensores `.pt`.
* 📁 **1_Preparacion_Datos:** * `1.1`: Entrenamiento de la CNN para inferencia de imágenes.
    * `1.2`: Inferencia y cruce de datos tabulares.
    * `1.3`: Ingeniería de características (Feature Engineering).
    * `1.4`: Limpieza de datos (Imputación y filtrado de outliers con K-Means).
* 📁 **2_Estudio_Datos:**
    * `2.1`: Análisis subjetivo de distribuciones post-ingeniería.
* 📁 **3_Modelado_Clasificacion:** * `3.1`: Entrenamiento inicial LightGBM (is_delayed).
    * `3.2`: Optimización con Optuna y AutoML.
* 📁 **4_Modelado_Regresion:**
    * `4.1`: Evaluación de múltiples modelos de regresión (actual_delivery_days).
    * `4.2`: Ajuste final del modelo LGBM ganador.
* 📁 **data/**: Almacenamiento de datasets en crudo y procesados.
* 📁 **models/**: Almacenamiento de los modelos entrenados (CNN, LGBM, etc.).

## Resultados Principales
1.  **Clasificación (Predicción de Retrasos):** El modelo demostró que las características logísticas no son suficientes para predecir retrasos de manera fiable (F1-Score bajo). Se descubrió que esto se debe a que la empresa sugiere fechas de entrega artificialmente pesimistas para inflar sus métricas de éxito.
2.  **Regresión (Predicción de Días de Entrega):** El modelo **LightGBM** logró un MAE de 4.05 días y un RMSE de 7.08 días, reduciendo el error en más de un **60%** respecto a las estimaciones legacy de la empresa (MAE: 12.92, RMSE: 15.43). Además, el modelo predice sin el sesgo profundamente pesimista del algoritmo original.

## Instrucciones de Ejecución

El proyecto está dockerizado para garantizar la reproducibilidad y automatizar la ejecución secuencial de todos los notebooks a través del script `run_pipeline.sh`.

### Requisitos Previos
* Tener instalado [Docker](https://www.docker.com/) y Docker Compose en tu sistema.

### Pasos para ejecutar:
1. Clona este repositorio y navega hasta la raíz del proyecto en tu terminal.
2. Construye la imagen de Docker:
   ```bash
   docker compose build
   ```
3. Ejecuta el pipeline completo:
   ```bash
   docker compose up
   ```
   
