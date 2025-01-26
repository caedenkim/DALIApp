
## UNSEEN IMAGE 1 (no labels) ##
## Does not detect green frame; requires prior knowledge of green frame coordinates ##

# Install packages
install.packages("imager")
install.packages("magrittr")

library(imager)
library(magrittr)

# Load the image
image_path <- "~/Desktop/Barnacles/unseen_img1.png" # Replace with the actual path
barnacle_image <- load.image(image_path)

# Display the original image to identify coordinates of the green frame
plot(barnacle_image, main = "Original Image")
# Use the cursor or prior knowledge to define the green frame coordinates manually

# Define coordinates for the green frame (example values - adjust as needed)
# Example: x_min = 100, x_max = 400, y_min = 50, y_max = 350
x_min <- 100
x_max <- 400
y_min <- 50
y_max <- 350

# Crop the image to the green frame
cropped_image <- barnacle_image[x_min:x_max, y_min:y_max,, drop = FALSE]

# Convert the cropped image to grayscale
gray_image <- grayscale(cropped_image)

# Apply binary thresholding (Otsu's method)
binary_mask <- gray_image > mean(gray_image)

# Invert the mask for contour detection
binary_mask <- !binary_mask

# Label connected components (barnacles)
connected_components <- imager::label(binary_mask)

# Count the total number of barnacles
total_barnacles <- max(connected_components)

# Calculate barnacle areas
barnacle_areas <- table(connected_components)[-1] # Remove background
average_area <- mean(as.numeric(barnacle_areas))

# Display the results
cat("Total Barnacles Detected (Green Frame):", total_barnacles, "\n") # Total Barnacles Detected (Green Frame): 635 
cat("Average Barnacle Area (Green Frame):", average_area, "\n") # Average Barnacle Area (Green Frame): 68.1685 

# Plot the results
par(mfrow = c(1, 3))
plot(cropped_image, main = "Cropped Image (Green Frame)")
plot(binary_mask, main = "Binary Mask")
plot(connected_components, main = "Labeled Barnacles")

