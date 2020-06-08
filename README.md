# Leaf-Angle-eXtractor
A MATLAB based framework for leaf angle measurements from image data

*Image Processing Framework*

This section describes in detail, tasks performed by the image processing framework and indicate where manula input is required.

*A. Welcome Screen*

A welcome screen that serves as an initial starting point in the application provides the user with useful information about the creation of the project as well as example imagery of the capability of the program. The user has to select ‘New Project’ to continue to the next step. The welcome screen also has an ‘About’ button (question mark icon) that gives useful information about the program. The ‘New’ button will bring the user back to the welcome screen at any time.

*B. Selecting Time-Lapse images*

To define the set of images that make up the time-lapse sequence, the user has to choose a folder with all images in the series (If the pictures have arbitrary file names, then a sort function has to be used to order the files). LAX sorts the images by their date of creation.  The utility then stores all the images in a cell array, where each cell contains the RGB value data for a sequential image from the time-lapse. The user has the option to press the ‘continue’ button that will take them to the next step while pressing the ‘undo’ button returns the user to the welcome screen.

*C. Selecting the Initial Frame*

To pick the start frame for analysis, the user must choose an initial value by moving the slider.  As the slider is moved, a preview of that frame is generated in the GUI.  By pressing ‘continue’, the slider value is retained for future use. 

*D. Selecting Plant for Analysis*

Following the selection of the first frame, the user must specify the individual plant to be used in the analysis. This is accomplished by interpreting the location at which the user clicks the screen. By clicking the bottom center of the plant (center of the stalk), the individual plant may be cropped.

*E. Select Leaves for Analysis*

Once the individual plant is selected, the user can choose the appropriate leaf/leaves for analysis. This enables the user to choose leaf-angle data from leaves of interest, rather than collecting data for all leaves in the plant. For this, a rectangular selection tool is provided.  Each rectangle selected by the user represents the search limits for a leaf during the analysis portion of the framework. To allow the user as much flexibility as possible, an added confirmation box is included after drawing a rectangle. This ensures that the user has options to re-draw a rectangle should their initial choice be suboptimal.

*F. Set Initial Threshold*

The user must define the thresholding properties to create a binary image. To accomplish this, the user can use the slider to adjust the threshold level. A manually editable text box that displays the slider value is also incorporated to change the threshold level. To switch between the red, green, and blue channels, a popup-menu selector is utilized.  Finally, to allow functionality for infrared imagery, an ‘invert colors’ checkbox is added that allows the user to switch the criteria of the foreground from high intensity to low intensity. Pressing the ‘continue’ button saves these properties and takes the user to the next step.

*G. Select Final Frame*

For the selection of the final frame, the preview image contains only the area within the original crop bounds rather than the entirety of the time-lapse image frame.  The sequential value of the first frame limits the lower bound for the final frame selection.  The maximum value is constrained by the total number of frames in the time-lapse.  Pressing ‘continue’ retains the slider value and brings the user to the next step.

*H. Set Final Threshold*

A final threshold step is utilized to accommodate a linear change in the lighting of the time-lapse.  By having two different threshold levels, it is possible to interpolate level values for all frames under analysis, giving the user more control over the accuracy of the analysis. The final threshold step is performed on the last sequential image and is similar to the initial threshold step with less variable objects because the color channel and whether or not the image has been inverted has already been determined. Pressing ‘continue’ saves the final threshold level and brings the user to the ready screen to perform analysis.

*I. Perform Leaf Angle Analysis*

This step serves as a confirmation screen before performing the leaf angle analysis.  It displays the binary image of the initial and final frame side by side.  By doing this, the user can correct any possible errors made in initial inputs before the analysis is underway.  Pressing the ‘start analysis’ button begins the estimation of leaf angle.  The analysis is completed for each leaf of the plant by isolating the region of the leaf, thresholding the image, and using the region property of the largest connected component to determine the orientation of the leaf. A status bar is utilized to inform the user of the progression of the analysis. After the analysis is complete the program will automatically continue to the finish screen.

*J. Finish Screen*

The finish screen provides a useful image of the plant with each of the leaves under analysis labeled. These labels correspond to the graph, which opens in a second window. The graph shows the leaf angle as a function of the frame count.  Because the frequency at which images are captured in a time-lapse may be different for dissimilar analyses, the x-value is set as frame counts. The users are given the option to export the collected data to a .csv file.  The column number in the output data corresponds to the leaf number as shown in the final image screen.

*CREDITS*

This MATLAB framework was developed by Miles Adkin as an undergraduate student in Baskar Ganapathysubramanian lab at Iowa State University. Alex Enersen, an undergraduate student working with Sunil K. Kenchanmane Raju in James Schnable lab, University of Nebraska-Lincoln, made minor modifications to the code for effecient implementation. 
