# HandsOn Exercise 1

# Step 1: Install `sf` package and load it.

# install.packages('sf')
pak::pak("sf")
library(sf) # for simple feature operations
library(here) # for managing files
library(patchwork) # for plot organisation
library(tidyverse)
library(ggspatial)

# Step 2: Load the shapefile provided

here("spatial_files", "India_State_Boundary.shp") |> 
  st_read()

india_state_sf <- here("spatial_files", "India_State_Boundary.shp") |> 
  st_read()

# Step 3: Explore the `india_state_sf` object

india_state_sf

# Step 4:  Check first six rows
india_state_sf |>  
  head()

# Step 5:  Check CRS
india_state_sf |>  
  st_crs()
  
india_state_sf <- india_state_sf |> 
  st_transform(crs = 4326)

# Step 6a:  Plot the map
india_state_sf |> 
  plot()

# Step 6b:  Plot the map
india_state_sf |> 
  ggplot() +
  geom_sf()

# Step 6c:  Plot the map with map elements
india_state_sf |> 
  ggplot() +
  geom_sf() + 
  annotation_scale(location = "bl") + # Add Scale
  annotation_north_arrow(location = "tr", which_north = "true") # add north arrow

# Step 6d:  Add Title and Data Source
india_state_sf |> 
  ggplot() +
  geom_sf() + 
  annotation_scale(location = "bl") + # Add Scale
  annotation_north_arrow(location = "tr", which_north = "true") + # add north arrow
  labs(title = "India State Boundary", 
       caption = "Source: Survey of India, Govt. of India")

# Step 7:  Let us change the CRS to a Projected CRS 
india_state_sf_projected <- india_state_sf  |>  
  st_transform(32643)

# Step 8:  Plot the map
india_state_sf_projected |> 
  ggplot() +
  geom_sf() + 
  annotation_scale(location = "bl") + # Add Scale
  annotation_north_arrow(location = "tr", which_north = "true") + # add north arrow
  labs(title = "India State Boundary", 
       caption = "Source: Survey of India, Govt. of India")

# Step 9:  Plot them side by side

## Save the individual plots first 
plot_1 <- india_state_sf |> 
  ggplot() +
  geom_sf() + 
  annotation_scale(location = "bl") + # Add Scale
  annotation_north_arrow(location = "tr", which_north = "true") + # add north arrow
  labs(title = "India State Boundary",
       subtitle = "Geodetic CRS (4326)",
       caption = "Source: Survey of India, Govt. of India")

plot_2 <- india_state_sf_projected |> 
  ggplot() +
  geom_sf() + 
  annotation_scale(location = "bl") + # Add Scale
  annotation_north_arrow(location = "tr", which_north = "true") + # add north arrow
  labs(title = "India State Boundary",
       subtitle = "Projected CRS (32643)",
       caption = "Source: Survey of India, Govt. of India")

## Combine both the plots using `patchwork`
combined_plot <- plot_1 + plot_2
combined_plot

# Step 10:  Save the plots
plot_1 |> 
  ggsave(file = here("plots", "ind_state_map_4326.png"),
         width = 6, 
         height = 6)

plot_2 |> 
  ggsave(file = here("plots", "ind_state_map_32643.png"), 
         width = 6, 
         height = 6)

combined_plot |> 
  ggsave(file = here("plots", "india_state_map_combined.png"),
         width = 12, 
         height = 6,
         scale = 1.5)

# Step 11: Save your `sf` Objects 
india_state_sf |> 
  write_rds(here("spatial_files", "india_state_sf_4326.rds"))

india_state_sf_projected |> 
  write_rds(here("spatial_files", "india_state_sf_32643.rds"))

# Extract Maharashtra

mh_sf <- india_state_sf |> 
  filter(State_Name == "Maharashtra")

mh_sf |> 
  ggplot() +
  geom_sf()

mh_sf |> 
  write_rds(here("spatial_files", "mh_sf.rds"))
