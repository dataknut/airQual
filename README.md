## airQual: exploration of air quality data

__Best viewed at https://cfsotago.github.io/airQual/__

Poor air quality is well known to have both chronic (long term) and acute (short term) impacts on [health]().

### New Zealand

See https://www.mfe.govt.nz/air

New Zealand homes use a mixture of solid (coal/wood), electric (fueled by [hydro/coal/gas/geothermal/wind](https://cfsotago.github.io//gridCarbon)) and reticulated (mains) / bottled gas [heating](https://www.branz.co.nz/cms_display.php?st=1&pg=20015&sn=378&forced_id=yes). The prevalance of solid fuels, especially in regions which suffer winter temperature inversions is a particular problem.

As a result, switching to low emissions forms of heating (electric) and/or increasing insluation (or building to [Passive](https://passivehouse.nz/) house standards) will both reduce GHG emissions and improve air quality. As a cosequence health impacts and costs are reduced - an excellent example of the co-benefits of de-carbonising heat. Rather than [non-energy energy policy](http://www.ukerc.ac.uk/publications/impact-of-non-energy-policies-on-energy-systems.html), we therefore have non-health health policy...

Of course, as elsewhere, fossil-fuel based transport is also a major contributor to poor air quality.

 * Data sources: [https://data.mfe.govt.nz/data/category/air/](https://data.mfe.govt.nz/data/category/air/)
 * Data files: mfe-pm10-concentrations-200617-CSV and pm10-concentrations-200617.csv
 * [Initial exploratory analysis](analysis/nzAirQualExplore.html) (does not yet use the excellent [openair](http://davidcarslaw.github.io/openair/) R package)
 * [Focus on Dunedin]()

### Southampton (UK)

See https://www.southampton.gov.uk/environmental-issues/pollution/air-quality/

Southampton homes are much less likely to use solid fuel heating. Instead they tend to rely on reticulated (mains) gas, electricity and in [some areas](https://datashine.org.uk/#table=QS415EW&col=QS415EW0003&ramp=YlOrRd&layers=BTTT&zoom=12&lon=-1.4252&lat=50.9258), district heating. However gas boilers are known sources of Nitrogen Dioxide so heating systems may also be a contributor to poort air quality in Southampton alongside fossil-fuel based transport.

 * Data sources: [http://southampton.my-air.uk/](http://southampton.my-air.uk/)
 * [Initial exploratory analysis](analysis/sccAirQualExplore.html) - simple plots, fast to load (does not yet use the excellent [openair](http://davidcarslaw.github.io/openair/) R package)
 * [Initial exploratory analysis](analysis/sccAirQualExplore_plotly.html) - includes interactive plots covering the last 12 months, slow to load but more fun (does not yet use the excellent [openair](http://davidcarslaw.github.io/openair/) R package)
 
### Comparative

Southampton and Dunedin have much in common:

 * deep water port relatively close to the CBD
 * major transport routes bisecting the city
 * major flows of commuters, passengers & freight to/from and through the city
 * maritime temperate climate
 * substantial student population
 
How does their air quality compare?

 #YMMV
