#' @title 
#' Creation of the 'metsta' dataset
#' 
#' @description 
#' The function \code{make_metsta} creates the \code{\link[metsyn]{metsta}} 
#' dataset from the file \code{postesSynop.csv} downloaded 
#' \href{https://donneespubliques.meteofrance.fr/?fond=produit&id_produit=90&id_rubrique=32}{here}. 
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
#' \code{\link[metsyn]{metsta}}, 
#' \code{\link[metsyn]{make_metsyn}}
#' 
#' @import readr
#' @export
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
  
  return(invisible(metsta))
}
