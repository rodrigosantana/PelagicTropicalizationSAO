# PelagicTropicalizationSAO
This repository was created to store and share the R codes used in the analysis implemented in the Nature Climate Change manuscript.

## Datasets

### DATA DESCRIPTION:

**Dataset**
An updated version of the database can be accessed at https://www.iccat.int/en/accesingdb.html.

**Abstract:** Pelagic fishing catch data were obtained from the International Commission for the Conservation of the Atlantic Tuna (ICCAT database CATDIS and T2CE available at https://iccat.int/en/). This database dates back to the 1950’s, although, for the purpose of the present analysis only information between 1978 and 2018 were considered. The SAO was enclosed between parallels 0º and 60ºS, and divided in using the 20º W meridian into South West Atlantic Ocean (SWAO) and the South East Atlantic Ocean (SEAO).The 'Mean Temperature of the Catch (MTC)' was estimated for each year of the time series, as proposed by Cheung et al. (2013). This variable is expressed in degrees Celsius. 'Sea Surface Temperature (SST)' was derived from estimates provided by the high-resolution ocean general circulation INALT20 model (Schwarzkopf et al., 2019) for the study period (1978-2018) and was calculated by averaging the temperatures over 0.25° x 0.25° grid cells of the SAO and the upper 100m water column. This variable is expressed is degrees Celsius. 'Annual volume transports of the Brazil-Malvinas confluence (BCt)' was extracted and compiled from Artana et al. (2019). This index was estimated for the period between 2000 and 2017. More detailed information about this index can be accessed in Artana et al. (2019). This variable expressed in Sverdrups (Sv). The temperature preference/affinities data was obtained from global compilations made available by Cheung et al. (2013) and in FishBase (Froese and Pauly, 2022). In both compilations, thermal preferences derive from considerations about the species distribution ranges and sea surface temperature maps (e.g. Cheung et al., 2013 supplementary material). Each species considered here was assigned global species identifications or references like FAO ISSCAAP, FAO TAXOCODE, FAO CODE ASFIS 3A, AphiaID, and ITIS/TSN.

**Keyword(s):**	Catch composition; climate change; SAO Atlantic

**Further details:**	
    - Artana, Camila; Provost, Christine; Lellouche, Jean-Michel; Rio, Marie-Hélène; Ferrari, Ramiro; Sennéchael, Nathalie (2019): The Malvinas Current at the Confluence With the Brazil Current: Inferences From 25 Years of Mercator Ocean Reanalysis. Journal of Geophysical Research: Oceans, 124(10), 7178-7200, https://doi.org/10.1029/2019JC015289
	- Cheung, William W L; Watson, Reg; Pauly, Daniel (2013): Signature of ocean warming in global fisheries catch. Nature, 497(7449), 365-368, https://doi.org/10.1038/nature12156
	- Froese, R; Pauly, Daniel (2019): FishBase, version (02/2019). World Wide Web electronic publication, https://www.fishbase.org
	- Schwarzkopf, Franziska; Biastoch, Arne; Böning, Claus W; Chanut, Jérôme; Durgadoo, Jonathan V; Getzlaff, Klaus; Harlaß, Jan; Riek, Jan K; Roth, Christina; Scheinert, Markus; Schubert, R (2019): The INALT family – a set of high-resolution nests for the Agulhas Current system within global NEMO ocean/sea-ice configurations. Geoscientific Model Development, 12(7), 3329-3355, https://doi.org/10.5194/gmd-12-3329-2019.

**Project(s):**	Integrated Assessment of Atlantic Marine Ecosystems in Space and Time (iAtlantic) (URI: http://www.iatlantic.eu/)

**Funding:**	Horizon 2020 (H2020) (URI: https://ec.europa.eu/programmes/horizon2020/), grant/award no. 818123: Integrated Assessment of Atlantic Marine Ecosystems in Space and Time (URI: https://cordis.europa.eu/projects/818123)

**Size:**	3 datasets

**TABULAR SUMMARY OF DATASETS LISTED IN THIS COLLECTION:**

Filenames: 
*Pelagic_Fisheries_Catch_Time_Series_SAO.csv*

*Environmental_Oceanographic_Fisheries_Time_Series_SAO.csv*

*Thermal_Species_Affinities_SAO.csv*

## R Code

*script_MTC_analysis_ver00.R* - for the implementation of the linear models and time-lag linear models;

*script_Multivariate_analysis_ver00.R* - for the implementation of the multivariated analysis (TBI, Beta Diversity).

Important: Some analysis are based on permutation process, thus, some results could present small differences between new runs and those presented in the manuscript. 

## Licence

<a rel="license"
href="https://creativecommons.org/licenses/by-nc-sa/4.0/"><img
alt="Licença Creative Commons" style="border-width:0"
src="http://i.creativecommons.org/l/by-nc-sa/4.0/88x31.png" /></a><br
/>This work is licensed under a <a rel="license"
href="https://creativecommons.org/licenses/by-sa/4.0/deed">Creative
Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)</a>.
