*******************************************************************************
*																			*
* PROJECT: 	India Ambient													* 
*																			*
* PURPOSE: Construct Air Quality Prediction Model for DDC				    *
*																			*
* DATE: November 13th, 2015													*
*																			*
* AUTHOR:  Raahil Madhok 													*
*																				
********************************************************************************

********************************************************************************
*1. SET ENVIRONMENT
********************************************************************************

// Settings
clear all
pause on
cap log close
set more off

//Set Directory
/*---------------------------------------------------------------------------
Sets path directory for each users computer so program can run on any device.
Toggle local value when switching user
----------------------------------------------------------------------------*/
local RAAHIL 0
local SUJOY  1
local ANGELA 0

if `RAAHIL' {
	local ROOT /Users/rmadhok/Dropbox (CID)/India Ambient/DDC - Demo
	local DATA `ROOT'/data
	local TABLE `ROOT'/table
	}

if `SUJOY' {
	local ROOT "/Users/sujoybhattacharyya/Dropbox/India Ambient/DDC - Demo"
	local DATA "`ROOT'/data"
	local TABLE	"`ROOT'/table"
	//[INSERT LOCALS FOR FILE PATHS]
	}

if `ANGELA' {
	local ROOT
	local DATA
	local TABLE
	//[INSERT LOCALS FOR FILE PATHS]
	}
********************************************************************************
*2. OPEN DATA
********************************************************************************
use "`DATA'/aqi_data_ddc.dta", clear

//restrict dataset
gen year = year(date_r)
gen month = month(date_r)
gen day = day(date_r)
gen date=mdy(month,day,year)
gen year_month=ym(year,month)
format year_month %tmCCYY-NN
keep if station == 26  & date>20170
saveold "`DATA'/aqi_date_ddc_use.dta",  v(13) replace 

//add labels
la var dt_clean "Time (15-minute Intervals)"
la var  pressure_average "Average Pressure"
la var humidity_average "Average Humidity"
la var solar_radiation_average "Average Solar Radiation"
la var wind_speed_average "Average Wind Speed"
la var temperature_average "Average Temperature"

********************************************************************************
*3. CONSTRUCT PREDICTIONS
********************************************************************************
eststo: reg pm25_aqi dt_clean
eststo: reg pm25_aqi dt_clean pressure_average humidity_average solar*average ///
			wind*average temp*average
eststo: xi: reg pm25_aqi dt_clean pressure_average humidity_average solar*average ///
			wind*average temp*average i.month i.day
			
esttab using "`TABLE'/output.tex" , replace keep(dt_clean *average) ///
	title(Time-Series Determinants of PM2.5 Pollution at Shadipur Station) ///
	stats(N r2 f p, labels("N" "\$R^2\$" "\$F\$-Statistic" "\$p\$-value") ///
	fmt(0 3 3 3)) label alignment(l) varwidth(25) width(0.8\hsize) ///
	mgroups("PM2.5" "PM2.5" "PM2.5" , pattern(1 1 1) ///
	prefix(\multicolumn{@span}{c}{) suffix(}) span erepeat(\cmidrule(lr){@span})) ///
	nomtitles indicate("Month Dummies=_Imonth*" "Day Dummies=_Iday*") ///
	addnotes(Weather controls represent an 8-hour moving average) ///
	star(* .1 ** .05 *** .01) booktabs se b(%5.3f) se(%5.3f)
drop _I*

//Redo Model Until September
qui reg pm25_aqi dt_clean pressure_average humidity_average solar*average ///
			wind*average temp*average if month<9
predict pm25_aqi_pred if month<9
predict pm25_aqi_resid if month<9, residuals


xi: qui reg pm25_aqi dt_clean pressure_average humidity_average solar*average ///
			wind*average temp*average i.month i.day
predict pm25_aqi_pred2 if month<9
predict pm25_aqi_resid2 if month<9, residuals
drop _I*

***************************************
* LAGGED MODEL
***************************************
// general idea: estimate p_t = B*p_(t-1) + D*w_i 
//i.e. regress today's pollution on yesterday's pollution and weather covariates
use "`DATA'/aqi_date_ddc_use.dta", clear

//15 minute lags
gen pm25_aqi_lag_1 = pm25_aqi[_n - 1]		///15 minute lag
gen pm25_aqi_lag_2 = pm25_aqi[_n - 2]		///30 minute lag

eststo: reg pm25_aqi pm25_aqi_lag_1
eststo: reg pm25_aqi pm25_aqi_lag_1 pressure_average humidity_average solar*average ///
			wind*average temp*average
eststo: xi: reg pm25_aqi pm25_aqi_lag_1 pressure_average humidity_average solar*average ///
			wind*average temp*average i.month i.day
			
esttab using "`TABLE'/output_lag.tex" , replace keep(pm25_aqi_lag_1 *average) ///
	title(Time-Series Determinants of PM2.5 Pollution at Shadipur Station) ///
	stats(N r2 f p, labels("N" "\$R^2\$" "\$F\$-Statistic" "\$p\$-value") ///
	fmt(0 3 3 3)) label alignment(l) varwidth(25) width(0.8\hsize) ///
	mgroups("PM2.5" "PM2.5" "PM2.5" , pattern(1 1 1) ///
	prefix(\multicolumn{@span}{c}{) suffix(}) span erepeat(\cmidrule(lr){@span})) ///
	nomtitles indicate("Month Dummies=_Imonth*" "Day Dummies=_Iday*") ///
	addnotes(Weather controls represent an 8-hour moving average) ///
	star(* .1 ** .05 *** .01) booktabs se b(%5.3f) se(%5.3f)
drop _I*


**
