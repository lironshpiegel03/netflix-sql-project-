# 🎬 Netflix Titles Analysis Using SQL

**Author**: Liron Shpiegel  
**Project**: FIT – Database & SQL Final Project  
**Technologies**: SQL Server, CSV, Data Modeling  
**Dataset**: [Netflix Titles Dataset](https://www.kaggle.com/datasets/shivamb/netflix-shows)

---

## 📌 Overview

This project analyzes Netflix content for **Israel**, **United States**, and **India** using SQL.  
The goal is to normalize the dataset, filter for relevant genres, and create a structured database consisting of **eight relational tables**.

The project focuses on two genres: **Drama** and **Horror**, and separates information for movies, TV shows, and general listings.

---

## 🧱 Database Structure

The dataset was cleaned, filtered, and split into **8 normalized tables**:

| Table Name     | Description                                    |
|----------------|------------------------------------------------|
| `type_info`    | Maps content type (Movie / TV Show)            |
| `country_info` | Country names and IDs                          |
| `general_info` | Basic info on all titles (ID, title, type)     |
| `listed_in_info` | Maps genres like Drama or Horror             |
| `about_t_show` | Title + director + cast + genre (brief)        |
| `movie`        | Full details of movies only                    |
| `tv_show`      | Full details of TV shows only                 |
| `all_info`     | Complete combined table of all selected titles |

---

## 🌍 Countries Covered

- 🇮🇱 Israel  
- 🇺🇸 United States  
- 🇮🇳 India  

---

## 🎯 Filtering Criteria

- **Genres**: Only shows and movies labeled with **Drama** or **Horror**.  
- **Countries**: Only entries from India, Israel, and the US.  
- **Content Type**: Split between Movies and TV Shows.

---

## 🛠️ Technologies Used

- Microsoft SQL Server  
- SQL (DDL + DML)  
- CSV data import  
- Relational database modeling  

---

## 📁 Files Included

- `netflix_titles.csv` – Original dataset (Kaggle)
- `final_file_project_one_netflex.sql` – Full SQL script with:
  - Table creation (CREATE TABLE)
  - Data insertion (INSERT INTO ... SELECT ...)
  - Foreign key constraints

---

## ▶️ How to Use

1. Import `netflix_titles.csv` into your SQL database (as staging table).
2. Run the SQL script `final_file_project_one_netflex.sql`.
3. Query the normalized tables as needed for analysis.
4. Extend by joining, aggregating, or filtering per genre/country/year.

---

## 📊 Sample Queries

```sql
-- Get number of horror movies in each country
SELECT country, COUNT(*) as horror_count
FROM movie
WHERE listed_id IN (
  SELECT listed_id FROM listed_in_info WHERE listed_in LIKE '%horror%'
)
GROUP BY country;
