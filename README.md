# RelivestockMethaneCourse

## Monday 24

### 2.1-2.5 Methane measurement techniques 
    
Laser device, Sniffers, Green Feed (Aser García Rodriguez and Idoia Goiri) [slides](slides/Methane_measurement_techniques_CIHEAM.pdf)

Overview of comparison between sniffers (Chantal van Gemeert, WUR) [slides]()

## Tuesday 25

Green Feed (Lisanne Koning) [slides](slides/Presentation_GreenFeed_ReLivestock_LK.pdf)

### 3.1. Definition of methane phenotypes in Cattle (O. Gonzalez-Recio, C. Manzanilla-Pech)

  - Type of methane traits: methane concentration, methane production and other methane traits
  -    methane concentration phenotypes
  -    methane production phenotypes
            - from concentration to production
            - different formulas (Madsen, Kjeldsen, etc)
  -    residual methane, methane intensity and methane yield
  
  - Particularites, advantages and disadvantges of the traits
  
  -Calculation of baseline from sniffer in different countries
    
  -Practicalities for filtering and alignment data from sniffer and AMS
  
    -Case of Spain
    
    -Case of The Netherlands
  
### 3.2. Practical work: Editing raw data from sniffer and greenfeed

#### Data from GreenFeed & C-Lock (Lisanne Koning, Wageningen University & Research

#### Server connection and practicalities

#### Data from Sniffers

  - Data set (files provided in Day1 folder)
  
  - Practical work on defining traits from sniffer data, baseline, and peak detection (Coralia)
  download data set from Day 1: (input_raw.txt)

 - Access Annuna cluster: https://notebook.anunna.wur.nl
 - Choose Relivestock course
 - Open New
 - Open terminal
 - Clone git hub 

````
git clone https://github.com/ogrecio/RelivestockMethaneCourse
cd Day1

````

- Open the Rscript.ipnyb (doble click in the file)
- Run the Jupyter Notebook R script: Rscript.ipnyb interactively
- Exercise: Calculate correlations between traits
  
  - How to align [sniffer data](data/herd_sniffer101_Loggy_48sg.txt.zip) to [robot data](data/herd_robot101.csv)
  we need output files from sniffer and robot. We check the format. Then we use the tool SnifferAnalyzer, which is executed as:
  
  ```
    module load 
    ./SnifferAnalyzer <robot_output_file> <sniffer_output_file> lag_between_sniffer_and_robot_in_seconds
  ```
  - This can be run trhough the bash.sh too or manually in the terminal
  - How to align sniffer data to robot data
  - Align output to test day data. [script](Day1/merge_sniffer_testday.ipynb)

  - Basic data analysis


### 4.1.– 4.2. Estimation of genetic parameters and genetic models for methane emission (B. Gredler-Grandl, C. Manzanilla-Pech)

#### Introduction to ASReml
- User guide -> [functional specification](ASReml-4.2-Functional-Specification.pdf)
- User guide -> [structural specification](ASReml-4.2-Structural-Specification.pdf)

## Wednesday 26

### 4.1.– 4.2. Estimation of genetic parameters and genetic models for methane emission (B. Gredler-Grandl, C. Manzanilla-Pech)

     - Overview of genetic parameter estimation, repeatability model and random regression. Fixed and random effects.
     - Brief explanation of ASReml software, input files (.as files, data and pedigree), output files (.asr, .sln, .pvc, .res)
     - Examples of univariate and bivariate analyses and random regression
     - Practical: Estimation of genetic parameters in ASReml (data and scripts in Day2) for univariate, bivariate and RR models
         -Can be run using the bash2.sh files o directly in the terminal

### 4.3. Discussion session: Estimation of genetic parameters and genetic models for methane emission

  - Results of genetic parameters from inter-country analyses: 2 examples
  
  - Open discussion about aspects related to covariance estimation for methane traits and other aspects related to genetic/genomic evaluations.

### 5.1. Overview of proxies to estimate methane emission. Mid infrared spectra (A. Vanlierde)

  Invited Speaker: Amelie Vanlierde - Walloon Agricultural Research Centre, Belgium.
    
### 5.2. Overview of proxies to estimate methane emission. Microbiome 

   State of the art in Spain: O. Gonzalez Recio - INIA-CSIC
   
   State of the art in New Zealand: Suzanne Rowe (Invited Speaker) AgResearch, New Zealand.

## Thursday 27

### 6.1. Implementation of methane traits in breeding programs 

#### 6.2. Case study: Spain (O. Gonzalez Recio, INIA-CSIC)

-Genetic evaluations for methane traits (progress this far)

-Including methane in the breeding goal of Spanish Dairy Cattle (future perspectives)

### 6.3. Other cases of study from invited speakers 

#### Spain (Oscar Gonzalez-Recio - INIA-CSIC) 

#### Australia (Jennie Pryce - Agriculture Victoria)   
  
#### New Zealand (Lorna McNaughton, LIC) 

#### Canada (Filippo Miglior - Lactanet & University of Guelph) 

#### The Netherlands (Chris Orret - CRV)
  
### 6.4. Discussion session. 

Open discussion and questions about how to incorporate methane traits in breeding programs.

### Summary and Final remarks



