# 🧼📊 Cancer Patient Data Cleaning & Exploratory Analysis Project (UAE)

Hi there! This project is about working with a real-world healthcare dataset of cancer patients from the UAE. I cleaned the dataset using **MySQL** and later explored the cleaned data using **Python (Pandas, Seaborn, Matplotlib)**.

The goal was simple: clean up messy medical data and then dig into it to find insights — like which cancer types have shorter survival times, which hospitals have high death rates, and more.

---

## 📁 Dataset Overview

This dataset includes over **10,000 patients** and covers:

- Patient details (age, gender, nationality, etc.)
- Cancer type and stage
- Treatment info (start date, type)
- Hospital and physician
- Outcomes (recovered or deceased)
- Lifestyle factors (e.g., smoking)
- Dates (diagnosis, treatment, death)

---

## 🛠️ Tools Used

- **MySQL Workbench** for data cleaning
- **Jupyter Notebook** for EDA
- **Pandas / Seaborn / Matplotlib** for visualizations
- **CSV** file format for storing and transferring data

---

## 🔧 What I Did – Data Cleaning (MySQL)

1. **Created database and table structure**
   - Defined proper data types
   - Imported CSV using `LOAD DATA INFILE`

2. **Removed Duplicates**
   - Used `ROW_NUMBER()` to keep only the latest diagnosis per patient

3. **Handled Missing & Inconsistent Values**
   - Converted 'N/A', 'Unknown' to `NULL`
   - Checked and fixed invalid entries (e.g., strange height/age)

4. **Formatted Dates**
   - Cleaned and converted death dates to proper `DATE` format

5. **Standardized Categorical Data**
   - Unified spelling/capitalization (e.g., 'non-smoker' → 'Non-Smoker')

6. **Validation Checks**
   - Confirmed valid age, height, weight
   - Did a final spot-check on all records

---

## 📊 What I Did – Exploratory Data Analysis (Python)

After cleaning, I loaded the data into a Jupyter Notebook and explored it using plots and statistics. Here's what I looked at:

### ✅ Key Questions I Explored

1. **Do certain cancer types have shorter survival times?**  
   → Used bar charts and boxplots to compare average survival days.

2. **Do men and women survive differently?**  
   → Used KDE plots to compare survival distributions by gender.

3. **Is there any link between BMI, treatment delay, and survival time?**  
   → Created a correlation heatmap.

4. **Which hospitals had higher death rates?**  
   → Analyzed average death rates using bar plots.

5. **Are some cancer types becoming more common over time?**  
   → Used count plots grouped by diagnosis year.

---

## 📌 Extra Features I Added

- **New columns** like `BMI`, `Survival_Days`, `Treatment_Delay`, `Is_Deceased`
- **Date conversion** for proper time-based analysis
- **Visual insights** using Seaborn and Matplotlib

---

## 📂 Project Files

| File | Description |
|------|-------------|
| `Data Cleaning on Cancer Dataset UAE.sql` | SQL code used for cleaning |
| `cleaned_cancer_data.csv` | Final cleaned data |
| `EDA on Cancer Dataset UAE.ipynb` | Jupyter Notebook with EDA |
| `README.md` | This file 😄 |

---

## 💡 Final Thoughts

This project helped me practice and combine SQL and Python — starting from raw, messy data and ending with real, insightful visuals. It also taught me how important clean data is before doing any analysis.

Thanks for checking it out! 🙌
