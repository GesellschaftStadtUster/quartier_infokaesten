##Bibliothek
library(RCurl)
library(leaflet)
library(htmlwidgets)


#Daten einlesen
daten <- read.csv("https://raw.githubusercontent.com/GesellschaftStadtUster/quartier_infokaesten/main/liste_quartierinfokaesten.csv")

popuptext <- paste0("<h1>",daten$standort,"</h1>",
               "<b>Quartierverein:</b> ", daten$quartierverein,
               "<br><b>Zuständigkeit:</b> ", daten$besitzer,
               "<br><b>Google Streetview:</b> <a href=\"",daten$link_google.streetview,"\", target=_blank>LINK</a>",
               "<br><a href=\"",daten$bild_kasten,"\", target=_blank><img src=\"",daten$bild_kasten,"\" alt=\"Bild des Kasten\" width=\"100%\" height=\"100%\"></a>")

farbe <- daten$besitzer
farbe[farbe=="stadt"] <- "red"
farbe[farbe=="quartierverein"] <- "green"

m <- leaflet() %>% 
  addTiles() %>% 
  addCircleMarkers(lng=daten$lng, lat=daten$lat, popup=popuptext, color = farbe, radius = 15)
saveWidget(m, file="karte.html")
m  # Print the map
