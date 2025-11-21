# JFK Data Analysis - Phase 1 (full)
## **Project Context**

This README documents the **first phase** of analysis on the [JFK Airport dataset](https://www.kaggle.com/datasets/deepankurk/flight-take-off-data-jfk-airport/data).

This file contains data about flights leaving from JFK airport between Nov 2019-Dec-2020, along with weather conditions, operational metadata, and multiple scheduled/actual timestamps.

The purpose of this phase was to perform **basic cleaning**, **clarify confusing fields**, and run **initial exploratory analysis** to understand which factors appear to influence **taxi-out times**. At this stage, the work is not about modeling or prediction yet , it is strictly about understanding structure, identifying inconsistencies, and preparing clean, reliable inputs for the deeper analysis that will follow.

The guiding question for this part of the project remains:

> ***What factors most strongly affect taxi‑out times, and how?***
> 

Before even the meeting, a few issues (such as the dew point problem) were already detected and communication had started, but more on that in the “Follow-Up Questions and Clarifications” section.

It’s also worth noting that this entire phase was completed using **SQL** only. 

## **Data Transformation**

The original dataset contained a large number **23 columns** . Many of these fields were timestamps, raw operational fields, string-encoded numbers, or columns that were irrelevant for early analysis.

The transformation had two goals:

1. **Reduce the dataset to an analysis-ready structure**
2. **Retain all columns that might become useful in later modeling**, even if not used immediately

During the meeting, several columns were explicitly approved to be removed from this phase.

### **Excluded Columns**

1. crs_elapsed_time
2. crs_dep_m
3. dep_time_m
4. crs_arrival_m

### **Airport related Table**

This table contains the core operational fields that describe each individual flight together with the immediate airport context around it. It combines the flight-specific identifiers with day-level temporal information and the airport traffic variables

1. id
2. date (MONTH, DAY_OF_MONTH, DAY_OF_WEEK)
3. air_carrier (OP_UNIQUE_CARRIER)
4. flight_code (TAIL_NUM)
5. destination (DEST)
6. distance (DISTANCE)
7. dep_traffic (sch_arr)
8. arr_traffic (sch_dep)
9. taxi_out (TAXI_OUT)

### **Weather  related Table**

All weather-related data is placed in a separate structure. These variables were initially suspected to have meaningful impact on taxi-out performance (based on common findings in aviation research), but this has to be verified.

1. id
2. temperature (Temperature)
3. dew_point (Dew Point)
4. humidity (Humidity)
5. wind (Wind)
6. wind_speed (Wind Speed)
7. wind_gust (Wind Gust)
8. pressure (Pressure)
9. condition (Condition)
10. taxi_out (TAXI_OUT)

This stage ensures that both tables have consistent IDs, matching rows, correct numeric formats, and clean join relationships.

## **Findings**

Before getting into the details, this section highlights only a selection of the findings from each variable group. The full exploratory work including every graph, summary table, and distribution check is documented separately, and can be viewed in the file [**findings**](images)

### **Weather Variables**

Weather initially looked like it would be a major driver. Many sources claim that wind, rain, visibility, and pressure conditions at major airports are among the main contributors to delays.

However, the analysis in this early phase found that **weather had surprisingly limited impact** on taxi-out time.

Examples:

- Average temperature was ~ 2 degrees lower in flights with better taxi‑out performance (<15 minutes) compared to delayed ones (>35 minutes).
- Humidity, pressure,dew point and general condition categories were flat.
- Only **wind** had a mild effect:
    
    higher wind speeds and stronger gusts were associated with slightly higher taxi-out times, but the differences were still too small to consider them a core driver.
    

This will be revisited in later modeling, but for now, weather does not appear to be a dominant factor.

### **Day of Week**

Day of the week do show a more pronounced effect.

Example comparisons:

- **Day 4:**
    
    ~19% of flights had taxi-out >38 minutes
    
    ~12.5% had taxi-out <18 minutes
    
- **Day 2:**
    
    ~9% >38 minutes
    
    ~15.5% <18 minutes
    

These differences suggest traffic patterns and scheduling density influence congestion.

### **Air Carrier**

Carrier differences are the most dramatic and consistent:

- **AS:**
    
    ~15% of flights >33 minutes taxi-out
    
    ~3% <15 minutes
    
- **B6:**
    
    ~4% >33 minutes
    
    ~22% <15 minutes
    

This strongly suggests operational efficiency differences, scheduling patterns, gate assignments, or internal processes vary sharply between carriers.

It should be noted that the following **flight code, destination,** and **distance** categories are highly interconnected categories, so while I present the results separately for clarity, they naturally influence each other and often follow similar patterns in the analysis.

### Flight Code

As shown in the following graph, certain flight codes display extremely uneven taxi-out performance. In some cases the difference is dramatic up to **44% of flights taxiing out in under 15 minutes**, while only **2% exceed 35 minutes**.

 To keep the analysis meaningful, I restricted this comparison to flight codes with **more than 30 recorded listings**. 

![top10_flight_codes_un15](images/top10_flight_codes_un15.png)

### Destination

The **destination** variable shows several notable instabilities:

- **STT**
    - ~16% of flights have taxi-out **>35 minutes**
    - ~1.5% have taxi-out **<15 minutes**
- **ORF**
    - ~5% **>35 minutes**
    - ~9.5% **<15 minutes**
- **TPA**
    - ~3% **>35 minutes**
    - ~22% **<15 minutes**

These variations highlight that different destinations behave very differently in terms of taxi-out performance, suggesting that  runway related procedures may play a larger role than expected.

### **Distance**

Distance have a clear pattern:

| AVG Distance | AVG Taxi-Out (min) |
| --- | --- |
| 1162.17 | 12.6 |
| 1222.44 | 14.99 |
| 1267.75 | 20.86 |
| 1365.05 | 39.44 |
| 1406.99 | 39.95 |

The increase is not linear but shows that longer-distance flights often correspond to longer taxi-out times.This was likely due to runway assignment priorities, where long‑haul flights were given different sequencing that increased taxi duration.

### Airport Traffic

Airport traffic was initially expected to be one of the strongest drivers of taxi-out performance. There is indeed some connection especially with **scheduled departures**. 

| AVG Departures | AVG Arrivals | AVG Taxi-Out (min) |
| --- | --- | --- |
| 29.08 | 27.72 | 12.6 |
| 29.37 | 27.81 | 14.99 |
| 31.09 | 28.43 | 20.86 |
| 34.38 | 29.84 | 39.44 |
| 34.41 | 29.72 | 39.95 |

Departures had a stronger influence than arrivals, reinforcing that outbound congestion was the primary driver of extended taxi‑out times.

## **Follow-Up Questions and Clarification**

A few points needed clarification during (and before) the meeting.

### **Column descriptions**

An issue was found in the column documentation:

- `sch_dep` was originally described as “number of flights scheduled for arrival”
- `sch_arr` was described in a similar reversed way

This was confirmed to be a **documentation mistake**, not a dataset error.

The corrected meanings are:

- **sch_dep = flights scheduled for departure**
- **sch_arr = flights scheduled for arrival**

This has been fixed in the analysis.

### **Dew Point Data Issue (already identified before the meeting)**

Before the meeting, I had already contacted regarding the corrupted dew point field. The ***dew_point*** column contained corrupted values (e.g., “9Ä” on dates such as Nov 12, Nov 13, Nov 16, Nov 21, Jan 4 etc.).

I proposed that instead of manually correcting them, we could fill the dew point values based on logic:

> Given temperature and humidity, dew point can be deterministically recalculated, so missing/corrupted values can be imputed algorithmically.
> 

I prepared an **R** script ( I will paste just the important parts for clarity) that identifies corrupted rows and calculates the missing dew point values automatically.

`weather_clean <- weather %>%
mutate(
dew_point_numeric = suppressWarnings(as.numeric(dew_point)),
is_corrupted = [is.na](http://is.na/)(dew_point_numeric)
)`

`calculate_dewpoint <- function(temp, humidity) {
a <- 17.27
b <- 237.7
alpha <- (a * temp) / (b + temp) + log(humidity / 100)
(b * alpha) / (a - alpha)
}`

However, the decision was made to follow **manual correction** instead, and updated clean data was provided.

## **Conclusion**

Based on prior research, it was expected that **weather** and **airport traffic** would be the strongest predictors of taxi-out performance. However in this stage, further assumptions about the weight of each variable are **not safe to make**.
This phase clarified the dataset’s structure, corrected documentation errors, resolved data-quality issues, and narrowed down which variables deserve deeper modeling attention.With the cleaned data and all clarifications in place, the project now moves into the **second phase**, where proper statistical modeling and scenario testing will begin.
