ddc-demo: Predicting, visualizing Delhi air pollution
=======

### Summary

4 November 2015. This project will have two goals: to use air pollution data to (1) predict future pollution, and (2) visualize those predictions.

### Resources
* [AirNow (US Gov)](http://www.airnow.gov/)
* [SAFAR - India](http://safar.tropmet.res.in/index.php?menu_id=1)
* [An example of linked vizi](https://shanthi54.github.io/cs171-project-dbs-mexico/)


### TODO

1. ~~Get `git` set up.~~
2. Lit review of existing time-series predictive models for environmental factors.
3. Line chart of past pollution data.
   * ~~`aqi_data_old.dta` to two `.csvs`: full data, only PM2.5 (`aqi_pm25.csv`).~~
   * ~~Template: IndiaSpend.~~
   * Why the weird line restart?
   * chart `g`. 
   * Generate some example predictions.
   * Restrict time range.
   * Move chart down a bit/some styling.
4. Heat map of pollution around each of the 11 monitors. Which monitors are broken? Which have constant data?
  * TopoJSON?
  * Get a map of Delhi up, dots for stations.
  * How to link the two maps?
5. ~~Get station geodata.~~
6. `x-axis`: What time scale makes sense? Last week? Month? 