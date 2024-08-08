# Script to Load and Install the Required Packages

# Check if the `pak` package is installed; if not, install it
if (!requireNamespace("pak", quietly = TRUE)) {
  install.packages("pak")
}

# Define a vector of required packages
packages <- c(
  "tidyverse",    # For data manipulation and visualization
  "sf",           # For simple feature operations (handling spatial data)
  "here",         # For managing file paths
  "patchwork",    # For organizing multiple plots
  "raster",       # For handling raster data
  "exactextractr",# For extracting data from raster objects
  "tidygeocoder", # For geocoding (converting addresses to geographic coordinates)
  "ggmap",        # For spatial visualization and mapping
  "ggspatial",    # For adding spatial context to ggplot2 visualizations
  "epitrix",      # For epidemiological analysis
  "janitor",      # For data cleaning
  "leaflet",      # For interactive maps
  "HistData",     # For historical datasets
  "gtsummary",     # For creating summary tables
  "spdep"
)

# Install all the packages using the `pak` package
packages |> pak::pak()
