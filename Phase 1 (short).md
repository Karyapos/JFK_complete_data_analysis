# JFK Data Analysis - Phase 1 (short)

## Analysis Overview

This document briefly introduces the initial phase of work on the [JFK Airport dataset](https://www.kaggle.com/datasets/deepankurk/flight-take-off-data-jfk-airport/data). The main question guiding this work is: 

**What factors most strongly affect taxi‑out times, and how?**

It contains the basic transformations, exploratory findings, and the issues raised and clarified during the first follow‑up meeting with the customer.  All analyses and transformations in this stage were performed in **SQL**.

## Data Transformation

The original dataset contained **23 columns**, many of which were not ideal for direct analysis. After transformation, the working structure became:

1. **id** – added as a unique identifier for programming safety
2. **date** – (MONTH, DAY_OF_MONTH, DAY_OF_WEEK)
3. **air_carrier** – (OP_UNIQUE_CARRIER)
4. **flight_code** – (TAIL_NUM)
5. **destination** – (DEST)
6. **distance** – (DISTANCE)
7. **dep_traffic** – (sch_arr)
8. **arr_traffic** – (sch_dep)
9. **taxi_out** – (TAXI_OUT)

The database also included pre‑taxi‑out details such as scheduled vs. actual departure and arrival times. These were confirmed not to be relevant for analysis at this stage.

A separate section was created for **weather‑related variables**, even though initial graphs suggested limited impact on taxi‑out times:

1. **id**
2. **temperature** (Temperature)
3. **dew_point** (Dew Point)
4. **humidity** (Humidity)
5. **wind** (Wind)
6. **wind_speed** (Wind Speed)
7. **wind_gust** (Wind Gust)
8. **pressure** (Pressure)
9. **condition** (Condition)
10. **taxi_out** (TAXI_OUT)

## Findings

This section highlights only a selection of the findings. The full exploratory work including every graph, summary table, and distribution check is documented separately, and can be viewed in the file [**findings**](images)

### Weather Variables

Most weather measures appeared to be irrelevant. For example, average temperature was about 3 degrees lower in flights with better taxi‑out performance (<10 minutes) compared to worse ones (>35 minutes). 
The only partial exception was **wind**: higher wind speed and gusts were associated with slightly worse **taxi‑out** times:

![weather_related](images/weather_related.png)



### Day of Week

Day of the week showed a stronger effect. However, the pattern requires further analysis:

- **Friday**:  ~19% of flights had taxi‑out >38 minutes, while ~12.5% were <18 minutes.
- **Tuesday**:  ~9% of flights >38 minutes, versus ~15.5% <18 minutes.

### Distance

Flight distance also mattered :

| **Distance** | **AVG.Taxi‑Out(min)** |
| --- | --- |
| 1162.17 | 12.6 |
| 1222.44 | 14.99 |
| 1267.75 | 20.86 |
| 1365.05 | 39.44 |
| 1406.99 | 39.95 |

### Carrier

Carrier differences were dramatic:

- AS: ~15% of flights >33 minutes taxi‑out, only ~3% <15 minutes.
- B6: ~4% >33 minutes, but ~22% <15 minutes.

## Follow‑Up Questions and Clarifications

1. Column descriptions:
    - ***sch_dep*** was incorrectly described as “number of flights scheduled for arrival.”
    - Analysis confirmed it should be “scheduled for departure,” while ***sch_arr*** refers to arrivals.
    - This was verified as a documentation typo.
2. Dew Point errors:
    - The ***dew_point*** column contained corrupted values (e.g., “9Ä” on dates such as Nov 12, Nov 13, Nov 16, Nov 21, Jan 4).
    - Corrected data was later provided manually. I had suggested algorithmic imputation, but manual correction was chosen.

## Conclusion

Based on prior research, it was expected that **weather** and **airport traffic** would be the strongest predictors of taxi-out performance. However in this stage, further assumptions about the weight of each variable are **not safe to make**.
This phase clarified the dataset’s structure, corrected documentation errors, resolved data-quality issues, and narrowed down which variables deserve deeper modeling attention. With the cleaned data and all clarifications in place, the project now moves into the **second phase**, where proper statistical modeling and scenario testing will begin.
