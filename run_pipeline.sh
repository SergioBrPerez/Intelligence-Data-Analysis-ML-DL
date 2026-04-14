#!/bin/bash

# ANSI color codes
CYAN='\033[0;36m'
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Define pipeline execution sequence
NOTEBOOKS=(
    "0-Data_Generation/0.0-Prologie_Analysis_SBP.ipynb"
    "0-Data_Generation/0.1-DoubleDigit_MNIST_Generation_SBP.ipynb"
    "0-Data_Generation/0.2-MainData_Preparation_SBP.ipynb"
    "1-ETL_Integration/1.1-CNN_Training_and_Evaluation_SBP.ipynb"
    "1-ETL_Integration/1.2-CNN_Inference_and_Integration_SBP.ipynb"
    "1-ETL_Integration/1.3-Feature_Engenieering_SBP.ipynb"
    "1-ETL_Integration/1.4-K-means_Filtering_SBP.ipynb"
    "2-Intelligence/2.1-State_Analysis_&_Model_Selection_SBP.ipynb"
    "3-Clasification_Model/3.1-Training_and_Evaluation_SBP.ipynb"
    "3-Clasification_Model/3.2-Hyperparam_Optimization_SBP.ipynb"
    "4-Regresion_Model/4.1-Multi_Model_Comparison_SBP.ipynb"
    "4-Regresion_Model/4.2-Training_and_Evaluation_SBP.ipynb"
)

echo "Starting pipeline execution..."

# Sequential execution loop
for nb in "${NOTEBOOKS[@]}"; do
    nb_name=$(basename "$nb")
    
    # Starting status in Cyan
    echo -e "${CYAN}[STARTING]${NC} $nb_name"
    
    if jupyter nbconvert --to notebook --execute --inplace "$nb"; then
        # Finished status in Green
        echo -e "${GREEN}[FINISHED]${NC} $nb_name"
        echo "--------------------------------------"
    else
        # Error status in Red
        echo -e "${RED}[ERROR]${NC} Execution failed at $nb_name. Aborting."
        exit 1
    fi
done

echo "Pipeline execution complete."