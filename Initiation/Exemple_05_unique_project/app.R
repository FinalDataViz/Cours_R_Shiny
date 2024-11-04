
library(highcharter)
library(DT)
library(shiny)
library(readr)
library(bslib)

db <- read_csv("donnees_fragilite_pays.csv")

ui <- fluidPage(
    theme = bs_theme(version = 4, bootswatch = "cerulean"),
    titlePanel("AppViz de l'Indice de fragilité des Pays"),
    DTOutput("my_dt"),
    highchartOutput("my_hc"))

server <- function(input, output, session) {

    output$my_dt <- renderDT({
        db %>% datatable(selection = "single", options = list(pageLength = 3))
    })
    
    output$my_hc <- renderHighchart({
        
        db_hc <- db[input$my_dt_rows_selected, ]
        
        hc <- highchart() %>%
            hc_add_series(name = db_hc$Pays, data = as.numeric(db_hc[1,-1])) %>% 
            hc_xAxis(categories = names(db_hc)[-1]) %>% 
            hc_add_theme(hc_theme_google())
        hc
    })
}

shinyApp(ui, server)