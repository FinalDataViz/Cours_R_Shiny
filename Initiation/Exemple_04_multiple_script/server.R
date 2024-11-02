

function(input, output, session) {
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