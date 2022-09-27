library(shiny)
#devtools::install_github("Schdomba/advancedRLab5")
library("advancedRLab5")

ui <- fluidPage(
  titlePanel("Municipality Emission Data"),
  sidebarLayout(
    sidebarPanel(
         textInput(inputId = "muni_name", label = "Enter the municipality name",placeholder = "Example : Stockholm"),
      fluidRow(
        column(12,offset = 0,style = "padding-bottom:10px;",
      actionButton(inputId = "submit",label  = "Search", icon = NULL, width = '20%',
                   style="color: #fff; background-color: #EE6E15; border-color: #2e6da4;"))
      ),
      # fluidRow(
      #   column(12,offset = 0)
      # ),
      fluidRow(
        column(3,offset = 0,
      actionButton(inputId = "prev",label = "Previous",width = '100%',
                   style="color: #fff; background-color: #337ab7; border-color: #2e6da4")),
      column(3,offset = 0,
      actionButton(inputId = "nxt",label = "Next",width = '100%',
                   style="color: #fff; background-color: #337ab7; border-color: #2e6da4")))

    ),
    mainPanel(plotOutput(outputId = "plots")

    )
  )

)

#' Server Function of Shiny App
#'
#' @param input The inputs from the user
#' @param output The server outputs, in this case, the plots.
#' @import advancedRLab5
#'
#' @return
#' @export
#'
#'
server <- function(input, output)
{
  count <- reactiveValues(i = 1)
  observeEvent(input$prev,{
    ifelse(count$i==1,count$i<-7,count$i <- (count$i-1))
    # print(i)
    })
  observeEvent(input$nxt,{
    ifelse(count$i==7,count$i <- 1,count$i <- (count$i+1))
    # print(i)
    })
  observeEvent(input$submit,{
    output$plots <- renderPlot({
    plot_figures(input$muni_name)[[count$i]]
  })

  })


     output$i <- renderPrint(count$i)
}

shinyApp(ui,server)
