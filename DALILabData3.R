

# Install packages
install.packages("shiny")
install.packages("ggplot2")
install.packages("leaflet")
install.packages("dplyr")
install.packages("imager")

library(shiny)
library(ggplot2)
library(leaflet)
library(dplyr)
library(imager)

# Helper function to process images and count barnacles
process_image <- function(image_path) {
  image <- load.image(image_path)
  
  # Convert to grayscale
  gray_image <- grayscale(image)
  
  # Apply binary threshold
  binary_mask <- gray_image > mean(gray_image)
  
  # Label connected components to count barnacles
  labeled_barnacles <- label(binary_mask)
  barnacle_count <- max(labeled_barnacles)
  
  # Calculate average barnacle area
  barnacle_areas <- as.numeric(table(labeled_barnacles)[-1])
  avg_barnacle_area <- mean(barnacle_areas)
  
  return(list(
    barnacle_count = barnacle_count,
    avg_barnacle_area = avg_barnacle_area
  ))
}

# Preprocess images and create a dataset
image_data <- data.frame(
  image_id = c("Image 1", "Image 2"),
  location = c("Location A", "Location B"),
  lat = c(43.5, 43.6), # Random latitude & longitude on the east coast
  lon = c(-70.1, -70.2),
  date = as.Date(c("2025-01-01", "2025-01-02")),
  stringsAsFactors = FALSE
)

# Process the images
image_paths <- c("~/Desktop/Barnacles/unseen_img1.png", "~/Desktop/Barnacles/unseen_img2.png") # Replace with actual image paths
processed_data <- lapply(image_paths, process_image)

# Add the processed data to the dataset
image_data <- image_data %>%
  mutate(
    barnacle_count = sapply(processed_data, `[[`, "barnacle_count"),
    avg_barnacle_area = sapply(processed_data, `[[`, "avg_barnacle_area")
  )

# UI for the Shiny app
ui <- fluidPage(
  titlePanel("Barnacle Density Dashboard"),
  
  sidebarLayout(
    sidebarPanel(
      selectInput(
        "location_filter",
        "Select Location:",
        choices = unique(image_data$location),
        selected = unique(image_data$location),
        multiple = TRUE
      )
    ),
    
    mainPanel(
      tabsetPanel(
        tabPanel("Heatmap", plotOutput("heatmap_plot")),
        tabPanel("Time Series", plotOutput("time_series_plot")),
        tabPanel("Map", leafletOutput("map_plot"))
      )
    )
  )
)

# Server for the Shiny app
server <- function(input, output) {
  # Reactive data based on filters
  filtered_data <- reactive({
    image_data %>%
      filter(location %in% input$location_filter)
  })
  
  # Heatmap plot
  output$heatmap_plot <- renderPlot({
    ggplot(filtered_data(), aes(x = location, y = barnacle_count)) +
      geom_tile(aes(fill = barnacle_count)) +
      scale_fill_gradient(low = "blue", high = "red") +
      theme_minimal() +
      labs(
        title = "Barnacle Density Heatmap",
        x = "Location",
        y = "Barnacle Count",
        fill = "Density"
      )
  })
  
  # Time series plot
  output$time_series_plot <- renderPlot({
    ggplot(filtered_data(), aes(x = date, y = barnacle_count, color = location)) +
      geom_line(size = 1) +
      geom_point(size = 2) +
      theme_minimal() +
      labs(
        title = "Barnacle Density Over Time",
        x = "Date",
        y = "Barnacle Count",
        color = "Location"
      )
  })
  
  # Map plot
  output$map_plot <- renderLeaflet({
    leaflet(data = filtered_data()) %>%
      addTiles() %>%
      addCircleMarkers(
        ~lon, ~lat,
        radius = ~barnacle_count / 10,
        color = "red",
        label = ~paste("Location:", location, "<br>", "Count:", barnacle_count),
        popup = ~paste("Date:", date, "<br>", "Barnacle Count:", barnacle_count, "<br>",
                       "Avg Area:", round(avg_barnacle_area, 2))
      )
  })
}

# Run the Shiny app
shinyApp(ui = ui, server = server)
