pollutantmean <- function(directory, pollutant, id = 1:332) {
  temp_data <- data.frame()
  for(i in id){
    if(i < 10) {
      name <- paste("00", i, ".csv", sep = "")
    } else if (i > 9 & i < 100) {
      name <- paste("0", i, ".csv", sep = "")
    } else {
      name <- paste(i, ".csv", sep ="")
    }
    name <- paste(dir, "/", name, sep = "")
    data <- read.csv(name)
    temp_data <- rbind(data, temp_data)
  }
  mean(temp_data[[pollutant]], na.rm = TRUE)
}

complete <- function(directory, id = 1:332) 
{
  nob_frame <- data.frame()
  count <- TRUE
  for(i in id){
    if(i < 10) {
      name <- paste("00", i, ".csv", sep = "")
    } else if (i > 9 & i < 100) {
      name <- paste("0", i, ".csv", sep = "")
    } else {
      name <- paste(i, ".csv", sep ="")
    }
    name <- paste(dir, "/", name, sep = "")
    data <- read.csv(name)
    complete_cases <- sum(complete.cases(data))
    if(count == TRUE){
      nob_frame <- data.frame(id = i, nobs = complete_cases)
      count <- FALSE
    } else {
      nob_frame <- rbind(nob_frame, list(i, complete_cases))
    }
  }
  nob_frame
}

corr <- function(directory, threshold = 0){
  cor_results <- numeric(0)
  complete_cases <- complete(directory)
  complete_cases <- complete_cases[complete_cases$nobs>=threshold, ]
  
  if(nrow(complete_cases)>0){
    for(monitor in complete_cases$id){
      path <- paste(getwd(), "/", directory, "/", sprintf("%03d", monitor), ".csv", sep = "")
      monitor_data <- read.csv(path)
      interested_data <- monitor_data[(!is.na(monitor_data$sulfate)), ]
      interested_data <- interested_data[(!is.na(interested_data$nitrate)), ]
      sulfate_data <- interested_data["sulfate"]
      nitrate_data <- interested_data["nitrate"]
      cor_results <- c(cor_results, cor(sulfate_data, nitrate_data))
    }
  }
  cor_results
}

corr <- function(directory, threshold = 0, id = 1: 332) {
  vector1 <- numeric(0)
  temp_data <- data.frame()
  complete_frame <- complete(directory, id)
  complete_frame <- complete_frame[complete_frame$nobs<=threshold, ]
  if(nrow(complete_frame) > 0){
    for(i in id){
      if(i < 10) {
        name <- paste("00", i, ".csv", sep = "")
      } else if (i > 9 & i < 100) {
        name <- paste("0", i, ".csv", sep = "")
      } else {
        name <- paste(i, ".csv", sep ="")
      }
      name <- paste(dir, "/", name, sep = "")
      data <- read.csv(name)
      temp_data <- rbind(data, temp_data)
    }
    interested_data <- temp_data[(!is.na(temp_data$sulfate)), ]
    interested_data <- temp_data[(!is.na(temp_data$nitrate)), ]
    sulfate_data <- interested_data["sulfate"]
    nitrate_data <- interested_data["nitrate"]
    vector1 <- c(vector1, cor(sulfate_data, nitrate_data))
  } else {
    vector1
  }
}