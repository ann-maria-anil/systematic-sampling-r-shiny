library(shiny)
library(ggplot2)

ui <- fluidPage(
  titlePanel("Systematic Sampling – Design of Experiment"),
  
  sidebarLayout(
    sidebarPanel(
      numericInput("N", "Population Size (N)", value = 240, min = 60),
      sliderInput("Z", "Confidence Level (Z value)",
                  min = 1.64, max = 2.58, value = 1.96, step = 0.01),
      sliderInput("B", "Sampling Bias / Allowable Error",
                  min = 1, max = 10, value = 5),
      actionButton("calc", "Generate Design")
    ),
    
    mainPanel(
      h4("Sampling Plan Summary"),
      tableOutput("summary"),
      br(),
      h4("Design of Experiment Layout"),
      plotOutput("plot", height = "450px")
    )
  )
)

server <- function(input, output) {
  
  sampling_design <- eventReactive(input$calc, {
    
    S <- 20
    
    n <- ceiling((input$Z^2 * S^2) / (input$B^2))
    k <- floor(input$N / n)
    r <- sample(1:k, 1)
    
    selected <- seq(r, input$N, by = k)
    
    blocks <- ceiling(input$N / k)
    
    df <- data.frame(
      Unit = 1:input$N,
      Block = ceiling((1:input$N) / k)
    )
    
    df$Selected <- ifelse(df$Unit %in% selected, "Selected", "Not Selected")
    
    list(df = df, N = input$N, n = n, k = k, r = r)
  })
  
  output$summary <- renderTable({
    d <- sampling_design()
    data.frame(
      Parameter = c("Population Size (N)",
                    "Sample Size (n)",
                    "Sampling Interval (k)",
                    "Random Start"),
      Value = c(d$N, d$n, d$k, d$r)
    )
  })
  
  output$plot <- renderPlot({
    d <- sampling_design()
    df <- d$df
    
    ggplot(df, aes(x = Unit, y = Block, fill = Selected)) +
      geom_tile(color = "white", height = 0.9) +
      scale_fill_manual(
        values = c("Not Selected" = "grey85",
                   "Selected" = "steelblue")
      ) +
      labs(
        title = "Systematic Sampling Design (Block Representation)",
        subtitle = paste("Each block represents interval k =", d$k,
                         "| One unit selected per block"),
        x = "Ordered Population Units",
        y = "Sampling Blocks",
        fill = "Unit Status"
      ) +
      theme_minimal() +
      theme(
        plot.title = element_text(face = "bold"),
        legend.position = "bottom"
      )
  })
}

shinyApp(ui, server)
