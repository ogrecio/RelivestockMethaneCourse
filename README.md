# RelivestockMethaneCourse

## Monday 24

### 2.1-2.5 Methane measurement techniques 
    
[slides](slides/Methane_measurement_techniques_CIHEAM.pdf)

## Tuesday 25

### 3.1. Definition of methane phenotypes in Cattle (O. Gonzalez-Recio, C. Manzanilla-Pech)

  -type of methane traits for beef or dairy
  
  -particularites, advantages and disadvantges of the traits

  -From concentration to production
  
  -Calculation of baseline from sniffer in different countries
    
  -Practicalities for filtering and alignment data from sniffer and AMS
  
    -Case of Spain
    
    -Case of Denmark
    
    -Case of The Netherlands
  
### 3.2. Practical work: Editing raw data from sniffer and greenfeed

#### Data from GreenFeed & C-Lock (Lisanne Koning, Wageningen University & Research

#### Server connection and practicalities

#### Data from Sniffers

  - Data set (files provided)
  
  - Practical work on defining traits from sniffer data, baseline, and peak detection (Coralia)
  download data set from [here](data/output.txt.zip)
  
  - How to align [sniffer data](data/herd_sniffer101_Loggy_48sg.txt.zip) to [robot data](data/herd_robot101.csv)
  we need output files from sniffer and robot. We check the format. Then we use the tool SnifferAnalyzer, which is executed as:
  
  ```
    module load 
    ./SnifferAnalyzer <robot_output_file> <sniffer_output_file> lag_between_sniffer_and_robot_in_seconds
  ```
  
  - How to align sniffer data to robot data
  - Align output to test day data. [script](Rscripts/merge_sniffer_testday.ipynb)

  - Basic data analysis


### 4.1.– 4.2. Estimation of genetic parameters and genetic models for methane emission (B. Gredler-Grandl, C. Manzanilla-Pech)

#### Introduction to ASReml
- User guide -> [functional specification](ASReml-4.2-Functional-Specification.pdf)
- User guide -> [structural specification](ASReml-4.2-Structural-Specification.pdf)

## Wednesday 26

### 4.1.– 4.2. Estimation of genetic parameters and genetic models for methane emission (B. Gredler-Grandl, C. Manzanilla-Pech)

     Continue

### 4.3. Discussion session: Estimation of genetic parameters and genetic models for methane emission

  Open discussion about aspects related to covariance estimation for methane traits and other aspects related to genetic/genomic evaluations.

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

#### Australia (Jennie Pryce - Agriculture Victoria) 
  
#### Canada (Filippo Miglior - Lactanet & University of Guelph) 
  
#### New Zealand (Suzanne Rowe, AgResearch) 

#### The Netherlands (Chris Orret - CRV)
  
### 6.4. Discussion session. 

Open discussion and questions about how to incorporate methane traits in breeding programs.

### Summary and Final remarks



