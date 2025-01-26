**DALI LAB DATA CHALLENGE**

Scientists with the National Park Service are researching barnacle populations in coastal tide pools on the east coast. To analyze the results of their experiments, they often need to count the number of barnacles in a given area. To do this, they place a fixed size frame on a barnacle-covered rock, then take a picture. Later, a scientist/lab tech will manually count the number of barnacles in the picture, then record their results. There are often upwards of 1000 barnacles in an image, so this is a very time consuming process. 

These scientists have now come to you to speed up their pipeline. What system can you develop to help them process these images faster?

To develop a solution, you are provided with several images of barnacles (with the fixed size green frame) in the following folder: 


Barnacles: sticky little crustaceans related to crabs, lobsters, and shrimps



**Brainstorm an idea for a system:**
Develop a computer vision-based system that automates the identification and analysis of barnacle populations from images or videos of marine habitats. The system could measure barnacle density, size, and growth rates over time by processing photos taken at regular intervals, significantly speeding up manual analysis.

**Critical subtasks:**
- Image Preprocessing
  Input: Images of barnacles.
  Output: Enhanced and filtered images suitable for further analysis.
- Barnacle Detection and Segmentation:
  Input: Preprocessed images.
  Output: Coordinates and boundaries of individual barnacles in the image.
- Measurement and Analysis:
  Input: Detected barnacle boundaries.
  Output: Metrics like barnacle size, density, and growth rates.
- Data Visualization:
  Input: Analytical results.
  Output: Heatmaps, charts, or time-lapse animations showing changes in barnacle populations.

**Build a prototype:**
DALILabData.R 
- Analyzes an image of barnacles by detecting, counting, and measuring the areas of individual barnacles.
- Using unseen_img2.png
DALILabData2.R 
- Same code as DALILabData.R, applied to unseen_img1.png
- Not applicable because it does not take into account the green frame.
DALILabData2.5.R 
- Takes green frame into account; HOWEVER, requires prior knowledge of green frame coordinates.
- AKA does not automatically detect the green frame.
DALILabData3.R 
-  Defines a Shiny app that allows you to analyze barnacle data based on image processing results.
-  Not accurate because it uses FAKE DATA (location, latitude, longitude, and date) for each image.

**Key Features:**
- Image Processing:
  Processes the two provided images to calculate barnacle counts and average areas.
- Static Dataset:
  Predefined metadata (location, latitude, longitude, and date) for each image.
- Visualizations:
  Heatmap: Displays barnacle density by location.
  Time Series: Shows barnacle counts over time.
  Map: Interactive map with barnacle density and metadata.

**Conclusions:**
This challenge was super hard but very worthwhile! I was able to apply image processing techniques that I learned from past data visualization courses, as well as new techniques I learned through research. I did a lot of research on different R packages before coming across ones that actually worked and were applicable to the given data. I did have to make up some fake data to fill in gaps where real data was unavailable, but the final prototype ended up working!

Through this project, I learned about concepts like binary thresholding and connected component analysis. I also improved my coding skills, particularly in debugging, troubleshooting, and testing different approaches when things didn’t work as expected. It was rewarding to see the barnacle data visualized in multiple formats, from heatmaps to interactive maps. Overall, this project not only strengthened my technical skills but also reinforced the importance of persistence and creative problem-solving in tackling complex challenges.



