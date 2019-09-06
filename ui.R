#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("F1 Overtake Prediction"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
       sliderInput("lapmercedes", "Mercedes: Time per lap:", min = 80, max = 90, value = 85),
       sliderInput("lapferrari", "Ferrari: Time per lap", min = 80, max = 90, value = 85 ), 
       sliderInput("advantage", "Advantage (in seconds)", min = 0, max = 40, value = 10 ),
       sliderInput("laps", "Remaining Laps", min = 0, max = 53, value = 10 ),
       radioButtons("leader", "Current Leader",
                    c("Mercedes" = "mer",
                      "Ferrari" = "fer")),
       submitButton("Submit") # New!
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      tabsetPanel(type = "tabs",
                  tabPanel("Prediction", br(), 
                           plotOutput("distPlot"),
                           textOutput("pred1")),
                  tabPanel("Documentation", br(), 
                           h4("F1 Overtake prediction"),
                           p("This application aims to present a simple application that simulates what will
                             happen in the final laps of a race between two cars. Suppose that Mercedes and
                             Ferrari are in the final laps of a race and one car is faster than the other. The question
                             is about if the second card will have enough time to overtake the first car. This
                             is a question that F1 teams analyze in the races. Here, there is a very simple simulation
                             in which we supponse that the lap times for each car are constant so there  
                             the  gap between cars is reduced linearly. Moreover, we suppose that the car overtakes
                             the other when the gap is 0. This is not in practice, but it serves
                             to have a simple model. In order to use this app, you need to specify the following
                             information:"),
                           tags$li("Mercedes: Time per lap: Indicates the time in seconds of the Mercedes car. For 
                             example, if the car achieves times of 1:20:00, you will specify 80 (seconds)"),
                           tags$li("Ferrari: Time per lap: Indicates the time in seconds of the Ferrari car, following
                             the same criteria used for the Mercedes car"),
                           tags$li("Advantage: Indicates the advantage in seconds of the car which is in front. For
                             example, 10 indicates that the first car has an advantage of 10 seconds to the second
                             car"),
                           tags$li("Remaining Laps: Indicates the laps that cars will do before the end of the race.
                             Even if a car is faster, the overtake could not be carried out if there are very laps left"),
                           tags$li("Leader: It is a radio button to specify which car is the current leader (Mercedes or Ferrari)"),
                           tags$li("Submit: A button to carry out the simulation"),
                           p(" "),
                           p("When you click on Submit, the simulation is performed and you can see a graph with the evolution
                             of the gap between cars in the different laps. When the value is positive, it means that the car
                             you specified as a leader is in front. When the value is negative, it means that the second car
                             overtook the first. The lap where the overtake is produced is the lap where the gap is 0. The
                             color of the line indicates the current winner (strong cyan for Mercedes and red for Ferrari). The
                             name of the winner is also displayed after the graph.")
                           ))
      )
    )
  
))
