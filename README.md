# Calcs
Thesis Calculations performed with R.

These files are used to support my MS thesis titled 
STOCHASTIC ESTIMATION OF GROUNDWATER RETURN FLOW AND DISSOLVED SELENIUM LOADING 
TO TWO REACHES OF THE ARKANSAS RIVER IN COLORADO

R, a programming language and software environment for statistical computing and graphics, was used for nearly all 
calculations.  This repo contains data and code for two independent flow and mass balance models.

The folder structure is incomplete since empty folders can't be pushed to GitHub.  The following structure of
empty folders is missing from the USR and DSR folders.

Models
  CSe
  Deterministic
  SA
  Stochastic
  Stochastic-A
  Stochastic-AS
  Stochastic-S
Plots
  CSe
  Deterministic
  SA
  Stochastic

Data file (*.Rdata) are not included in this repo.  If this is repo is used, it should be run on your local computer.
The project is run in a piece-meal fashion.  The input, intermediate, and final data sets are large (+/- 50MB) and
require significant computational time.  The code should run on both Windows and Mac environment, but I have not
completely tested the Windows environment.  The code was converted to the Mac file structure in early 2015.  It is
set up to support both environments in its current state.

Before running any of the R code, edit the R/USR/Pre-Loader.R and R/DSR/Pre-Loader.R files to match your installation
of the code.  I think all other file references (such as source()) have been removed from the individual files, and
and this will be verified with the most current pushes.

Folder structure description
  DSR - Downstream Study Reach deterministic, stochastic, and sensitivity analysis models
    Data - input data
    Models - intermediate and final data
    Plots - figures (pdfs)
    Results - output text files
    
  ExcelModels - Rough preliminary deterministic models created in Excel for the USR and DSR.
  
  R - All R code
    DSR - Stochastic model
    DSR CSe - Selenium concentration regression analysis
    DSR D - Deterministic model
    DSR SA - Sensitivity analsis model
    SubScripts - Code snippets used by multiple R code.
  
  RawData - Data obtained from sources in its unaltered state
  
  Survey - Data and preliminary processing of land survey data for multiple river cross sections
  
  USR - Upstream Study Reach deterministic, stochastic, and sensitivity analysis models
    Data - input data
    Models - intermediate and final data
    Plots - figures (pdfs)
    Results - output text files
