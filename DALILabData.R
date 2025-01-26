
## UNSEEN IMAGE 2 (no labels) ##

# Install packages 
install.packages("imager")
install.packages("magrittr")

library(imager)
library(magrittr)

# Load the image
image_path <- "~/Desktop/Barnacles/unseen_img2.png" 
image_path
barnacle_image <- load.image(image_path)
barnacle_image # Image. Width: 500 pix Height: 500 pix Depth: 1 Colour channels: 3 

# Convert the image to grayscale
gray_image <- grayscale(barnacle_image)

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
cat("Total Barnacles Detected:", total_barnacles, "\n") # Total Barnacles Detected: 1858 
cat("Average Barnacle Area:", average_area, "\n") # Average Barnacle Area: 134.5527 

# Plot the results
par(mfrow = c(1, 3)) 
plot(barnacle_image, main = "Original Image")
plot(binary_mask, main = "Binary Mask")
plot(connected_components, main = "Labeled Barnacles")




