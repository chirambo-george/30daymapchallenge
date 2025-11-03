library(tmap)
library(sf)
library(dplyr)

# loading the dataset
facilities <- read_sf('data/mwi_hltfacp_health_fac_HISP.shp', crs = 4326)

# malawi data
malawi <- read_sf('data/mwi_admbnda_adm0_nso_hotosm_20230405.shp', crs = 4326)

facilities <- st_transform(facilities, crs = 4326)

facilities <- facilities |> 
  filter(TYPE == 'Central Hospital'|
           TYPE == 'District Hospital'|
           TYPE == 'Hospital'|
           TYPE == 'Clinic'| 
           TYPE == 'Rural Hospital'|
           TYPE == 'Health Centre'|
           TYPE == 'Mental Hospital'
                     )


options(tmap.component.autoscale = FALSE)
# points map
tm_basemap('CartoDB.DarkMatter') +
  tm_shape(malawi)  + tm_borders(alpha = 0, border.col = "white",   # Border color
                                                border.lwd = 1)+
  tm_shape(facilities) + 
  tm_symbols(col = 'TYPE', 
             size = 0.3, 
             shape = 21, 
             border.lwd = 0.1, 
             palette = c("#30123b", "#7a0403", "#ae2c87", "#e16462", "#faba39", "#c2f970", "#a0fe65")
                         ) + 
  tm_layout(title = "Health Facilities \nin Malawi",
            title.position = c("right", "top"),
            title.color = "white",
            title.size = 0.7,
            legend.outside = TRUE,
            legend.title  = "Health Facility",
            legend.title.size = 1,
            legend.text.size = 0.8,
            frame = FALSE)

tmap_save(filename = 'outputs/malawi_health_facilities_map.png', width = 10, height = 7)
