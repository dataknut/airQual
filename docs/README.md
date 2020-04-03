## airQual: exploration of air quality data

__Best viewed at https://cfsotago.github.io/airQual/__

Poor air quality is well known to have both chronic (long term) and acute (short term) impacts on [health](http://www.erg.kcl.ac.uk/Research/home/projects/personalised-health-impacts.html).

### Southampton (UK) lockdown analysis

We update these on a regular basis. These link to the most recent plots for:

 * NO2 [plot](https://cfsotago.github.io/airQual/sccAirQualExplore_lockdown_Exploring%20the%20effect%20of%20UK%20covid%2019%20lockdown%20on%20air%20quality.html#fig:no2recent): weekends notably lower <- less travel? Weekdays possibly lower but clearly still ’essential worker’ travel especially mid-week? Notice it started 1 week before true lockdown
 * NOx [plot](https://cfsotago.github.io/airQual/sccAirQualExplore_lockdown_Exploring%20the%20effect%20of%20UK%20covid%2019%20lockdown%20on%20air%20quality.html#fig:noxrecent): as per NO2?
 * SO2 [plot](https://cfsotago.github.io/airQual/sccAirQualExplore_lockdown_Exploring%20the%20effect%20of%20UK%20covid%2019%20lockdown%20on%20air%20quality.html#fig:so2recent): Possibly similar to NO2 but...
 * Ozone [plot](sccAirQualExplore_lockdown_Exploring%20the%20effect%20of%20UK%20covid%2019%20lockdown%20on%20air%20quality.html#fig:03recent): much more affected by weather (sunny first lockdown weekend)?
 * PM10 [plot](sccAirQualExplore_lockdown_Exploring%20the%20effect%20of%20UK%20covid%2019%20lockdown%20on%20air%20quality.html#fig:pm10recent): as for NO2 but less noticeable the week before lockdown. But also possibly weather effect?
 * PM2.5 [plot](sccAirQualExplore_lockdown_Exploring%20the%20effect%20of%20UK%20covid%2019%20lockdown%20on%20air%20quality.html#fig:pm25recent): much more obvious lockdown but not pre-lockdown effect. But also possibly weather effect and even maybe a sensor/measurement effect? The AURN data here has not yet been [ratified](https://uk-air.defra.gov.uk/assets/documents/Data_Validation_and_Ratification_Process_Apr_2017.pdf).

NB: The AURN data used above is not yet  [ratified](https://uk-air.defra.gov.uk/assets/documents/Data_Validation_and_Ratification_Process_Apr_2017.pdf) as it less than 6 months old.

### New Zealand

See https://www.mfe.govt.nz/air

New Zealand homes use a mixture of solid (coal/wood), electric (fueled by [hydro/coal/gas/geothermal/wind](https://cfsotago.github.io/gridCarbon)) and reticulated (mains) / bottled gas [heating](https://www.branz.co.nz/cms_display.php?st=1&pg=20015&sn=378&forced_id=yes). The prevalance of solid fuels, especially in regions which suffer winter temperature inversions is a particular [problem](https://www.niwa.co.nz/news/students-scientists-citizens-study-arrowtowns-ailing-air).

As a result, switching to low emissions forms of heating (electric) and/or increasing insluation (or building to [Passive](https://passivehouse.nz/) house standards) will both reduce GHG emissions and improve air quality. As a consequence [health impacts](https://www.bmj.com/content/334/7591/460.short) and [costs](https://jech.bmj.com/content/63/4/271.short) are reduced - an excellent example of the co-benefits of de-carbonising heat. Rather than [non-energy energy policy](http://www.ukerc.ac.uk/publications/impact-of-non-energy-policies-on-energy-systems.html), we therefore have non-health health policy...

Of course, as elsewhere, fossil-fuel based transport is also a major contributor to poor air quality.

 * Data sources: [https://data.mfe.govt.nz/data/category/air/](https://data.mfe.govt.nz/data/category/air/)
 * Data files: mfe-pm10-concentrations-200617-CSV and pm10-concentrations-200617.csv
 * [Initial exploratory analysis](nzAirQualExplore.html) (does not yet use the excellent [openair](http://davidcarslaw.github.io/openair/) R package)
 * [Focus on Dunedin](???)

### Southampton (UK)

See https://www.southampton.gov.uk/environmental-issues/pollution/air-quality/

Southampton homes are much less likely to use solid fuel heating. Instead they tend to rely on reticulated (mains) gas, electricity and in [some areas](https://datashine.org.uk/#table=QS415EW&col=QS415EW0007&ramp=YlOrRd&layers=BTTT&zoom=12&lon=-1.4252&lat=50.9258), district heating. However gas boilers are known sources of Nitrogen Dioxide so heating systems may also be a contributor to poort air quality in Southampton alongside fossil-fuel based transport.

 * Data sources: [http://southampton.my-air.uk/](http://southampton.my-air.uk/) and also http://uk-air.defra.gov.uk/openair/R_data/ using `ōpenair::importAURN()`.
 * [Initial exploratory analysis](sccAirQualExplore_Exploring the data.html) - simple & interactive plots, can be slow to load; just uses southampton.my-air.uk
 * [Further exploratory analysis](sccAirQualExploreAURN.html) - uses the excellent [openair](http://davidcarslaw.github.io/openair/) R package
 * [Further exploratory analysis](sccAirQualExplore_Exploring the SSC and AURN data.html) - uses AURN data downloaded via the excellent [openair](http://davidcarslaw.github.io/openair/) R package and SSC data. They mostly agree...
  
### Comparative

Southampton and Dunedin have much in common:

 * deep water port relatively close to the CBD
 * major transport routes bisecting the city
 * major flows of commuters, passengers & freight to/from and through the city
 * maritime temperate climate
 * substantial student population
 
How does their air quality compare?

 #YMMV
