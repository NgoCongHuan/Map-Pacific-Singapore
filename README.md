# Data Analysis Test for Data Analyst Position

## Project Overview

This project is part of a test for the Data Analyst position. The goal is to preprocess raw data, load it into SQL Server, perform SQL queries as required by the employer, and visualize the data through dashboards.

## Directory Structure

```
.
├── assets/
│   ├── Invest.png
│   ├── Revenue.png
│   └── Summary.png
├── data/
│   ├── raw/
│   │   └── Data Scientist-Analyst position - Requirement.xlsx
│   └── clean/
│       ├── invest_cleaned.csv
│       └── revenue_cleaned.csv
├── reports/
│   └── MapPacificSingapore.pbix
├── scripts/
│   └── MapPacificSingapore.sql
├── src/
│   ├── preprocessing.ipynb
│   └── csv_to_ssms.ipynb
└── README.md
```

## Process

### 1. Data Preprocessing

The raw data is provided in `data/raw/Data Scientist-Analyst position - Requirement.xlsx`. The preprocessing steps are performed in the Jupyter notebook `src/preprocessing.ipynb`, which includes:

- Cleaning and transforming the data
- Splitting the data into two CSV files: `invest_cleaned.csv` and `revenue_cleaned.csv`

### 2. Loading Data into SQL Server

The cleaned CSV files are loaded into SQL Server using the Jupyter notebook `src/csv_to_ssms.ipynb`. This notebook contains the necessary Python code to connect to SQL Server and load the data from the CSV files.

### 3. SQL Queries

The SQL queries required by the employer are performed and saved in `scripts/MapPacificSingapore.sql`. This script includes various queries to analyze the investment and revenue data.

### 4. Data Visualization

The final step involves creating dashboards to visualize the data. The Power BI report `reports/MapPacificSingapore.pbix` includes:

- Investment Dashboard: `assets/MapPacificSingapore-Invest.png`
- Revenue Dashboard: `assets/MapPacificSingapore-Revenue.png`
- Summary Dashboard: `assets/MapPacificSingapore-Summary.png`

## How to Run the Project

1. **Preprocess Data:**
   - Open `src/preprocessing.ipynb` in Jupyter Notebook.
   - Execute all cells to preprocess the raw data and generate the cleaned CSV files.

2. **Load Data into SQL Server:**
   - Ensure SQL Server is running and accessible.
   - Open `src/csv_to_ssms.ipynb` in Jupyter Notebook.
   - Execute all cells to load the cleaned data into SQL Server.

3. **Execute SQL Queries:**
   - Open SQL Server Management Studio (SSMS).
   - Run the script `scripts/MapPacificSingapore.sql` to execute the required queries.

4. **Generate Visualizations:**
   - Open `reports/MapPacificSingapore.pbix` in Power BI Desktop.
   - Refresh the data to load the latest from SQL Server.
   - Review the dashboards in the `assets` folder for visual summaries.

## Dependencies

- Python 3.x
- Jupyter Notebook
- Pandas
- SQLAlchemy
- pyodbc
- SQL Server
- Power BI Desktop

## Contact

For any questions or further information, please contact Ngô Công Huân at [ngohuan18112002@gmail.com] or [0707996998].

---

I look forward to discussing this project and my approach with you. Thank you for your consideration.

Ngô Công Huân
