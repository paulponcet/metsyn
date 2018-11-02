#' @title 
#' Creation of the 'metdes' dataset, made of descriptive information on the 'metsyn' dataset
#' 
#' @description 
#' The function \code{make_metdes} creates the \code{metdes} 
#' dataset, which contains descriptive information on the 
#' \code{metsyn} dataset. 
#' 
#' The dataset contains the following columns: 
#' \itemize{
#'   \item \code{Short_Name}: short name of the variable, in French; 
#'   \item \code{Long_name_French}: name of the variable, in French; 
#'   \item \code{Long_Name_English}: currently not provided yet; 
#'   \item \code{Type}: type of the variable (one of \code{character}, 
#'   \code{numeric}, \code{integer}); 
#'   \item \code{Unit}: physical unit of the variable. 
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
#' Returns invisibly the tibble created, with 5 columns and 59 rows. 
#' 
#' @aliases metdes
#' @seealso 
#' \code{\link[metsyn]{metsyn}} for the dataset containing Meteo France 
#' Synop data; 
#' \code{\link[metsyn]{metsta}} for the dataset on the meteorological stations 
#' involved. 
#' 
#' @importFrom tibble tibble_
#' @export
#' 
#' @examples 
#' \dontrun{
#' make_metdes(save_it = TRUE)
#' }
#' 
make_metdes <- 
function(path = ".", 
         save_it = FALSE)
{
  metdes <- tibble::tibble_(list(
    Short_Name = ~ c("Id", "date", "pmer", "tend", "cod_tend", "dd", "ff", "t", 
                     "td", "u", "vv", "ww", "w1", "w2", "n", "nbas", "hbas", "cl", 
                     "cm", "ch", "pres", "niv_bar", "geop", "tend24", "tn12", "tn24", 
                     "tx12", "tx24", "tminsol", "sw", "tw", "raf10", "rafper", "per", 
                     "etat_sol", "ht_neige", "ssfrai", "perssfrai", "rr1", "rr3", 
                     "rr6", "rr12", "rr24", "phenspe1", "phenspe2", "phenspe3", 
                     "phenspe4", "nnuage1", "ctype1", "hnuage1", 
                     "nnuage2", "ctype2", "hnuage2", "nnuage3", "ctype3", "hnuage3", "nnuage4", 
                     "ctype4", "hnuage4"), 
    Long_Name_French = ~ c("Indicatif_OMM_station", 
                           "Date_UTC", 
                           "Pression_au_niveau_mer", 
                           "Variation_de_pression_en_3_heures", 
                           "Type_de_tendance_barometrique", 
                           "Direction_du_vent_moyen_10_mn", 
                           "Vitesse_du_vent_moyen_10_mn", 
                           "Temperature", 
                           "Point_de_rosee", 
                           "Humidite", 
                           "Visibilite_horizontale", 
                           "Temps_present", 
                           "Temps_passe_1", 
                           "Temps_passe_2", 
                           "Nebulosite_totale", 
                           "Nebulosite_des_nuages_de_l_etage_inferieur", 
                           "Hauteur_de_la_base_des_nuages_de_l_etage_inferieur", 
                           "Type_des_nuages_de_l_etage_inferieur", 
                           "Type_des_nuages_de_l_etage_moyen", 
                           "Type_des_nuages_de_l_etage_superieur", 
                           "Pression_station", 
                           "Niveau_barometrique", 
                           "Geopotentiel", 
                           "Variation_de_pression_en_24_heures", 
                           "Temperature_minimale_sur_12_heures", 
                           "Temperature_minimale_sur_24_heures", 
                           "Temperature_maximale_sur_12_heures", 
                           "Temperature_maximale_sur_24_heures", 
                           "Temperature_minimale_du_sol_sur_12_heures", 
                           "Methode_mesure_tw", 
                           "Temperature_du_thermometre_mouille", 
                           "Rafales_sur_les_10_dernieres_minutes", 
                           "Rafales_sur_une_periode", 
                           "Periode_de_mesure_de_la_rafale", 
                           "Etat_du_sol", 
                           "Hauteur_totale_de_la_couche_de_neige_glace_autre au_sol", 
                           "Hauteur_de_la_neige_fraiche", 
                           "Periode_de_mesure_de_la_neige_fraiche", 
                           "Precipitations_dans_la_derniere_heure", 
                           "Precipitations_dans_les_3_dernieres_heures",
                           "Precipitations_dans_les_6_dernieres_heures",
                           "Precipitations_dans_les_12_dernieres_heures",
                           "Precipitations_dans_les_24_dernieres_heures",
                           "Phenomene_special_1", 
                           "Phenomene_special_2",
                           "Phenomene_special_3",
                           "Phenomene_special_4",
                           "Nebulosite_couche_nuageuse_1", 
                           "Type_nuage_1", 
                           "Hauteur_de_base_1", 
                           "Nebulosite_couche_nuageuse_2", 
                           "Type_nuage_2", 
                           "Hauteur_de_base_2", 
                           "Nebulosite_couche_nuageuse_3", 
                           "Type_nuage_3", 
                           "Hauteur_de_base_3", 
                           "Nebulosite_couche_nuageuse_4", 
                           "Type_nuage_4", 
                           "Hauteur_de_base_4"), 
    Long_Name_English = ~ rep("", 59), 
    Type = ~ c("character", "character", 
               "numeric", "numeric", "integer", "numeric", 
               "numeric", "numeric", "numeric", "numeric", "numeric", "integer", "integer", 
               "integer", "numeric", "numeric", "numeric", "integer", "integer", "integer", 
               "numeric", "integer", "numeric", "numeric", "numeric", "numeric", "numeric", 
               "numeric", "numeric", "integer", "numeric", "numeric", "numeric", "numeric", 
               "integer", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", 
               "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", 
               "integer", "numeric", "numeric", "integer", "numeric", "numeric", "integer", 
               "numeric", "numeric", "integer", "numeric"), 
    Unit = ~ c("", "YYYY-MM-DD HH-MM-SS", "Pa", "Pa", "code_0200", "degree", 
               "m/s", "K", "K", "%", "m", "code_4677", "code_4561", "code_4561", 
               "%", "octa", "m", "code_0513", "code_0515", "code_0509", "Pa", 
               "Pa", "m2/s2", "Pa", "K", "K", "K", "K", "K", "code_3855", "K", "m/s", 
               "m/s", "min", "code_0901", "m", "m", "0.1h", 
               "mm", "mm", "mm", "mm", "mm", 
               "code_3778", "code_3778", "code_3778", "code_3778", 
               "octa", "octa", "octa", "octa", 
               "code_0500", "code_0500", "code_0500", "code_0500", 
               "m", "m", "m", "m")))
  
  if (save_it) {
    save(metdes, 
         file = file.path(path, "data", "metdes.RData"), 
         compress = "xz")
  }
  
  invisible(metdes)
}
