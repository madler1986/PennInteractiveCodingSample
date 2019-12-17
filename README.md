# PennInteractiveCodingSample

A few notes ...
To store images offline i decided to use just local file storage where the image names correspond to the unique user id property from Stack Overflow. In a more complicated situation I would setup a database but in this case this was the most straightforward way in the time limit. When downloading the JSON data from the API as well as the images themselves i put Activity Indicators over the list and the individual images . I used threading in both of these spots to keep the UI responsive. The downloading is all handled in User.swift. In a real world app i would create a UIImage extension to handle these in a separate file.


