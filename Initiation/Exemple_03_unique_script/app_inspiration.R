

# App 1
library(shiny)

ui <- fluidPage(
  
)

server <- function(input, output, session) {
  
}

shinyApp(ui, server)

# App 2

library(highcharter)
library(DT)
library(shiny)
db <- mtcars
ui <- fluidPage(DTOutput("my_dt"),
                highchartOutput("my_hc"))
server <- function(input, output, session) {
  output$my_dt <- renderDT({
    db
  })
  output$my_hc <- renderHighchart({
    db_hc <-
      db[input$my_dt_rows_selected, ] # filter dataset according to select rows in my_dt
    hc <- highchart() %>%
      hc_add_series(name = "mpg", data = db_hc$mpg) %>%
      hc_add_series(name = "wt", data = db_hc$wt)
    hc
  })
}

shinyApp(ui, server)