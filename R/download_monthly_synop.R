
#' @export
#' @rdname download_daily_synop
#' 
download_monthly_synop <- 
function(path = ".", 
         date, # "199608"
         ...)
{
  file <- paste0("synop.", date, ".csv.gz")
  download.file(url = paste(metsyn_url(), file, sep = "/"), 
                destfile = file.path(path, "data-raw", paste0("monthly_", file)), 
                ...)
  invisible(NULL)
}
