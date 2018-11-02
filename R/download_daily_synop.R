#' @title 
#' Download Meteo France Synop Data
#' 
#' @description 
#' The functions \code{download_daily_synop} and 
#' \code{download_monthly_synop} enable to download Meteo France 
#' Synop Data described 
#' \href{https://donneespubliques.meteofrance.fr/?fond=produit&id_produit=90&id_rubrique=32}{here}. 
#' 
#' @param path
#' character. Data once downloaded are saved in the folder 
#' \code{file.path(path, "data-raw")}. 
#' 
#' @param date
#' character. 
#' For \code{download_daily_synop}, a date in the form 
#' \code{"YYYYMMDDHH"}. 
#' For \code{download_monthly_synop}, a date in the form 
#' \code{"YYYYMM"}. 
#' 
#' @param ...
#' Additional parameters to be passed to \code{\link[utils]{download.file}}. 
#' 
#' @seealso 
#' \code{\link[metsyn]{make_metsyn}}. 
#' 
#' @importFrom utils download.file
#' @export
#' 
download_daily_synop <- 
function(path = ".", 
         date, # "2017011412"
         ...)
{
  file <- paste0("synop.", date, ".csv")
  dir.create(file.path(path, "data-raw"), showWarnings = FALSE)
  utils::download.file(url = file.path(metsyn_url(), file), 
                       destfile = file.path(path, "data-raw", paste0("daily_", file)), 
                       ...)
  invisible(NULL)
}
