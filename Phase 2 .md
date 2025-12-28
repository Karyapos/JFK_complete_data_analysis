# JFK Data Analysis - Phase 2 

## Analysis Overview

This document briefly introduces the initial phase of work on the [JFK Airport dataset](https://www.kaggle.com/datasets/deepankurk/flight-take-off-data-jfk-airport/data). The main question guiding this work is: 

**What factors most strongly affect taxi‑out times, and how?**

This section covers correlation checks, ANOVA comparisons, and ranking the most influential variables. It’s the part that directly answers the main project question. The work here used both SQL and R, with most of the analysis carried out in the R environment.

## Methodology Overview

A range of methods were used, including **Pearson**, **Spearman**, **Kendall**, and both **ANOVA Type I** and **ANOVA Type II**. To keep the results clean and avoid unnecessary noise, the main conclusions are based on **Pearson** correlations and **ANOVA Type I**,  since **Kendall** and **Spearman** did not show any meaningful differences. After creating the summary table, **ANOVA Type II** was used to re‑evaluate the findings and confirm which effects remained when adjusting for other variables.

## Elimination: Weather **Condition** Variable

The **condition** column from the weather dataset was left out of the analysis. Even though it looks like a normal categorical variable, the labels are inconsistent (for example, the label *fair* appears across **temperatures** from 19° to 61°). Because of this, it doesn’t act as a reliable weather indicator, and using it would add noise rather than useful information.

## Main Results

| Variable    | R²     |
| ----------- | ------ |
| flight_code | 11.14% |
| departures  | 3.62%  |
| carrier     | 3.46%  |
| destination | 2.98%  |
| wind        | 1.23%  |
| time        | 1.13%  |
| wind_gust   | 0.92%  |
| day         | 0.58%  |
| temperature | 0.46%  |
| arrivals    | 0.42%  |
| wind_speed  | 0.39%  |
| distance    | 0.36%  |
| pressure    | 0.35%  |
| hour        | 0.23%  |
| dep_delay   | 0.12%  |
| humidity    | 0.07%  |
| dew_point   | 0.01%  |

## Follow‑Up Insights

### Weather Variables

As expected from the first phase of the project, weather variables have only a minimal effect on **taxi‑out** performance. This is clear in the main results table, although I still ran a **Type II ANOVA** on the weather variables with the highest impact just to confirm. The actual values were almost identical, meaning the shared variance is essentially zero (for **wind**, **wind_gust**, and **temperature** the difference was < 0.1%).

### Top Impact Variables

| Variable     | η²(part) |
|--------------|----------|
| flight_code  | 8%       |
| departures   | 3%       |
| destination  | 2%       |
| carrier      | 0%       |

Running a Type II ANOVA on the top four impact variables helps check how much coverage they share with each other. Departures and destination behave as expected, keeping almost the same values as in the main results. However, **flight_code** and **carrier** react differently. **Flight_code** drops by about 4 units from its original 11%, which shows that part of its impact overlaps with the other variables. **Carrier** goes all the way to the bottom, confirming that it contributes practically nothing to **taxi_out** performance. This is interesting because in [Phase 1](https://github.com/Karyapos/JFK_complete_data_analysis/tree/01-sql-eda) the results suggested that **carrier** might have some impact, but that turned out to be misleading.

### Flight_code variable

Running the analysis suggests that **flight_code** should not be treated as a standard variable for correlation or effect‑size interpretation. Although it shows some impact, we should not forget that it contains 2,092 different values across 28,818 records, which makes it behave more like an ID. Any relationship it shows is therefore hard to interpret and may reflect structure in the data rather than a real operational effect. Because of this, there is no clear analytical decision on whether **flight_code** should be considered or eliminated. The choice is ultimately up to stakeholders, depending on whether flight‑level detail is viewed as meaningful for their use case.

## Summary

This phase focused on understanding the actual impact of the most relevant variables and clarifying how much of their signal is unique versus shared. Through effect‑size analysis, partial coverage checks, and Type II ANOVA, we identified which predictors carry real operational meaning and which ones only appeared important in earlier stages. This resolved several misleading impressions from [Phase 1](https://github.com/Karyapos/JFK_complete_data_analysis/tree/01-sql-eda) and provided a clearer picture of the dataset. With these insights established, the next step is to develop visual explorations that highlight the behavior of the most interesting variables and how they interact.
