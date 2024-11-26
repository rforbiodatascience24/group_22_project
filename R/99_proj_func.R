# Creating data directories
create_dir <- function(path){
  if ( !dir.exists(path) ){
    dir.create(path)
  }
}


# Making a function that downloads data from the NCBI server - OLD
download_dataset_ncbi <- function(raw_dir) {

  file_ncbi_name <- "raw_data_ncbi.txt.gz"           # naming

  if (file.exists(str_c(raw_dir, file_ncbi_name)))   # Checks if the file already exists in raw_dir
    return()

  url_ncbi <- "https://ftp.ncbi.nlm.nih.gov/geo/series/GSE18nnn/GSE18044/matrix/GSE18044_series_matrix.txt.gz"

  download.file(url_ncbi, str_c(raw_dir, file_ncbi_name))       # downloading the file from the URL and saves in raw_dir
  unzip(str_c(raw_dir, file_ncbi_name), exdir=raw_dir)          # unzipping the file

}


# Function to download the annotation file from NCBI
download_data_annotation_ncbi <- function(raw_dir) {
  annotation_file_name <- "raw_annotation.bgx.gz"
  file_path <- str_c(raw_dir, annotation_file_name)

  if (file.exists(file_path)) {  # Check if annotation file exists
    message("Annotation file already exists: ", file_path)
    return()
  }

  url_ncbi <- "https://www.ncbi.nlm.nih.gov/geo/download/?acc=GPL6104&format=file&file=GPL6104%5FIllumina%5FHumanRef%2D8%5FV2%5F0%5FR1%5F11223162%5FA%2Ebgx%2Egz"

  # Download and decompress the annotation file
  download.file(url_ncbi, file_path)
  gunzip(file_path, remove = FALSE)
  message("Annotation file decompressed to: ", str_replace(file_path, "\\.gz$", ""))
}

#download_data_annotation_ncbi <- function(raw_dir) {
 # anotation_file_name <- "raw_annotation.bgx.gz"
  #file_path <- str_c(raw_dir, anotation_file_name)

  #url_ncbi <- "https://www.ncbi.nlm.nih.gov/geo/download/?acc=GPL6104&format=file&file=GPL6104%5FIllumina%5FHumanRef%2D8%5FV2%5F0%5FR1%5F11223162%5FA%2Ebgx%2Egz"
  #download.file(url_ncbi, str_c(raw_dir, anotation_file_name))

#}

read_ncbi_table <- function(file_path) {
  if (!file.exists(file_path)) {
    stop("File does not exist at path: ", file_path)
  }
  message("Reading NCBI dataset from: ", file_path)
  table <- tryCatch(
    read.table(file_path, header = FALSE, fill = TRUE, col.names = str_c("col_", seq_len(77))),
    error = function(e) {
      stop("Error reading file: ", file_path, "\n", e$message)
    }
  )
  return(table)
}

#read_ncbi_table <- function(file_path) {

  #table <- read.table(file_path, header=FALSE, fill = TRUE, col.names = str_c("col_",seq_len(77)))
  #return(table)

#}

read_bgx_file <- function(raw_dir, file_name) {

  if (file.exists(str_c(raw_dir, "raw_annotation.bgx")))
    return (readBGX(str_c(raw_dir, "raw_annotation.bgx")))

  outputFilePath <- gunzip(str_c(raw_dir, file_name), remove=FALSE)
  return (readBGX(outputFilePath))

}


