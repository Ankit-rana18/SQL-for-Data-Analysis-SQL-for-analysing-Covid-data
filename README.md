# 📊 COVID-19 Data Analysis with SQL

This project contains SQL queries used to analyze global COVID-19 time-series data. It covers data validation, descriptive statistics, distribution analysis, correlation, and a basic linear regression model using SQL.

---

## 📁 File

- `covid_query.sql`: Main SQL script used to clean and analyze the COVID-19 dataset stored in a table named `data_time_series`.

---

## 🔍 Key Analysis Sections

### 1. Data Cleaning
- Identify and correct `NULL` values in key columns like `Latitude`, `Longitude`, `Date`, `Confirmed`, `Deaths`, and `Recovered`.

### 2. Descriptive Statistics
- Count rows and active months per year.
- Identify the start and end dates of the dataset.
- Calculate monthly totals, minimum, and maximum values for confirmed, death, and recovery counts.

### 3. Central Tendency
- Compute **mean** values of confirmed, deaths, and recovered cases by month.

### 4. Dispersion
- Calculate **variance** and **standard deviation** for confirmed, deaths, and recovered cases.

### 5. Top N Queries
- Retrieve top 5 and top 10 records with the highest confirmed, death, and recovered cases.
- Country-specific analysis (e.g., India).

### 6. Correlation
- Compute Pearson correlation coefficients:
  - Confirmed vs Deaths
  - Confirmed vs Recovered
  - Deaths vs Recovered

### 7. Linear Regression
- Estimate a simple linear regression model of `Deaths` based on `Confirmed` cases:
  - Slope and intercept are calculated directly with SQL.

---

## 📌 Requirements

- SQL Server, MySQL, or any SQL engine supporting functions like `AVG`, `VARIANCE`, `STDDEV_POP`, etc.
- A table named `data_time_series` with columns: `Date`, `Latitude`, `Longitude`, `Country`, `Confirmed`, `Deaths`, `Recovered`.

---

## 🚀 Getting Started

1. Load your dataset into a table called `data_time_series`.
2. Run the SQL queries from `covid_query.sql` using your preferred SQL tool.
3. Analyze the output for insights and decision-making.

---

## 📈 Example Insights

- India reported the highest number of confirmed cases in April–May 2021.
- Strong positive correlation between confirmed and death/recovery counts.
- A regression model suggests approximately 1 death for every 100 confirmed cases.

---

## 📚 License

This project is for educational and research purposes only.
