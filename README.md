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

* 📁 **0-Data_Generation:**
    * `0.0`: **Initial exploration (Business & Data Understanding).** Analyzes data types, nulls, and geographical distributions. Identifies that most sellers are concentrated in big cities and establishes the hypothesis that delays correlate with long distances or remote areas like the Amazon.
    * `0.1`: **Generation of numerical images (MNIST).** Creates a synthetic dataset of two-digit images (fused from MNIST) representing state codes. This step artificially increases the project's technical complexity.
    * `0.2`: **Data merging and creation of `.pt` tensors.** Replaces textual state labels with numerical codes (0-27). Integrates order data with the newly generated state images, saving them into PyTorch tensors (`.pt`) for customers and sellers, alongside a base tabular dataset.
* 📁 **1-ETL_Integration:**
    * `1.1`: **CNN training for image inference.** Trains a Convolutional Neural Network from scratch to accurately recognize the synthetic two-digit state images generated in the previous phase.
    * `1.2`: **Inference and cross-referencing of tabular data.** Uses the trained CNN to infer the numerical state codes from the `.pt` image tensors, merging this predicted data back into the main tabular database for future training.
    * `1.3`: **Feature Engineering.** Defines target variables (a boolean for delays and a continuous variable for delivery days). Generates new features like product volume, order seasonality (day/month), and an out-of-province flag. Removes post-order variables (like customer reviews) to prevent data leakage.
    * `1.4`: **Data cleaning.** Imputes minor null values using the median. Addresses outliers using a multidimensional K-Means clustering approach (defining 5 clusters and filtering the 99th percentile), which safely removes about 3.8% of the most extreme anomalous records.
* 📁 **2-Intelligence:**
    * `2.1`: **Subjective analysis of post-engineering distributions.** Analyzes the cleaned dataset, revealing that over 90% of orders are not delayed. It highlights that the company's estimated delivery dates are heavily and artificially pessimistic, and observes geographical shipment patterns (e.g., most shipments are intra-province, highest density in Sao Paulo).
* 📁 **3-Clasification_Model:**
    * `3.1`: **Initial LightGBM training (is_delayed).** First attempt to predict binary delays based on logistical features. Yields a misleadingly high accuracy (>90%) due to class imbalance, but a low F1-Score (~0.41), exposing the model's struggle to reliably catch true delays.
    * `3.2`: **Optimization with Optuna and AutoML.** Attempts to boost the F1-Score using hyperparameter optimization (Optuna) and AutoML frameworks. The failure to secure significant improvements leads to the conclusion that logistical features cannot predict the inconsistent, artificially pessimistic delay metrics set by the company.
* 📁 **4-Regression_Model:**
    * `4.1`: **Evaluation of multiple regression models (actual_delivery_days).** Pivots the project scope to predict the *actual* number of delivery days. Benchmarks several models (Linear, Ridge, LGBM, XGBoost, CatBoost), finding that all of them, particularly CatBoost and LGBM, vastly outperform the company's legacy estimates.
    * `4.2`: **Final tuning of the winning LGBM model.** Fine-tunes the LightGBM model with stricter hyperparameters. Achieves a Mean Absolute Error (MAE) of 4.05 days (compared to the company's 12.92 days). The model centers its error around zero, successfully removing the extreme pessimistic bias of the legacy algorithm and closely mirroring real delivery behavior.
* 📁 **5-Feature_Importance:**
    * `5.1`: **Feature Importance Evaluation.** loads pre-trained LightGBM classification and regression models from disk and analyzes their feature importance. It visualizes how each input variable contributes to the models’ decisions, helping interpret and compare their behavior. 

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
