#' @title 
#' Creation of the 'metsta' dataset made of Meteo France Synop meteorogical stations
#' 
#' @description 
#' The function \code{make_metsta} creates the \code{metsta} 
#' dataset from the file \code{postesSynop.csv} downloaded 
#' \href{https://donneespubliques.meteofrance.fr/?fond=produit&id_produit=90&id_rubrique=32}{here}. 
#' \code{make_metsta} looks for this file in the 
#' \code{file.path(path, "data-raw")} folder. 
#' 
#' This dataset contains the following columns: 
#' \itemize{
#'   \item \code{Id}: WMO meteorological station id; 
#'   \item \code{Name}: name of the meteorological station; 
#'   \item \code{Latitude}, \code{Longitude}, \code{Altitude}: coordinates of 
#'   the meteorological station. 
#' }
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
#' Returns invisibly the tibble created, with 5 columns and 62 rows. 
#' 
#' @aliases metsta
#' @seealso
#' \code{\link[metsyn]{metsyn}} for the dataset containing Meteo France 
#' Synop data; 
#' \code{\link[metsyn]{metdes}} for the dataset which gives some descriptive 
#' information on \code{metsyn}. 
#' 
#' @import readr
#' @export
#' 
#' @examples 
#' \dontrun{
#' dir.create("data-raw", showWarnings = FALSE)
#' make_metsta(save_it = TRUE)
#' }
#' 
make_metsta <-
function(path = ".", #system.file(package = 'metsyn')
         save_it = FALSE)
{
  metsta <- readr::read_delim(file.path(path, "data-raw", "postesSynop.csv"), 
                              delim = ";", 
                              col_types = readr::cols(
                                ID = readr::col_character(),
                                Nom = readr::col_character(),
                                Latitude = readr::col_double(),
                                Longitude = readr::col_double(),
                                Altitude = readr::col_double()
                              ))
  names(metsta) <- c("Id", "Name", "Latitude", "Longitude", "Altitude")

  if (save_it) {
    save(metsta, 
         file = file.path(path, "data", "metsta.RData"), 
         compress = "xz")
  }
  
  invisible(metsta)
}
