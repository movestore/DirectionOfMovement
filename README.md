# Direction Of Movement

MoveApps

Github repository: https://github.com/movestore/DirectionOfMovement

## Description
Calculation of the direction of movement of each segment between consecutive locations.

## Documentation
This App calculates the direction of movement of each segment between consecutive locations. This measurement is a segment characteristic, and will be assigned to the first location of each segment. Therefore the direction of the last location of the track will be set to NA. 

The direction of movement is calculated as angles in degrees from -180 to 180. Where 0 corresponds to North, negative values go towards the West and positive values towards the East.

A column named _**directionOfMovement**_ will be appended to the dataset that is returned for further use in next Apps.

A histogram of the directions distribution of all individuals and per individual is automatically created and can be downloaded in the output as a pdf.

*Note*: the attribute **heading** is recorded by many tags and therefore present in many datasets. This value represents the instantaneous heading of the tag when the GPS location was recorded. This value will often not represent the direction of movement nor the position of the animal due to the placement of the tag (e.g. collar) or environmental conditions through which the animal is moving (e.g. bird is blown sideways by strong winds). 

### Input data
moveStack in Movebank format

### Output data
moveStack in Movebank format

### Artefacts
`directionOfMovement_histogram.pdf`: PDF with histograms of the azimuths per individual

### Parameters
no parameters 

### Null or error handling
**Data**: The full input dataset with the addition of the direction of movement is returned for further use in a next App and cannot be empty.
