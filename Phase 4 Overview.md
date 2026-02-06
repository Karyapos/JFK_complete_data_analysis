# JFK Data Analysis - Phase 4

## Analysis Overview

This document provides an overview of the fourth phase of analysis using the [JFK Airport dataset](https://www.kaggle.com/datasets/deepankurk/flight-take-off-data-jfk-airport/data). The main question guiding this work is: 

**What factors most strongly affect taxi‑out times, and how?**

This phase delivers predictive modeling using LASSO, GAM, and Random Forests, with cross‑validation and feature evaluation, all executed in R environment.

## Methodology Overview

 For efficiency and reproducibility two functions were created: 
 * **evaluation** which given the model and the test_data it returns basic metrics
 * **lasso** which given x and y returns  LASSO coefficient table and basic metrics.
 
 The main body of this Phase has three parts:
* First, the **LASSO** coefficient table: by limiting each run to one or two categorical factors, the goal is to avoid overloading the model and instead identify where meaningful weight appears among the variables.
* Second, **GAM** models are used to capture the nonlinear structure of the problem, and several combinations are tested.
* Lastly, **Random Forests** are applied to obtain the strongest predictive model after tuning _nodes_ and _mtry_.

All models use the same 80/20 split and are evaluated with RMSE, MAE, and R².

## Variable Selection
 The variables **id**, **flight_code**, and **destination** were removed because they effectively behave as identifiers.
While **flight_code** has **2.092** distinct values, and **destination** has **65**, the real dilemma was whether to include **destination**, but after private tests and stakeholder confirmation, it was excluded due to the high risk of overfitting and adding noise rather than meaningful signal.

The **timestamp** feature was transformed into **hour** and **weekday**, which were kept in the analysis. The original **timestamp** column was removed because its raw form is not directly useful.





