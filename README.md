# Automatic early detection of pathological signs following primary total hip arthroplasty using radiographs, clinical scores, and comorbidities

This repository contains the code used for the analyses presented in the PLOS ONE manuscript entitled *"Automatic early detection of pathological signs following primary total hip arthroplasty using radiographs, clinical scores, and comorbidities"*.

## Repository structure
- `Matlab_preprocessing/`: MATLAB preprocessing scripts for radiograph preparation prior to deep learning model training
- `JPEG Conversion.ipynb`: script for image conversion
- `RX_modeltraining.ipynb`: radiographic model training
- `Comorbidity_HHS_model.ipynb`: clinical and comorbidity-based model training
- `Combined_model.ipynb`: combined model training and evaluation
- `Bootstrapping_DCA_cal_combined.ipynb`: bootstrap analysis, calibration assessment, and decision curve analysis

## Requirements
- Python 3.x
- Jupyter Notebook
- MATLAB
- Python packages listed in `requirements.txt`

## MATLAB requirements
The scripts contained in `Matlab_preprocessing/` require MATLAB. Some functions may also require the Image Processing Toolbox.
## Workflow
The analysis workflow should be executed in the following order:

1. `Matlab_preprocessing/`  
   Preprocess the radiographic images using the MATLAB scripts contained in this folder.

2. `JPEG Conversion.ipynb`  
   Convert the preprocessed images into JPEG format for subsequent model development.

3. `RX_modeltraining.ipynb`  
   Train and evaluate the radiographic model.

4. `Comorbidity_HHS_model.ipynb`  
   Train and evaluate the clinical/comorbidity-based model.

5. `Combined_model.ipynb`  
   Develop and evaluate the combined model integrating radiographic, clinical, and comorbidity information.

6. `Bootstrapping_DCA_cal_combined.ipynb`  
   Perform bootstrap-based performance assessment, calibration analysis, and decision curve analysis for the combined model.
   
## Notes on data availability
The full dataset cannot be publicly shared due to privacy and ethical restrictions related to patient data.
Code is provided to reproduce the analysis workflow. Data may be made available upon reasonable request to: `cetlombardia5@humanitas.it`

