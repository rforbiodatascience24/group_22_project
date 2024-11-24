# Making a function that downloads data from the NCBI server
download_dataset_ncbi <- function(raw_dir) {

  file_ncbi_name <- "raw_data_ncbi.txt.gz"           # naming

  if (file.exists(str_c(raw_dir, file_ncbi_name)))   # Checks if the file already exists in raw_dir
    return()

  url_ncbi <- "https://ftp.ncbi.nlm.nih.gov/geo/series/GSE18nnn/GSE18044/matrix/GSE18044_series_matrix.txt.gz"

  download.file(url_ncbi, str_c(raw_dir, file_ncbi_name))       # downloading the file from the URL and saves in raw_dir
  unzip(str_c(raw_dir, file_ncbi_name), exdir=raw_dir)          # unzipping the file


}


