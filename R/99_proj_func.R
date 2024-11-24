# Creating data directories
create_dir <- function(path){
  if ( !dir.exists(path) ){
    dir.create(path)
  }
}

# Making a function that downloads data from the NCBI server - NEW
download_dataset_ncbi <- function(raw_dir) {
  create_dir(raw_dir)

  file_ncbi_name <- "raw_data_ncbi.txt.gz"
  file_ncbi_path <- str_c(raw_dir, file_ncbi_name)

  if (file.exists(file_ncbi_path)) {
    message("File already exists: ", file_ncbi_path)
    return()
  }

  url_ncbi <- "https://ftp.ncbi.nlm.nih.gov/geo/series/GSE18nnn/GSE18044/matrix/GSE18044_series_matrix.txt.gz"

  # Download the file
  download.file(url_ncbi, file_ncbi_path)
  message("File downloaded: ", file_ncbi_path)

  # Decompress the .gz file
  gunzip(file_ncbi_path, remove = FALSE)
  message("File decompressed: ", gsub("\\.gz$", "", file_ncbi_path))
}




# Making a function that downloads data from the NCBI server - OLD
#download_dataset_ncbi <- function(raw_dir) {

  #file_ncbi_name <- "raw_data_ncbi.txt.gz"           # naming

 # if (file.exists(str_c(raw_dir, file_ncbi_name)))   # Checks if the file already exists in raw_dir
    #return()

 # url_ncbi <- "https://ftp.ncbi.nlm.nih.gov/geo/series/GSE18nnn/GSE18044/matrix/GSE18044_series_matrix.txt.gz"

 # download.file(url_ncbi, str_c(raw_dir, file_ncbi_name))       # downloading the file from the URL and saves in raw_dir
 # unzip(str_c(raw_dir, file_ncbi_name), exdir=raw_dir)          # unzipping the file


#}


