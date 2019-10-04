library(data.table)
library(plyr)
library(dplyr)
library(highcharter)

fans_react = fread("C:/Users/mama7051/Desktop/hcharts-himym/himymfanreact.csv")
Number_of_drinks = fread("C:/Users/mama7051/Desktop/hcharts-himym/himymdrinks.csv")
HighestRated = fread("C:/Users/mama7051/Desktop/hcharts-himym/HRated.csv")


#Grouped column chart

Number_of_drinks %>% 
  
  hchart('column', hcaes(x = `HIMYM Character`, y = `Number of Drinks`, group = Type)) %>%
  
  hc_title(text = "How much did the gang really drink?",
           style = list(fontWeight = "bold", fontSize = "30px"),
           align = "center") %>% 
  
  hc_subtitle(text = 
                "'All I want was to have a regular beer at my regular bar with my regular friends in my regular city.'- Ted Mosby", 
              style = list(fontWeight = "bold"),
              align = "center") %>% 
  
  hc_credits(enabled = TRUE, 
             text = "Data Source: HIMYM;https://imgur.com/user/haaaaaaaveyoumetted",
             style = list(fontSize = "10px")) %>% 
  
  hc_add_theme(hc_theme_ffx())


#Pie chart 

favorite_bars %>% 
  hchart('pie', hcaes(bars, percent)) %>% 
  hc_title(text = "Marshall's favorite bars",
           align = "center",
           style = list(fontWeight = "bold", fontSize = "30px")) %>% 
  hc_tooltip(enabled = T) %>% 
  hc_subtitle(text = "In Percentage of Awesomness!",
              align = "center",
              style = list(fontWeight = "bold")) %>% 
  hc_add_theme(hc_theme_ffx()) %>% 
  hc_credits(enabled = T,text = "Data source:HIMYM")

#Bubble chart

HighestRated %>% 
  hchart("bubble", hcaes(x = 'Episode', y = Rating, size = Votes, color = 
                           Votes), maxSize = "20%") %>% 
  hc_title(text = "Top Rated Episodes of HIMYM",
           style =list(fontWeight = "bold", fontSize = "30px"),
           align = "center") %>% 
  hc_subtitle(text = "What was your favorite episode?", 
              align = "center",
              style =list(fontWeight = "bold")) %>% 
  hc_credits(enabled = T,  text = "Size by Number of Votes,
                                     Colored by Rating.
                                                     
                           | Data Source- IMDB") %>% 
  hc_add_theme(hc_theme_ffx())

#Colored area chart

colnames(favorite_pies)[1] = "Pies"
colnames(favorite_pies)[2] = "Percent"

favorite_pies %>% 
  mutate( segmentColor = c("#000004", "#3B0F70", "#8C2981", "#DE4968", "#FE9F6D"))%>% 
  hchart(type = 'coloredarea', hcaes(x = Pies, y = Percent))%>% 
  hc_title(text = "Marshall's favorite pies",
           style = list(fontWeight = "bold", fontSize = "30px"),
           align = "center") %>% 
  hc_subtitle(text = "In Percentage of Tastiness!",
              style = list(fontWeight = "bold"),
              align = "center") %>% 
  hc_credits(enabled = T,  text = "Data Source- HIMYM") %>% 
  
  hc_add_theme(hc_theme_ffx()) 

#Polar line chart


highchart() %>% 
  hc_chart(polar = TRUE) %>% 
  hc_title(text = "HIMYM Finale Reactions",
           style = list(fontWeight = "bold", fontSize = "30px"),
           align = "center") %>% 
  hc_subtitle(text = "'And that kids is the story of how I met your mother'",
              style = list(fontWeight = "bold"),
              align = "center") %>% 
  hc_xAxis(categories = fans_react$Fans,
           style = list(fontWeight = "bold")) %>% 
  hc_add_theme(hc_theme_ffx()) %>% 
  hc_credits(enabled = TRUE,
             text = "Data Source:Based on a study done by Canvs as reported by The Atlantic") %>% 
  hc_legend(enabled = FALSE) %>% 
  hc_series(
    list(
      name = "Bars",
      data = fans_react$Contribution,
      colorByPoint = TRUE,
      type = "column",
      colors = ifelse(fans_react$Contribution <mean(fans_react$Contribution),"#ffeda0","#c51b8a")
    ),
    list(
      name = "Bars",
      data = fans_react$Contribution,
      pointPlacement = "on",
      type = "line")) 




