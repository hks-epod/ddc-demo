ddc-demo: Predicting, visualizing Delhi air pollution
=======

### Summary

4 November 2015. This project will have two goals: to use air pollution data to (1) predict future pollution, and (2) visualize those predictions.

### Resources
* [AirNow (US Gov)](http://www.airnow.gov/)
* [SAFAR - India](http://safar.tropmet.res.in/index.php?menu_id=1)
* [An example of linked vizi](https://shanthi54.github.io/cs171-project-dbs-mexico/)
* [Mike Bostock: Using tooltips to find x-values on a line chart](http://bl.ocks.org/mbostock/3902569)
* [Mike Bostock: Multi-series line chart](http://bl.ocks.org/mbostock/3884955)
* [Air quality prediction hackathon winning model](https://github.com/benhamner/Air-Quality-Prediction-Hackathon-Winning-Model)


### TODO

1. ~~Get `git` set up.~~
2. Lit review of existing time-series predictive models for environmental factors.
3. Line chart of past pollution data.
   * ~~`aqi_data_old.dta` to two `.csvs`: full data, only PM2.5 (`aqi_pm25.csv`).~~
   * ~~Template: IndiaSpend.~~
   * ~~Tooltips?~~
   * ~~Style tooltips.~~
   * ~~Why the weird line restart?~~
   * ~~chart `g`?~~
   * Generate some example predictions.
      * Harder than I thought...
   * ~~Restrict time range.~~
   * ~~Check `margins` and how they're working for the axes and the line charts?~~
   * ~~Move chart down a bit/some styling.~~
   * ~~Axes.~~
   * ~~Merge: Average of all stations, or just most reliable? Or most conservative estimate?~~
   * ~~Color the stations.~~
   * ~~Add a legend.~~
   * Fix `NaN` showing up (e.g. in Shadipur station data) - they pop up in the top-left corner of viz. 
   * Semi-transparent white rectangle for title/subtitle/line-labels?
4. Heat map of pollution around each of the 11 monitors. Which monitors are broken? Which have constant data?
  * TopoJSON?
  * Get a map of Delhi up, dots for stations.
  * How to link the two maps?
5. ~~Get station geodata.~~
