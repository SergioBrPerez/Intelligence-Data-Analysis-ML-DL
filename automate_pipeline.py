import papermill as pm
import os

notebooks = [
    "0-Data_Generation/0.0-Prologie_Analysis_SBP.ipynb",
    "0-Data_Generation/0.1-DoubleDigit_MNIST_Generation_SBP.ipynb",
    "0-Data_Generation/0.2-MainData_Preparation_SBP.ipynb",
    "1-ETL_Integration/1.1-CNN_Training_and_Evaluation_SBP.ipynb",
    "1-ETL_Integration/1.2-CNN_Inference_and_Integration_SBP.ipynb",
    "1-ETL_Integration/1.3-Feature_Engenieering_SBP.ipynb",
    "1-ETL_Integration/1.4-K-means_Filtering_SBP.ipynb",
    "2-Intelligence/2.1-State_Analysis_&_Model_Selection_SBP.ipynb",
    "3-Clasification_Model/3.1-Training_and_Evaluation_SBP.ipynb",
    "3-Clasification_Model/3.2-Hyperparam_Optimization_SBP.ipynb",
    "4-Regresion_Model/4.1-Multi_Model_Comparison_SBP.ipynb",
    "4-Regresion_Model/4.2-Training_and_Evaluation_SBP.ipynb",
]

def run_pipeline():
    for nb in notebooks:
        output_nb = nb.replace(".ipynb", "_EXECUTED.ipynb")
        print(f"--- 🏃 Executing: {nb} ---")
        try:
            pm.execute_notebook(nb, output_nb)
            print(f"--- ✅ Success: {output_nb} generated ---\n")
        except Exception as e:
            print(f"--- ❌ Error in {nb}: {e} ---")
            break # Detener si falla un paso crítico

if __name__ == "__main__":
    run_pipeline()