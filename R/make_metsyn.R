#' @title 
#' Creation of the 'metsyn' dataset made of Meteo France Synop data 
#' 
#' @description 
#' The function \code{make_metsyn} creates the \code{metsyn} 
#' dataset from the files downloaded with 
#' \code{\link[metsyn]{download_monthly_synop}}. 
#' \code{make_metsyn} looks for these files in the 
#' \code{file.path(path, "data-raw")} folder. 
#' 
#' This dataset is made of meteorological data recorded every three hours on 
#' 62 French meteorological stations. 
#' 
#' The columns contained in this dataset are described by the 
#' \code{\link[metsyn]{metdes}} dataset. 
#' 
#' @source 
#' Meteo France, see \href{https://donneespubliques.meteofrance.fr/?fond=produit&id_produit=90&id_rubrique=32}{here}. 
#' 
#' @note 
#' This dataset is distributed by Meteo France under the terms of the 
#' \href{https://www.etalab.gouv.fr/wp-content/uploads/2014/05/Open_Licence.pdf}{Open Licence 1.0}, 
#' provided by \href{https://www.etalab.gouv.fr/en/qui-sommes-nous}{Etalab} and 
#' designed to be compatible with the "Creative Commons Attribution 2.0" 
#' (CC-BY 2.0) licence of Creative Commons. 
#' Etalab is the task force under the French Prime Minister's authority 
#' leading Open Government Data policy for France. 
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
#' Returns invisibly the tibble created, with 59 columns. 
#' 
#' @aliases metsyn
#' @seealso 
#' \code{\link[metsyn]{download_monthly_synop}}; 
#' \code{\link[metsyn]{metdes}} for the dataset which gives some descriptive 
#' information on \code{metsyn}; 
#' \code{\link[metsyn]{metsta}} for the dataset on the meteorological stations 
#' involved. 
#' 
#' @importFrom foreach %do%
#' @importFrom foreach foreach
#' @importFrom readr read_delim
#' @importFrom stringr str_sub
#' @export
#' 
#' @examples
#' \dontrun{
#' dir.create("data-raw", showWarnings = FALSE)
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
  
  metdes <- make_metdes()
  col_types <- substr(c(metdes[["Type"]], "?"), 1, 1)
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
  names(metsyn) <- metdes[["Short_Name"]]
  
  if (save_it) {
    save(metsyn, 
         file = file.path(path, "data", "metsyn.RData"), 
         compress = "xz")
  }
  
  invisible(metsyn)
}
