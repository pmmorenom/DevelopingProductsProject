#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  longitud = 5793
  output$distPlot <- renderPlot({
    
    # generate bins based on input$bins from ui.R
    x    <- seq(input$laps+1)-1
    y    <- adv_mod()
    color = col_win()
    plot(x, adv_mod(), type="b", xlab="Lap", ylab="Advantage (seconds)", 
         main="Gap between the cars over the laps", col = color)
    grid(nx = NULL, ny = NULL, col = "lightgray", lty = "dotted")
  })
  
  adv_mod <- reactive({
    leader = input$leader
    init_adv = input$advantage
    
    if(leader == "mer"){
        mod = init_adv + (input$lapferrari - input$lapmercedes)*(seq(input$laps+1)-1) 
    } else {
        mod = init_adv + (input$lapmercedes - input$lapferrari)*(seq(input$laps+1)-1)
    }
  })
  
  winner <- reactive({
    finish_dist = tail(adv_mod(),1)
    leader = input$leader
    if(leader == "mer"){
      if(finish_dist >= 0){
        res = "Mercedes wins!"
      } else {
        res = "Ferrari wins"
      }
    } else {
      if(finish_dist >= 0){
        res = "Ferrari wins!"
      } else {
        res = "Mercedes wins!"
      }
    }
  })
  
  col_win <- reactive({
    finish_dist = tail(adv_mod(),1)
    leader = input$leader
    if(leader == "mer"){
      if(finish_dist >= 0){
        res = "#00D2BE"
      } else {
        res = "#DC0000"
      }
    } else {
      if(finish_dist >= 0){
        res = "#DC0000"
      } else {
        res = "#00D2BE"
      }
    }
  })
  
  
  output$pred1 <- renderText({
    winner()
  })
  
})
