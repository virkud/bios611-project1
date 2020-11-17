# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#    http://shiny.rstudio.com/

library(shiny)
library(tidyverse)
library(plotly)

#drug_table <- list()
#drug_table[[drug_name]] <- read_csv("")
#drug_table[["ACet"]]
#if(is.null(drug_table[["ACet"]])) drug_table["ACet"] <- read_csv("theACETFile")

args <- commandArgs(trailingOnly=T);
port <- as.numeric(args[[1]]);

data <- read_csv("derived_data/s_app.csv")
drugs <- data$drug %>% unique() %>% sort();


# Define UI for application that draws a histogram
ui <- fluidPage(

    # Application title
    titlePanel("Commonly prescribed medications among Heart Failure patients"),
    # Sidebar with a slider input for number of bins 
    sidebarLayout(
        sidebarPanel(
            sliderInput(inputId = "bins",
                        label = "Number of bins:",
                        min = 1,
                        max = 50,
                        value = 30),
            
            selectInput(inputId = "drug",
                        label="Select Drug",
                        choices=drugs)
        ),

        # Show a plot of the generated distribution
        mainPanel(
            # Output: Histogram ----
            plotlyOutput(outputId = "distPlot")
        )
    )
)


# Define server logic required to draw a histogram
server <- function(input, output) {
    output$distPlot <- renderPlotly({
        rx <- input$drug
        ct <- data %>% filter(drug==rx)
        ggplotly(ggplot(ct, aes(n))+geom_histogram(aes(fill=gender),
                                                        position="dodge",
                                                        bins=input$bins))
    })
}

# Run the application 
shinyApp(ui = ui, server = server)
print(sprintf("Starting shiny on port %d", port));
shinyApp(ui = ui, server = server, options = list(port=port,
                                                 host="0.0.0.0"))