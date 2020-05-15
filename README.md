# GettingCleaningDataCourseProject
### End Project Submission for the "Getting and Cleaning Data"" Course on Coursera

The mandate for the project was to write a script in R which will  

* read data from a specified location
* merge datasets from multiple files
* reduce and tidy the merged datasets
* output a single file with summarised data

Students are also required to provide a codebook explaining their script and dataset

#### Files in this repository

*run_analysis.R:* The R script which will download the data if required and then produce the required output.  
*codebook.md:* The codebook which describes the script and the data
  

#### Script Output
On execution, the script will write a file called summarydata.txt to the working directory.  This file can be read in to R with the command

```{r eval=FALSE} 
summarydata <- read.table("summarydata.txt")
```

The data has been tidied into a long/narrow format where the name of the variable being measured forms one of the columns in the output.
If you wish to switch to the wide format where each variable is a separate column, please use the following code.

```{r eval=FALSE}
library(tidyr)
summarydata <- spread(summarydata, key = 3, value = 4)
```

