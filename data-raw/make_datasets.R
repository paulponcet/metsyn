
library(metsyn)
library(readr)

# 'metdes' dataset
make_metdes(save_it = TRUE)

# 'metsyn' dataset
for (y in 1996:2016) {
  for (m in 1:12) {
    m <- if (m < 10) paste0(0, m) else m
    download_monthly_synop(date = paste0(y, m), 
                           mode = "wb")
  }
}
make_metsyn(save_it = TRUE)

# 'metsta' dataset
make_metsta(save_it = TRUE)
