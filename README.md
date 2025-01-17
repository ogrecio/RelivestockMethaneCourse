# RelivestockMethaneCourse

## Tuesday 25

### 3.1. Definition of methane phenotypes in Cattle (O. Gonzalez-Recio, C. Manzanilla-Pech)

  -type of methane traits for beef or dairy (Coralia & Oscar)
  
  -particularites, advantages and disadvantges of the traits (Coralia & Oscar)

  -From concentration to production
  
  -Calculation of baseline from sniffer in different countries (Coralia & Oscar)
  
  -Example of data from GreenFeed (Oscar or Birgit?)
  
  -Workflow for alignment from sniffer data (Oscar)
  
    -Case of Spain
    
    -Case of Denmark
    
    -Case of The Netherlands
  
### 3.2. Practical work: Editing raw data from sniffer and greenfeed

  -Data set (files provided)
  
  -Practical work on defining traits from sniffer data, baseline, and peak detection (Coralia)
  download data set from [here](data/output.txt.zip)
  
  -Oscar's program to align sniffer data to robot data
  we need output files from sniffer and robot. We check the format. Then we use the tool SnifferAnalyzer, which is executed as:
  
  ```
    ./SnifferAnalyzer <robot_output_file> <sniffer_output_file> lag_between_sniffer_and_robot_in_seconds
  ```

For instance, with the example files we use in the course we execute it as:  
  
  ```
    ./SnifferAnalyzer herd_robot101.csv herd_sniffer101_Loggy_42s_FD1.txt 42
  ```
  
  Make sure the Sniffer Analyzer is executable ```chmod +x SnifferAnalyzer```
  
  
  -

### 4.1.– 4.2. Estimation of genetic parameters and genetic models for methane emission (B. Gredler-Grandl, C. Manzanilla-Pech)

-

-

## Wednesday 26

### 5.1. Overview of proxies to estimate methane emission. Mid infrared spectra (A. Vanlierde)

### 5.2. Overview of proxies to estimate methane emission. Microbiome (O. Gonzalez Recio, Suzanne Rowe)

## Thursday 27

### 6.1 – 6.2. Implementation of methane traits in breeding programs (O. Gonzalez Recio)

### 6.3. Case study: Examples of implementation methane traits in breeding programs: 
  
  -Australia
  
  -New Zealand
  
  -Spain

### Summary and Final remarks



