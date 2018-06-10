# FuzzTestRefactor
Fuzz Test Refactor
- A simple app that displays data from an endpoint
- data can be sorted via the segmented controll via all/text/images
Refactored for selecting cell based on data type of "image" or "text". 
Changed networking to endpoint from singleton configuration to URLSession dataTask in view controllers. 
Abstracted cell configuration away from view controllers, into custom FuzzTableViewCell.
- "N/A" placeholder image used in cell
- some of the data's jpg/gif/png links redirect to websites so the imageView is blank
