library(jsonlite)
library(move)
source("logger.R")
source("RFunction.R")

inputFileName = "threeindv.rds" # threeindv.rds sixtyindiv.rds oneindiv.rds oneindivMS.rds
outputFileName = "output.rds"

args <- list()

#################################################################
########################### Arguments ###########################
# The data parameter will be added automatically if input data is available
# The name of the field in the vector must be exactly the same as in the r function signature
# Example:
# rFunction = function(username, password)
# The parameter must look like:
#    args[["username"]] = "any-username"
#    args[["password"]] = "any-password"

# Add your arguments of your r function here
# args[["unitsPLOT"]] = "km"

#################################################################
#################################################################

readInput <- function(sourceFile) {
  input <- NULL
  if(!is.null(sourceFile) && sourceFile != "") {
    logger.debug("Loading file from %s", sourceFile)
    input <- tryCatch({
        # 1: try to read input as move RDS file
        readRDS(file = sourceFile)
      },
      error = function(readRdsError) {
        tryCatch({
          # 2 (fallback): try to read input as move CSV file
          move(sourceFile, removeDuplicatedTimestamps=TRUE)
        },
        error = function(readCsvError) {
          # collect errors for report and throw custom error
          stop(paste(sourceFile, " -> readRDS(sourceFile): ", readRdsError, "move(sourceFile): ", readCsvError, sep = ""))
        })
      })
  } else {
    logger.debug("Skip loading: no source File")
  }

  input
}

inputData <- readInput(inputFileName)
# Add the data parameter if input data is available
if (!is.null(inputData)) {
  args[["data"]] <- inputData
}

result <- tryCatch({
    do.call(rFunction, args)
  },
  error = function(e) {
    logger.error(paste("ERROR:", e))
    stop(e) # re-throw the exception
  }
)

if(!is.null(outputFileName) && outputFileName != "" && !is.null(result)) {
  logger.info(paste("Storing file to '", outputFileName, "'", sep = ""))
  saveRDS(result, file = outputFileName)
} else {
  logger.warn("Skip store result: no output File or result is missing.")
}

