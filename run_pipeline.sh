#!/bin/bash

echo "🚀 Starting Full Data & ML Pipeline..."
echo "======================================"

# 1. Define the exact execution order in an array
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
    #"3-Clasification_Model/3.2-Hyperparam_Optimization_SBP.ipynb"
    "4-Regresion_Model/4.1-Multi_Model_Comparison_SBP.ipynb"
    "4-Regresion_Model/4.2-Training_and_Evaluation_SBP.ipynb"
)

# 2. Loop through each notebook and execute it
for nb in "${NOTEBOOKS[@]}"; do
    # Extract just the filename for a cleaner print statement
    nb_name=$(basename "$nb")
    
    echo "--- 🏃 Executing: $nb_name ---"
    
    # Run the notebook. If it fails, print an error and stop the whole script.
    if jupyter nbconvert --to notebook --execute --inplace "$nb"; then
        echo "--- ✅ Success ---"
        echo ""
    else
        echo "======================================"
        echo "❌ CRITICAL ERROR: Failed while executing $nb_name."
        echo "🛑 Pipeline halted."
        exit 1
    fi
done

echo "======================================"
echo "🎉 All notebooks executed successfully!"