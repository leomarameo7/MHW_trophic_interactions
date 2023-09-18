library(rnaturalearth)
library(ggplot2)
library(ggstar)
library(ggspatial)
library(ggmap)
library(ggsn)
library(cowplot)
# load world map data ####
world <- rnaturalearth::ne_countries(returnclass = "sf") 
# plot map
(p <- ggplot(data = world) +
  # add map and define filling
  geom_sf(fill = "beige") +
  # add Rocas Atoll position with star #
  geom_star(aes(x= -33.8, y = - 3.86 ), size=1.5, color = 'red') +
  # simply black and white background
  theme_bw() +
  # defining coordinates
  coord_sf(xlim = c(-90, -25), ylim = c(20, -55)) +
  # add distance measure
  annotation_scale(location = "bl", width_hint = 0.5) +
  labs(x = NULL, y = NULL) +
  # add compass 
  annotation_north_arrow(location = "br",style = north_arrow_fancy_orienteering) +
  theme(panel.background = element_rect(fill = "aliceblue"),
        axis.text = element_text(colour = "black"))
)


### load Rocas Atoll inlet map ###
####  base map  ####
# save api key
ggmap::register_google(key = "") # insert your API key
### download the ggmap Rocas atoll ####
m2 <- ggmap::get_googlemap(center = c(lon = -33.805, lat = -3.865),
                           #location = c(left = -33.845, bottom = -3.889,right = -33.76, top = -3.84),
                           zoom = 14,
                           scale = 2, # multiplicative factor for the number of pixels returned possible values are 1, 2, or 4 (e.g. size = c(640,640) and scale = 2 returns an image with 1280x1280 pixels).
                           maptype = "satellite",
                           source = "google")
ggmap(m2)

save(m2, file = "data/raw/rocas_map.rda")
### load the Rocas Atoll map downloaded by google maps API #####
load(file = "data/raw/rocas_map.rda")
ggmap(m2)
#### Mutate ggmap objet to ggplot object and add scale #####
(inset <- ggmap(m2) +
   labs(x = "", y = "") +
   scalebar(
     x.min = -33.83, x.max = -33.78,
     y.min = -3.879, y.max = -3.84,
     transform = T,
     dist_unit = "km",
     dist = 1, # distance to represent with each segment of the scale bar.
     height = 0.05, # number between 0 and 1 to indicate the scale bar's height, as a proportion of the y axis
     st.color = "white", 
     st.bottom = T, # logical. If TRUE (default) the scale bar's text is displayed at the bottom of the scale bar, if FALSE, it is displayed at the top
     st.dist = 0.1, # number between 0 and 1 to indicate the distance between the scale bar and the scale bar's text, as a proportion of the y axis.
     st.size = 1.8, # number to indicate the scale bar's size. It is passed to size in annotate function.
     location = "topright",
     model = "WGS84")+
   ggthemes::theme_map() +
   theme(axis.title.x = element_blank(),
         axis.title.y = element_blank()))

#### add inset to main map ####

(p3 <- ggdraw() +
  draw_plot(p) +
  draw_plot(inset,
            height = 0.25,
            x = 0.18,
            y = 0.74 )
)

#### save file #### 
ggsave(filename = "location_map_2.png",
       plot = p3, 
       width = 10,
       height = 6,
       path = "outputs/figures/",
       dpi = 300)
