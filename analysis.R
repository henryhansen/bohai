
# Load libraries ----------------------------------------------------------

library(tidyverse)
library(bayesdfa)
library(rstan)
library(sf)

# Load and clean data -----------------------------------------------------
bohai <- read.csv("data/bohai.csv")
bohai <- arrange(bohai, year)
bohai$year <- as.integer(bohai$year)

# Explore data ------------------------------------------------------------
#read in shapefiles
sa <- read_sf(dsn ="data", layer = "study_area")

#Look at characteristics by site
for (i in 10:22) {
    print(i)
    value <- colnames(bohai)[i]
    out <- ggplot() +
        geom_sf(data = sa)+
        geom_point(data = bohai, aes(x=longtitude, y=latitude, color=.data[[value]])) +
        scale_color_viridis_c()+
        theme_minimal()+
        theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1))+
        facet_grid(rows = vars(stage), col = vars(year))
    file <- paste("plots/",value,".jpeg", sep = "")
    print(file)
    ggsave(file,
           plot = out,
           device = "jpeg",
           width = 20,
           height = 10,
           units = "in")
}


# Run Bayes DFA model -----------------------------------------------------


# Assess models -----------------------------------------------------------


