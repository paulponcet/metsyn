#' @title 
#' Creation of the 'metsyn' dataset
#' 
#' @description 
#' The function \code{make_metsyn} creates the \code{\link[metsyn]{metsyn}} 
#' dataset from the files downloaded with 
#' \code{\link[metsyn]{download_monthly_synop}}. 
#' 
#' @param path
#' character. Data once created are saved in the folder 
#' \code{file.path(path, "data")}. 
#' 
#' @param save_it 
#' logical. If \code{TRUE}, the result is saved as an \code{.RData} file in the 
#' folder \code{file.path(path, "data")}. 
#' 
#' @return 
#' Returns invisibly the tibble created. 
#' 
#' @seealso 
#' \code{\link[metsyn]{metsyn}}, 
#' \code{\link[metsyn]{download_monthly_synop}}
#' 
#' @importFrom foreach %do%
#' @importFrom foreach foreach
#' @importFrom readr read_delim
#' @importFrom stringr str_sub
#' @export
#' 
#' @examples
#' \dontrun{  
#' dir.create("data-raw")
#' for (y in 1996:2016) {
#'   for (m in 1:12) {
#'     m <- if (m < 10) paste0(0, m) else m
#'     download_monthly_synop(date = paste0(y, m), 
#'                            mode = "wb")
#'   }
#' }
#' make_metsyn(save_it = TRUE)
#' }
#' 
make_metsyn <-
function(path = ".", #system.file(package = 'metsyn')
         save_it = FALSE)
{
  d <- dir(path = file.path(path, "data-raw"))
  w <- which(stringr::str_sub(d, start = -7)==".csv.gz")
  
  col_types <- substr(c(metsyn::metdes[["Type"]], "?"), 1, 1)
  i <- 0
  metsyn <- foreach::foreach(i = w, .combine = "rbind") %do% {
    readr::read_delim(file.path(path, "data-raw", d[i]), 
                      delim = ";", 
                      col_types = paste(col_types, collapse = ""), 
                      na = "mq")
  }
  metsyn$date <- strptime(metsyn$date, 
                          format = "%Y%m%d%H%M%S", 
                          tz = "GMT")
  metsyn <- metsyn[,-60L]
  names(metsyn) <- metsyn::metdes[["Short_Name"]]
  
  if (save_it) {
    save(metsyn, 
         file = file.path(path, "data", "metsyn.RData"), 
         compress = "xz")
  }
  
  return(invisible(metsyn))
}
