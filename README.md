# Heading Of Segment Between Locations

MoveApps

Github repository: https://github.com/movestore/Heading_BetweenLocations

## Description
Calculation of the heading of each segment between consecutive locations.

## Documentation
This App calculates the heading of each segment between consecutive locations. This measurement is a segment characteristic, and will be assigned to the first location of each segment. Therefore the heading of the last location of the track will be set to NA. 

The headings are calculated as angles in degrees from -180 to 180. Where 0 corresponds to North, negative values go towards the West and positive values towards the East.

A column named _**heading**_ will be appended to the dataset that is returned for further use in next Apps.

A histogram of the headings distribution of all individuals and per individual is automatically created and can be downloaded in the output as a pdf.

### Input data
moveStack in Movebank format

### Output data
moveStack in Movebank format

### Artefacts
`heading_histogram.pdf`: PDF with histograms of the headings per individual

### Parameters
no parameters 

### Null or error handling
**Data**: The full input dataset with the addition of headings is returned for further use in a next App and cannot be empty.
