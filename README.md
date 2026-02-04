# 📦 Olist E-commerce Delivery & Customer Analysis (SQL)

## 📌 Project Overview
This project analyses the **Olist e-commerce dataset** to understand how **delivery performance impacts customer behaviour, retention, and revenue**.  
The analysis focuses on **logistics reliability, delivery delays, and customer value**, using **SQL (MySQL)**.

The project simulates a real-world **Business / Operations Analyst workflow**: cleaning raw data, defining metrics, answering business questions, and translating results into actionable insights.

---

## 🎯 Business Questions
The analysis was structured around the following key questions:

- How long does delivery take on average, and how consistent is it?
- How often are orders delivered late?
- Does delivery speed relate to order revenue?
- Are customers returning after their first purchase?
- Do repeat customers generate more value?
- Does delivery experience differ between one-time and repeat customers?
- Does delivery performance vary by region?

---

## 🧹 Data Cleaning & Preparation
Rather than deleting records, I filtered the data to ensure meaningful and realistic analysis:

- Included only **delivered orders**
- Excluded orders with missing or invalid delivery dates
- Ensured delivery dates occurred **after** purchase dates

This approach preserves the raw dataset while focusing analysis on valid business scenarios, reflecting real-world analytics practices.

---

## 📊 Key Metrics Created
Using SQL views, I created reusable metrics that formed the foundation of the analysis:

- **Delivery time (days)** per order
- **Delivery status** (late vs on-time, based on estimated delivery date)
- **Order revenue** (item price + freight value)
- **Average order value (AOV)**
- **Customer order count**
- **Customer type** (one-time vs repeat customers)

Each metric was designed to directly support a business question.

---

## 🔍 Analysis & Key Insights

### 🚚 Delivery Performance
- Delivery times vary significantly across orders
- Late deliveries are present, indicating reliability issues

**Business Insight:**  
Delivery **consistency**, rather than raw speed, is a key driver of customer trust.

---

### 💰 Delivery Speed vs Revenue
- Some slower deliveries show higher average order value
- This is driven by a small number of high-value orders

**Interpretation:**  
Slower delivery does **not** increase revenue.  
High-value orders tend to be larger or more complex, which naturally increases delivery time.

**Business Insight:**  
High-value orders may require prioritised logistics to protect valuable customers from poor experiences.

---

### 👥 Customer Retention
- The vast majority of customers are **one-time buyers**
- Very few customers place repeat orders
- Repeat customers generate **similar revenue** to one-time customers

**Business Insight:**  
Customer retention exists but is weak. The business relies heavily on acquiring new customers.

---

### 🔁 Delivery Experience & Retention
- One-time and repeat customers experience **similar delivery times**

**Business Insight:**  
Delivery performance is not improving for returning customers, which may explain low customer loyalty and flat customer value.

---

### 🌍 Delivery Performance by Region
- Average delivery time varies noticeably by customer state
- Some regions consistently experience slower delivery

**Business Insight:**  
Certain regions may require logistics optimisation or closer monitoring of delivery partners to improve customer experience.

---

## 🧠 Overall Business Conclusion
The analysis shows that the business is highly dependent on **new customer acquisition**, while **customer retention remains low**.  
Although delivery performance is generally consistent, **reliability issues and regional delays** may be limiting long-term customer trust and value.

Improving delivery reliability represents a clear opportunity to enhance customer experience, increase repeat purchases, and protect revenue growth.

---

## 🚀 Recommendations
- Improve delivery reliability and reduce late deliveries
- Set more accurate delivery expectations for customers
- Prioritise logistics improvements in slower-performing regions
- Use delivery performance as a lever to improve customer retention

---

## 🛠 Tools & Skills Used
- **SQL (MySQL):** joins, aggregations, views, business logic
- Data cleaning and validation
- Operations and customer behaviour analysis
- Translating data findings into business insights

---

## 📂 Repository Contents
- `olist_analysis.sql` — Full SQL script containing all queries and views used in the analysis

---

## 🧠 What I Learned
This project strengthened my ability to:

- Structure analysis around clear business questions
- Validate unexpected results instead of forcing conclusions
- Connect operations data to customer behaviour and revenue
- Communicate insights in a clear, business-focused way

---

## 🔜 Next Steps
- Visualise key metrics using **Power BI**
- Extend analysis to product and seller performance
- Apply learnings to real-world Business and Operations Analyst roles

---

### ✅ Final Note
This project reflects my approach to analytics: **start with clean data, ask the right business questions, and focus on impact rather than just writing queries**.
