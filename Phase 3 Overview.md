# JFK Data Analysis - Phase 3 

## Analysis Overview

This document provides an overview of the third phase of analysis using the [JFK Airport dataset](https://www.kaggle.com/datasets/deepankurk/flight-take-off-data-jfk-airport/data). The main question guiding this work is: 

**What factors most strongly affect taxi‑out times, and how?**

This section presents, through heatmaps, KPI cards, bar charts, slicers, and boxplots, how the most influential variables behave with respect to taxi‑out times. Following the [Phase 2](https://github.com/Karyapos/JFK_complete_data_analysis/tree/02-R-correlation) findings, stakeholders chose to focus on **wind** and **departure**, agreeing not to emphasize **flight_code**, **carrier**, or **destination** due to their operational specificity.

The [dashboard](JFK_Taxi‑Out_Data_Analysis.pbix) is structured as follows:

[**Main**](Visuals/Main.png)

[**Departures**](Visuals/Departures.png)

[**Wind**](Visuals/Wind.png)

The work here was carried out primarily in Power BI, with only minimal support from R for a few supplementary visuals.

## Key findings

### Worst Days Overview


| Day | Month | AVG taxi_out | Std Dev taxi_out | AVG departures | Dominant wind | Frequency wind |
|-----|-------|--------------|------------------|----------------|----------------|-----------------|
| 30  | 12    | 27.74        | 6.96             | 30.90          | ENE            | 121             |
| 1   | 12    | 26.43        | 8.13             | 33.15          | ENE            | 140             |
| 3   | 12    | 26.00        | 8.35             | 30.10          | NW             | 178             |
| 16  | 1     | 25.07        | 8.43             | 31.33          | NW             | 143             |
| 19  | 12    | 25.03        | 7.62             | 32.20          | WNW            | 119             |
| 25  | 1     | 24.39        | 7.82             | 29.97          | ENE            | 85              |
| 2   | 12    | 24.29        | 8.30             | 34.78          | N              | 112             |
| 9   | 12    | 24.06        | 8.25             | 30.60          | S              | 144             |
| 5   | 12    | 23.93        | 7.79             | 31.10          | WNW            | 163             |
| 5   | 1     | 23.76        | 7.02             | 32.34          | NW             | 178             |


### General points

* When **departures > 47** , the average **taxi_out** increases to **23.41** (**≈ 1,500 flights**).

* When **departures** < 18, the average **taxi_out** drops to **18.23** (**≈ 2,000 flights**).

* Out of **28,818** reported flights, roughly **17,000** are westbound and **5,500** eastbound.

* When the **wind** blows **ENE**, the average **taxi_out** rises to **23.17** (**≈ 1,000 flights**).

* When the **wind** blows from any eastern sector (NE, SE, ENE, ESE, etc.), the average **taxi_out** increases to **21.66** (**≈ 5,600 flights**).

## Summary

The dashboard is built for clarity and operational use. The goal is to show the real issues behind taxi_out performance, not to create a decorative or visually complex product. Colors, effects, and styling are kept minimal so the attention stays on the data and the questions it answers.

