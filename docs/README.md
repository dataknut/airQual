## airQual: exploration of air quality data

Poor air quality is well known to have both chronic (long term) and acute (short term) impacts on [health](http://www.erg.kcl.ac.uk/Research/home/projects/personalised-health-impacts.html). Air quality is also a useful indicator of traffic and other combustion patterns - i.e. energy use for different purposes at different times of day.

### Southampton (UK) 

#### Covid 19 lockdown analysis (Spring 2020)

We update this [mini-report](https://cfsotago.github.io/airQual/sccAirQualExplore_covidLockdown2020.html) on a regular basis. These are the most recent plots for:

 * NO2 [plot](https://cfsotago.github.io/airQual/sccAirQualExplore_covidLockdown2020.html#fig:no2recent): weekends notably lower <- less travel? Weekdays possibly lower but clearly still ’essential worker’ travel especially mid-week? Notice it started 1 week before true lockdown
 * NOx [plot](https://cfsotago.github.io/airQual/sccAirQualExplore_covidLockdown2020.html#fig:noxrecent): as per NO2?
 * SO2 [plot](https://cfsotago.github.io/airQual/sccAirQualExplore_covidLockdown2020.html#fig:so2recent): Possibly similar to NO2 but...
 * Ozone [plot](sccAirQualExplore_covidLockdown2020.html#fig:03recent): much more affected by weather (sunny first lockdown weekend)?
 * PM10 [plot](sccAirQualExplore_covidLockdown2020.html#fig:pm10recent): as for NO2 but less noticeable the week before lockdown. But also possibly weather effect?
 * PM2.5 [plot](sccAirQualExplore_covidLockdown2020.html#fig:pm25recent): much more obvious lockdown but not pre-lockdown effect. But also possibly weather effect and even maybe a sensor/measurement effect? The AURN data here has not yet been [ratified](https://uk-air.defra.gov.uk/assets/documents/Data_Validation_and_Ratification_Process_Apr_2017.pdf).

[Snapshot](sccAirQualExplore_covidLockdown2020_DEFRA_30_04_2020.html) of the above analysis, some of which was used in response to a [DEFRA call for evidence](https://uk-air.defra.gov.uk/news?view=259).

#### General explorations

See https://www.southampton.gov.uk/environmental-issues/pollution/air-quality/

Southampton homes tend to rely on reticulated (mains) gas, electricity and in [some areas](https://datashine.org.uk/#table=QS415EW&col=QS415EW0007&ramp=YlOrRd&layers=BTTT&zoom=12&lon=-1.4252&lat=50.9258), district heating. However gas boilers, woodburners and (relatively rare) coal fires are known sources of pollutants so heating systems may also be a contributor to poor air quality in Southampton alongside fossil-fuel based transport.

Data sources: 
 
 * Directly: from [http://southampton.my-air.uk/](http://southampton.my-air.uk/) although this site is now mostly inactive. Plots and data also available from http://www.hantsair.org.uk/hampshire/asp/home.asp?la=Southampton;
 * Indirectly: Two of the Southampton sites also feed to http://uk-air.defra.gov.uk/openair/R_data/ and the data can be downloaded using `ōpenair::importAURN()`. We explain which source we use when and why in the analysis.
 
 
NB: The AURN data undergoes a processes of  [ratification](https://uk-air.defra.gov.uk/assets/documents/Data_Validation_and_Ratification_Process_Apr_2017.pdf) with a lag of about 6 months. Data less than 6 months old will not have undergone this process.

AURN data is (c) Crown 2020 copyright Defra via https://uk-air.defra.gov.uk, licenced under the [Open Government Licence](http://www.nationalarchives.gov.uk/doc/open-government-licence/version/2/) (OGL).

 Analysis:
 
 * [Initial exploratory analysis](sccAirQualExplore_Exploring the data.html) - simple & interactive plots, can be slow to load; just uses southampton.my-air.uk
 * [Further exploratory analysis](sccAirQualExploreAURN.html) - uses the excellent [openair](http://davidcarslaw.github.io/openair/) R package
 * [Further exploratory analysis](sccAirQualExplore_Exploring the SSC and AURN data.html) - uses AURN data downloaded via the excellent [openair](http://davidcarslaw.github.io/openair/) R package and SSC data. They mostly agree...
 * [extracting data](sccAirQualDataExtract_Extracting data for modelling.html) for modelling & forecasting
 * [wind and pollution roses](sccAirQualExplore_windroses_Wind and pollution roses 2016-2020 (AURN data).html) using the excellent [openair](http://davidcarslaw.github.io/openair/) R package and AURN data.
 
### New Zealand

See https://www.mfe.govt.nz/air

In contrast to Southampton, New Zealand homes use a mixture of solid (coal/wood), electric (fueled by [hydro/coal/gas/geothermal/wind](https://cfsotago.github.io/gridCarbon)) and reticulated (mains) / bottled gas [heating](https://www.branz.co.nz/cms_display.php?st=1&pg=20015&sn=378&forced_id=yes). The prevalance of solid fuels, especially in regions which suffer winter temperature inversions is a particular [problem](https://www.niwa.co.nz/news/students-scientists-citizens-study-arrowtowns-ailing-air).

As a result, switching to low emissions forms of heating (electric) and/or increasing insluation (or building to [Passive](https://passivehouse.nz/) house standards) will both reduce GHG emissions and improve air quality. As a consequence [health impacts](https://www.bmj.com/content/334/7591/460.short) and [costs](https://jech.bmj.com/content/63/4/271.short) are reduced - an excellent example of the co-benefits of de-carbonising heat. Rather than [non-energy energy policy](http://www.ukerc.ac.uk/publications/impact-of-non-energy-policies-on-energy-systems.html), we therefore have non-health health policy...

Of course, as elsewhere, fossil-fuel based transport is also a major contributor to poor air quality.

 * Data sources: [https://data.mfe.govt.nz/data/category/air/](https://data.mfe.govt.nz/data/category/air/)
 * Data files: mfe-pm10-concentrations-200617-CSV and pm10-concentrations-200617.csv
 * [Initial exploratory analysis](nzAirQualExplore.html) (does not yet use the excellent [openair](http://davidcarslaw.github.io/openair/) R package)
 * [Focus on Dunedin](???)

  
### Comparative

Southampton and Dunedin have much in common:

 * deep water port relatively close to the CBD
 * major transport routes bisecting the city
 * major flows of commuters, passengers & freight to/from and through the city
 * maritime temperate climate
 * substantial student population
 
How does their air quality compare?

 #YMMV
