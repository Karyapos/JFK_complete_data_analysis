# JFK Data Analysis - Full Project Overview

## Project Summary

This repository documents a complete, end‑to‑end analytical workflow applied to the JFK Airport taxi‑out dataset.
Across four phases, [SQL EDA](https://github.com/Karyapos/JFK_complete_data_analysis/tree/01-sql-eda), [R correlation analysis](https://github.com/Karyapos/JFK_complete_data_analysis/tree/02-R-correlation), [Power BI dashboard development](https://github.com/Karyapos/JFK_complete_data_analysis/tree/03-PowerBi-dashboard), and [R modeling](https://github.com/Karyapos/JFK_complete_data_analysis/tree/04-R-Modeling), the project investigates the central question:

**What factors most strongly affect taxi‑out times, and how?**

Each phase builds on the previous one, moving from raw data to interpretable insights and predictive models.

## Phase 1 — SQL Exploratory Data Analysis

### Core Activities

* Corrected mislabeled and missing fields

* Mutated and standardized data to support downstream analysis

* Checked for outliers and assessed data reliability

* Performed exploratory querying, quick plots, and aggregations to understand distributions

### Key Outputs

* Cleaned and separated airport and weather tables

* Corrected mislabeled fields (**sch_dep**, **sch_arr**) to reflect their true meaning

* Added engineered fields:
  * **id**
  * **timestamp**
  * **taxi_10tile** (decile-based categorical version of **taxi_out**)
  * **departures_5tile** (decile-based categorical version of **departures**)

### Main Findings

* Most weather variables showed weak relationships with **taxi_out** time, with **wind** being the only variable showing a noticeable effect

* **Departures** and **arrivals** emerged as potentially meaningful predictors

* Ambiguities in **carrier**, **destination**, and **flight_code** suggest these fields require clarification before modeling

## Phase 2 — R Correlation Analysis

### Core Activities

* Computed correlation matrices using **Pearson**, **Spearman**, and **Kendall** methods

* Performed **ANOVA** tests to evaluate taxi‑out differences across categorical groups

* Examined the special behavior of variables such as **flight_code**, **destination** , **distance** and **carrier**

* Measured cross‑variable associations using **Cramér’s V** and **ANOVA** based effect sizes

### Highlights
* Traffic variables (**departures**, **arrivals**) showed the clearest monotonic patterns

* The **Condition** variable was eliminated due to inconsistent labeling and unreliable categories

* Weather effects overall were small but stable

* No single variable explained **taxi_out** time on its own. The strongest predictor, **departures**, accounted for only **3.62% R²**, confirming a low‑signal dataset

Based on these findings, stakeholders decided to proceed with a focused analysis centered on **wind** and **departures**, as these variables showed the most consistent relationships.

## Phase 3 — Power BI Dashboard

The taxi‑out analysis dashboard was separated into **Main**, **Departures Traffic**, and **Wind** views, each focused on a specific operational dimension.

### Dashboard Components

* **Taxi_out** metrics overview

* Selection of ntiles or clusters

* Compact slicers for choosing specific days or periods

* Heatmaps

* Boxplots

* Bar charts and column charts

### Purpose

* Explore patterns

* Compare operational groups

* Identify crucial subgroups or specific circumstances that diverge from general behavior

* Validate assumptions visually

### Design Note
The dashboard intentionally remains clean and minimal, prioritizing clarity and instant readability. Complex effects, such as shadows, gradients, or decorative color fades for example, were avoided to maintain a professional, distraction‑free layout.

## Phase 4 — R Predictive Modeling
### Predictive Models
#### LASSO  
Used mainly to identify which variables carry meaningful signal.
Multiple runs were performed with different categorical groupings to avoid over‑parameterization.

#### GAM  
Used to capture non‑linear relationships across variables.
Provided interpretable smooth functions but limited predictive power.

#### Random Forest  
Delivered the strongest performance, especially after tuning.

### Top Model
A Random Forest using all usable variables achieved the best generalization performance.
Variable importance confirmed that **departure** traffic together with the **carrier** and **wind** variables are the most influential drivers of taxi‑out time.

### Important Notes
Each model was evaluated using exactly the same train/test splits and standard metrics (MAE, RMSE, R²) to ensure a consistent and logical comparison.

The tuning process concluded with:
maxnodes = 500, nodesize = 150, ntree = 500, mtry = 6.

The overall metrics for this specific “top model” were confirmed across 30 replicable splits.

You can access the [R_Markdown](Phase_4.Rmd) file for full reproducibility.

## Conclusion

This project demonstrates how a structured end-to-end analysis can extract evidence-based insights while minimizing personal bias. Even with a limited and noisy dataset and a low-signal problem space, the analysis consistently shows that **departure traffic** is the only factor with a small but stable and repeatable impact on **taxi_out** performance, from initial exploration through dashboarding to final predictive modeling.

Readers interested in the analytical reasoning are encouraged to follow the logic trail across each phase of the project, where assumptions, reproducibility assets, and supporting visuals are documented step by step.
