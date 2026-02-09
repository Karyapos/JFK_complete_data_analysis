# JFK Data Analysis - Full Project Overview

## Project Summary

This repository documents a complete, end‑to‑end analytical workflow on the JFK Airport taxi‑out dataset.
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

* **Departures** , **arrivals** , and **distance** emerged as potentially meaningful predictors

* Ambiguities in **carrier**, **destination**, and **flight_code** suggest these fields require clarification before modeling

## Phase 2 — R Correlation Analysis

### Core Activities

* Computed correlation matrices using **Pearson**, **Spearman**, and **Kendall** methods

* Performed **ANOVA** tests to evaluate taxi‑out differences across categorical groups

* Examined the special behavior of variables such as **flight_code**, **destination/distance**, and **carrier**

* Measured cross‑variable associations using **Cramér’s V** and **ANOVA** based effect sizes

### Highlights
* Traffic variables (**departures**, **arrivals**) showed the clearest monotonic patterns

* The **Condition** variable was eliminated due to inconsistent labeling and unreliable categories

* Weather effects overall were small but stable

* No single variable explained **taxi_out** time on its own. The strongest predictor, **departures**, accounted for only **3.62% R²**, confirming a low‑signal dataset

Based on these findings, stakeholders decided to proceed with a focused analysis centered on **wind** and **departures**, as these variables showed the most consistent relationships.

