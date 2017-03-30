# Plot.ly Scattergeo Plot with Timeline to Filter out Data

This template is designed to take data in the following format:

| Send.Location | Send.City | Receive.Location | Receive.City | Date | Category |
| --- | --- | --- | --- | --- | --- |
| 50.97178 13.960129 | DEU, Mockethal | 50.97178 13.960129 | DEU, Mockethal | 1800-01-01 | A |

<img src="https://raw.githubusercontent.com/ox-it/Live-Data_Scripts-and-Templates/master/Shiny-Templates/Self-Contained-Apps/Plotly-map-with-timeline/plotly-with-timeline_screenshot.png" width = "400px"/>

The script file will tally the number of items sent/received per location as well as tallying send/receive pairs, the data is then displayed in an interactive shiny app using a [plot.ly](http://plot.ly) geoscatter chart. Locations are displayed as dot with the size scaled by the the total number of send and receive events for the location, the colour of the indicates which category(ies) of communication were made between locations.

This template was inspired by work carried out in the Live Data project for Felix Krawatzek ([http://www.politics.ox.ac.uk/academic-staff/felix-krawatzek.html](http://www.politics.ox.ac.uk/academic-staff/felix-krawatzek.html)) which is detailed [here](https://github.com/ox-it/Live-Data_Case-Studies/tree/master/2016%20Case%20Studies/German-Migrant-Letters).

# Attribution

Code is made available subject to a MIT license, the following copyright and attribution should be respected when reusing the code

- Copyright Owner: University of Oxford
- Date of Authorship: 2016
- Developer: Martin John Hadley (orcid.org/0000-0002-3039-6849)
