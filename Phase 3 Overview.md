# JFK Data Analysis - Phase 3 

## Analysis Overview

This document provides an overview of the third phase of analysis using the [JFK Airport dataset](https://www.kaggle.com/datasets/deepankurk/flight-take-off-data-jfk-airport/data). The main question guiding this work is: 

**What factors most strongly affect taxi‑out times, and how?**

This section presents, through heatmaps, KPI cards, bar charts, slicers, and boxplots, how the most influential variables behave with respect to taxi‑out times. Following the [Phase 2](https://github.com/Karyapos/JFK_complete_data_analysis/tree/02-R-correlation) findings, stakeholders chose to focus on **wind** and **departure**, agreeing not to emphasize **flight_code**, **carrier**, or **destination** due to their operational specificity.

The work here was carried out primarily in Power BI, with only minimal support from R for a few supplementary visuals and **SQL** for basic aggregations that supported the selection phase.

## Wind Selection 

The **wind** selection follows a simple, operationally meaningful rule:
* include any wind direction whose average **taxi_out** deviates by at least **0.5** minutes from the global mean (**20.86**),
* provided it has more than **500** observations.

This ensures that only **wind** groups with both practical impact and statistical weight are considered.

However, the boxplot analysis adds an important nuance. The northern winds (N, NE, NNE) show a right‑skewed distribution with a low median and, in the case of N, several extreme upper outliers. For that reason, **N** is retained in the analysis. Based on these criteria, the **wind** directions selected for deeper investigation are: 
**ENE**, **N**, **NE**, **NNE**, **NNW**, **SW**, **WNW**, **WSW** .

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

## Dashboard Overview

The [dashboard](JFK_Taxi‑Out_Data_Analysis.pbix) is structured as follows:

[**Main**](Visuals/Main.png)

[**Departures**](Visuals/Departures.png)

[**Wind**](Visuals/Wind.png)


## Summary

This stage focused on translating the statistical findings from the previous [Phase 2](https://github.com/Karyapos/JFK_complete_data_analysis/tree/02-R-correlation) into something readable in seconds. Heatmaps, KPI cards, bar charts, slicers, and boxplots were arranged to show when **taxi_out** performance breaks down, how often these conditions occur, and which **wind** and **departure** patterns consistently drive the variation.The goal was to build a clean, operational dashboard that exposes how the key variables behave without adding visual noise. The structure is intentionally minimal: only the visuals that clarify **departures**, **wind**, and their impact on **taxi_out** are included, avoiding shadows, complex colors, or any other unnecessary styling that would blur the underlying assumptions. 

All core code used in this phase is available in the [Scripts](Scripts) folder, and selected supporting visuals are included in the [Visuals](Visuals) directory. With these foundations established, the next step involves developing visual explorations that illustrate the behavior of the key variables and their interactions.
