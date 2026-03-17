# Automatic early detection of pathological signs following primary total hip arthroplasty using radiographs, clinical scores, and comorbidities

This repository contains the code used for the analyses presented in the corresponding PLOS ONE manuscript.

## Repository structure
- `Matlab_preprocessing/`: MATLAB preprocessing scripts for radiograph preparation to be used for DL model training
- `JPEG Conversion.ipynb`: image conversion script
- `RX_modeltraining.ipynb`: radiographic model training
- `Comorbidity_HHS_model.ipynb`: clinical/comorbidity model
- `Combined_model.ipynb`: combined model
- `Bootstrapping_DCA_cal_combined.ipynb`: bootstrap, calibration, and decision curve analysis

## Requirements
- Python 3.x
- Jupyter Notebook
- MATLAB
- Required Python packages:

## Notes on data availability
The full dataset cannot be publicly shared due to privacy/ethical restrictions related to patient data. Code is provided to reproduce the workflow.
