# challenge 1 time
setwd("~/R/workshops-scripts")
library(sf)
library(ggplot2)
library(dplyr)


ward98 <- st_read("data/ward1998.dbf")
ward98 <- st_transform(ward98, 32616)
plot(ward98)

water <- st_read("data/Waterways.geojson")
water <- st_transform(water, 32616)

ggplot(data=water) + geom_sf()


centroids <- st_centroid(ward98)

ggplot(data=ward98) + geom_sf() 

ggplot(data=centroids)+ geom_sf()

ggplot() + 
  geom_sf(data=ward98, aes(fill = COUNT)) + 
  geom_sf(data=centroids, color = 'red')


#ggplot() + 
  geom_sf(data=ward98, aes(fill = COUNT)) + 
  geom_sf(data=centroids, color = 'red')
  
View(water)
arrange(water, desc(shape_len))
unique(water$name)

water_clean <- filter(water, name != "LAKE MICHIGAN")

ggplot()+
  geom_sf(data=ward98, aes(fill = COUNT)) + 
  geom_sf(data=water_clean, color = 'red')+
  geom_sf(data=centroids, color = 'blue')


intersects <- st_intersects(ward98, water_clean)
water_wards <- filter(ward98, lengths(intersects) > 0)

ggplot()+
  geom_sf(data=ward98) + 
  geom_sf(data=water_wards, fill = 'lightblue')+
  geom_sf(data=water_clean, color = 'blue')+
  geom_sf(data=centroids, color = 'Red')
  


