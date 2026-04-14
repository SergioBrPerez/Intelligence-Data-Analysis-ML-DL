# Final Project: Intelligent Data Analysis in E-commerce

## Project Description
This project addresses a real logistics problem using Machine Learning and Deep Learning techniques. The main objective is to analyze an e-commerce database to attempt to **predict order delays** (Classification) and **estimate the actual shipping time** (Regression). 

As an added value and to increase the complexity of the challenge, the project integrates image processing, forcing the system to infer spatial features (such as provinces or states) from synthetically generated numerical images using Convolutional Neural Networks (CNNs).

## Achieved Objectives
* **Exploratory Data Analysis (EDA):** Detection of geographic and logistical patterns.
* **Data Preparation:** Null cleaning, *outlier* removal through clustering (K-Means), and feature engineering (volume, seasonality).
* **Deep Learning:** Inference of tabular data from image tensors (`.pt`) of combined digits (based on MNIST).
* **Classification Modeling:** Attempt to predict delays (binary) using LightGBM, Optuna, and AutoML.
* **Regression Modeling:** Prediction of actual delivery days using Gradient Boosting models (LGBM, CatBoost), vastly outperforming the company's original estimates.

## Data Source
* **Olist Dataset:** Public dataset from the Brazilian e-commerce company Olist, obtained via [Kaggle](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce).
* **MNIST Dataset:** Used to generate the database of two-digit numerical images (representing state/province codes).

## Main Technologies and Dependencies
The project is mainly developed in **Python 3** (version 3.12 recommended).

* **Environment:** Jupyter Notebooks, Visual Studio Code.
* **Data Manipulation and Analysis:** `pandas`, `numpy`.
* **Machine Learning (Scikit-Learn, Optuna, AutoML):** `KMeans`, `LinearRegression`, `BayesianRidge`, `HistGradientBoosting`.
* **Boosting Models:** `LightGBM`, `XGBoost`, `CatBoost`.
* **Deep Learning:** Environment for training the CNN and handling `.pt` files (typically `PyTorch`).
* **Deployment and Automation:** `Docker`, `Docker Compose`, `Shell Scripting`.

## Project Structure
The workflow is divided into 5 main phases, organized in sequential folders:

* 📁 **0_Exploracion_y_Generacion:**
    * `0.0`: Initial exploration (Business & Data Understanding).
    * `0.1`: Generation of numerical images (MNIST).
    * `0.2`: Data merging and creation of `.pt` tensors.
* 📁 **1_Preparacion_Datos:**
    * `1.1`: CNN training for image inference.
    * `1.2`: Inference and cross-referencing of tabular data.
    * `1.3`: Feature Engineering.
    * `1.4`: Data cleaning (Imputation and outlier filtering with K-Means).
* 📁 **2_Estudio_Datos:**
    * `2.1`: Subjective analysis of post-engineering distributions.
* 📁 **3_Modelado_Clasificacion:**
    * `3.1`: Initial LightGBM training (is_delayed).
    * `3.2`: Optimization with Optuna and AutoML.
* 📁 **4_Modelado_Regresion:**
    * `4.1`: Evaluation of multiple regression models (actual_delivery_days).
    * `4.2`: Final tuning of the winning LGBM model.
* 📁 **data/**: Storage of raw and processed datasets.
* 📁 **models/**: Storage of trained models (CNN, LGBM, etc.).

## Main Results
1.  **Classification (Delay Prediction):** The model demonstrated that logistical features are not sufficient to reliably predict delays (low F1-Score). It was discovered that this is because the company suggests artificially pessimistic delivery dates to inflate their success metrics.
2.  **Regression (Delivery Days Prediction):** The **LightGBM** model achieved a MAE of 4.05 days and an RMSE of 7.08 days, reducing the error by more than **60%** compared to the company's legacy estimates (MAE: 12.92, RMSE: 15.43). Furthermore, the model predicts without the deeply pessimistic bias of the original algorithm.

## Execution Instructions

The project is dockerized to ensure reproducibility and automate the sequential execution of all notebooks through the `run_pipeline.sh` script.

### Prerequisites
* Have [Docker](https://www.docker.com/) and Docker Compose installed on your system.

### Steps to run:
1. Clone this repository and navigate to the root of the project in your terminal.
2. Build the Docker image:
   ```bash
   docker compose build
   ```
3. Run the complete pipeline:
   ```bash
   docker compose up
   ```
   
