# required packages
library(shiny)
library(ggvis)
library(dplyr)
source("../code/functions.R")

# Variable names for histograms
file = "../data/cleandata/cleanscores.csv"
dat = read.csv(file = file, stringsAsFactors = F)
continuous = unlist(colnames(dat)[2:(ncol(dat)-2)])

# Define UI for application that draws a histogram
ui <- fluidPage(
  
  # Application title
  titlePanel("Grade Visualizer"),
  
  # Sidebar with different widgets depending on the selected tab
  sidebarLayout(
    sidebarPanel(
      conditionalPanel(condition = "input.tabselected == 1",
                       tableOutput(outputId = "grades_distribution")),
      conditionalPanel(condition = "input.tabselected == 2",
                       selectInput("var1", "X-axis variable", continuous, 
                                   selected = "HW1"),
                       sliderInput("width", "Bin Width", 
                                   min = 1, max = 10, value = 10)
      ),
      conditionalPanel(condition = "input.tabselected == 3",
                       selectInput(inputId = "var2", label = "X-axis variable", continuous, 
                                   selected = "Test1"),
                       selectInput(inputId = "var3", label = "Y-axis variable", continuous, 
                                   selected = "Overall"),
                       sliderInput(inputId = "opacity", label = "Opacity",
                                   min = 0, max = 1, value = 0.7),
                       radioButtons(inputId = "options", label = "Show line",
                                    choices = list(
                                      "none" = 0,
                                      "lm" = 2,
                                      "loess" = 3
                                    ), selected = 0
                                    )
      )
    ),
    mainPanel(
      tabsetPanel(type = "tabs",
                  tabPanel(title = "Barchart", value = 1, 
                          ggvisOutput("barchart")),
                  tabPanel("Histogram", value = 2, 
                           ggvisOutput("histogram"), 
                           h3("Statistics"),
                           verbatimTextOutput("summary")),
                  tabPanel("Scatterplot", value = 3, 
                           ggvisOutput("scatterplot"),
                           h3("Correlation"),
                           verbatimTextOutput("correlation")),
                  id = "tabselected")
    )
  )
)

# Define server logic
server <- function(input, output) {
  # Table on the sidebar for first tab
  letterGrade = c("A+","A","A-","B+","B","B-","C+","C","C-","D", "F")
  freq = 1:length(letterGrade)
  prop = 1:length(letterGrade)
  for(i in freq) {
    freq[i] = length(dat$Grade[letterGrade[i] == dat$Grade])
    prop[i] = freq[i]/length(dat$Grade)
  }
  grades = data.frame(Grade = letterGrade, freq = freq, prop = prop)
  
  # renders sidetab table
  output$grades_distribution = renderTable(expr = grades)
  
  # Barchart (for 1st tab)
  vis_barchart <- reactive({
    dat %>% 
      ggvis(x = ~Grade, fill := 'GREEN') %>% 
      layer_bars(stroke := "GREEN", 
                 fillOpacity := 0.5, fillOpacity.hover := 1) %>%
      add_axis("y", title = "frequency")
  })
  
  vis_barchart %>% bind_shiny("barchart")
  
  # renders summary
  output$summary = renderPrint(print_stats(summary_stats(dat[,input$var1])))
  
  # Histogram (for 2nd tab)
  vis_histogram <- reactive({
    var2 <- prop("x", as.symbol(input$var1))
    
    dat %>% 
      ggvis(x = var2, fill := "#abafb5") %>% 
      layer_histograms(stroke := 'white',
                       width = input$width)
  })
  
  vis_histogram %>% bind_shiny("histogram")
  
  # render correlation
  output$correlation = renderText(cor(dat[,input$var2], dat[,input$var3]))
  
  # Scatterplot (for 3rd tab)
  vis_scatterplot <- reactive({
    var2 <- prop("x", as.symbol(input$var2))
    var3 <- prop("y", as.symbol(input$var3))
    if(input$options == 0) {
      dat %>% 
        ggvis(x = var2, y = var3) %>%
        layer_points(fillOpacity := input$opacity)
    } else if(input$options == 1) {
      dat %>% 
        ggvis(x = var2, y = var3) %>%
        layer_points(fillOpacity := input$opacity) %>%
        layer_smooths()
    } else if(input$options == 2) {
      dat %>% 
        ggvis(x = var2, y = var3) %>%
        layer_points(fillOpacity := input$opacity) %>%
        layer_model_predictions(model = "lm", se = TRUE)
    }
  })
  
  vis_scatterplot %>% bind_shiny("scatterplot")
  
}

# Run the application 
shinyApp(ui = ui, server = server)