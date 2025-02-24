# Cattle breeding for low methane emissions: From farm measurements to genetic progress

## Day 1 (Monday)

#### Introduction to Relivestock Project [slides](slides/0.1.Re-Livestock.Breedingcourse.Intro.pdf)

#### Overview of global GHG emissions and genetics developments for methane mitigation in ruminants (Hayden Montgomery - Global Methane Hub) [slides](slides/)

#### Introduction to Relivestock WP3 and to the course (Birgit Gredler-Grandl, WUR) [slides](slides/0_Gredler.Introduction-Overview.pdf)

### 1. Overview of global GHG emissions and genetics developments for methane mitigation in ruminants

### 2. Methane measurement techniques 
    
Laser device, Sniffers, Green Feed (Aser García Rodriguez and Idoia Goiri) [slides](slides/Methane_measurement_techniques_CIHEAM.pdf)

Overview of comparison between sniffers (Chantal van Gemeert, WUR) [slides]()

## Day 2 (Tuesday)


### 3. Working with Sniffer and GreenFeed data

Green Feed (Lisanne Koning - Wageningen University & Research) [slides](slides/Presentation_GreenFeed_ReLivestock_LK.pdf)

#### 3.1. Definition of methane phenotypes in Cattle (O. Gonzalez-Recio, C. Manzanilla-Pech)

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
  
#### 3.2. Practical work: Editing raw data from sniffer and greenfeed

#### Data from GreenFeed & C-Lock (Lisanne Koning, Wageningen University & Research

#### Server connection and practicalities

#### Data from Sniffers

  - Data set (files provided in Day1 folder)
  
  - Practical work on defining traits from sniffer data, baseline, and peak detection (Coralia)
  download data set from Day 1: (Day1/input_raw.txt)

 - Access Annuna cluster: https://notebook.anunna.wur.nl
 - Choose Relivestock course
 - Open New
 - Open terminal
 - Clone git hub 

````
git clone https://github.com/ogrecio/RelivestockMethaneCourse
cd Day1

````

- Open the Rscript.ipnyb (doble click in the file) inside Day1 in Home (Annuna Jupyter Notebook)
- Run the Jupyter Notebook [sniffer data](data/herd_sniffer101_Loggy_48sg.txt.zip): Rscript.ipnyb interactively
- Exercise: Calculate correlations between traits
  
  - How to align [R script](data/herd_sniffer101_Loggy_48sg.txt.zip) to [robot data](data/herd_robot101.csv)
  we need output files from sniffer and robot. We check the format. Then we use the tool SnifferAnalyzer, which is executed as:
SnifferAnalyzer <robot_output_file> <sniffer_output_file> lag_between_sniffer_and_robot_in_seconds
  
  ```
   ml use /lustre/shared/Courses/RELIVESTOCK2025/modules

   module load SnifferAnalyzer

   sniffer_analyzer herd_robot101.csv herd_sniffer101_Loggy_42s_FD1.txt 42
  ```
  
  -  This can be run through the [bashfile] (Day1/bash.sh) too or manually in the terminal by the command above
  - How to align sniffer data to robot data
  - Align output to test day data. [script](Day1/merge_sniffer_testday.ipynb)

  - Basic data analysis (Ester part)

### 4. Genetic analysis of methane data

#### 4.1.– 4.2. Estimation of genetic parameters and genetic models for methane emission (B. Gredler-Grandl, C. Manzanilla-Pech)

#### Introduction to ASReml
- User guide -> [functional specification](ASReml-4.2-Functional-Specification.pdf)
- User guide -> [structural specification](ASReml-4.2-Structural-Specification.pdf)

#### 4.1.– 4.2. Estimation of genetic parameters and genetic models for methane emission (B. Gredler-Grandl, C. Manzanilla-Pech)

     - Overview of genetic parameter estimation, repeatability model and random regression. Fixed and random effects.
     - Brief explanation of ASReml software, input files (.as files, data and pedigree), output files (.asr, .sln, .pvc, .res)
     - Examples of univariate and bivariate analyses and random regression
     - Practical: Estimation of genetic parameters in ASReml (data and scripts in Day2) for univariate, bivariate and RR models
         -Can be run using the bash2.sh files o directly in the terminal

#### 4.3. Discussion session: Estimation of genetic parameters and genetic models for methane emission

  - Results of genetic parameters from inter-country analyses: 2 examples
  
  - Open discussion about aspects related to covariance estimation for methane traits and other aspects related to genetic/genomic evaluations.

## Day 3 (Wednesday)

### 5. Overview of proxies to estimate methane emission.

#### 5.1. Mid infrared spectra

  Invited Speaker: Amelie Vanlierde - Walloon Agricultural Research Centre, Belgium.
    
#### 5.2. Microbiome 

   State of the art in Spain: O. Gonzalez Recio - INIA-CSIC
   
   State of the art in New Zealand: Suzanne Rowe (Invited Speaker) AgResearch, New Zealand.

## Day 4 (Thursday)

### 6. Implementation of methane traits in breeding programs 

#### 6.2. Case study: Spain (O. Gonzalez Recio, INIA-CSIC)

-Genetic evaluations for methane traits (progress this far)

-Including methane in the breeding goal of Spanish Dairy Cattle (future perspectives)

#### 6.3. Other cases of study from invited speakers 

- Spain (Oscar Gonzalez-Recio - INIA-CSIC) 

- Australia (Jennie Pryce - Agriculture Victoria)   
  
- New Zealand (Lorna McNaughton, LIC) 

- Canada (Filippo Miglior - Lactanet & University of Guelph) 

- The Netherlands (Chris Orret - CRV)
  
### 6.4. Discussion session. 

Open discussion and questions about how to incorporate methane traits in breeding programs.

### Summary and Final remarks



