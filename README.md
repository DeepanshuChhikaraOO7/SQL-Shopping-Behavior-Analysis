# Customer Segmentation & Purchase Behavior Optimization for Retail E-Commerce

## 1. High-Level Business Case

This project provides a deep-dive analysis into customer shopping behavior for a retail e-commerce platform. The primary objective is to move beyond surface-level metrics and uncover actionable insights that can drive revenue and improve customer retention. By segmenting customers and analyzing their purchasing patterns, this project aims to provide data-driven answers to critical business questions related to demographics, product performance, and the effectiveness of current marketing strategies.

---

## 2. Dataset

The analysis is performed on the **Shopping Behavior Dataset**, which provides a rich, granular view of customer transactions. The dataset was sourced from Kaggle and contains 3,900 records.

-   **Dataset Source:** [Shopping Behavior Dataset on Kaggle](https://www.kaggle.com/datasets/ahmadrazakashif/shopping-behavior-dataset)
-   **Key Data Points:** Customer demographics (age, gender, location), transaction details (item, category, purchase amount), and behavioral attributes (ratings, subscription status, purchase frequency).

---

## 3. Core Analysis Tasks & Business Questions

The analysis was structured to address the following key business questions, as defined by the project stakeholders:

| Focus Area                             | Key Business Question                                                                                                                                    |
| -------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **Customer Demographics Analysis**     | Which **Age, Gender, and Location groups** generate the highest **revenue and purchase frequency**?                                                      |
| **Discount & Promotion Effectiveness** | Do **discounts and promo codes** improve **lifetime value**, or do they **attract only opportunistic buyers**?                                           |
| **Subscription Strategy Evaluation**   | Are **Subscribed Customers** more **profitable** and **frequent buyers** compared to non-subscribers?                                                    |
| **Review Rating Impact**               | Does **higher product satisfaction (Review Rating)** lead to **higher frequency or higher-priced purchases?**                                            |
| **Shipping & Payment Behavior**        | Which **Shipping Type** and **Payment Method** correlate with **repeat orders and higher spend**?                                                          |

---

## 4. Tech Stack & Workflow

-   **Database:** PostgreSQL
-   **SQL Editor:** Dbeaver
-   **Language:** SQL
-   **Workflow:**
    1.  **Schema Definition (`schema.sql`):** Created the table structure to house the dataset.
    2.  **Data Cleaning (`data_cleaning.sql`):** Validated the dataset, confirming that all 3,900 rows were complete with **zero null values**, making it ready for reliable analysis.
    3.  **In-Depth Analysis (`analysis.sql`):** Executed a series of advanced SQL queries using `CTEs`, `CASE` statements, and window functions to answer the stakeholder questions.

---

## 5. Answering the Stakeholder Suggestion Panel

This section directly addresses the deeper-dive questions posed by internal stakeholders, using insights derived from the data.

#### **1. Can we predict which customers are likely to churn?**
**Yes.** By segmenting for customers with low purchase frequency ('Annually' or 'Quarterly'), low review ratings (2.5-3.0), and no subscription, we identified a key at-risk cohort. A significant **44% of these disengaged customers** come from the **Clothing** category, suggesting that retention strategies should focus on improving the quality, variety, and overall experience within this category.

#### **2. Should we restrict promo codes for customers who only buy with discounts?**
**No.** Restricting promo codes would be a mistake. The data shows that discounts are a critical driver of revenue across *all* customer segments, including our most valuable ones. The **Clothing** category sees the highest promo code usage (43%). Instead of restricting them, we should leverage promotions to boost sales in underperforming categories like **Footwear** and **Outerwear**.

#### **3. Does product preference vary by region or season?**
**Partially.** The dataset does not contain specific regional data (e.g., North/South) to answer this question fully. Furthermore, the data is heavily skewed towards Male customers (68%), which masks true seasonal preferences for females. The existing data only shows that males purchase more than females in every season.

#### **4. Do customers who purchase higher-priced items stick with a brand longer?**
**Cannot be determined.** The current dataset is a snapshot of individual transactions and does not contain a customer purchase history. To measure customer loyalty or lifetime value, a longitudinal dataset with repeat purchase information is required.

#### **5. Is free or fast shipping actually increasing revenue?**
**Yes, absolutely.** "Free Shipping," "Express," and "2-Day Shipping" are major revenue drivers. Free Shipping accounts for the highest number of total orders, while Express and 2-Day options correlate with a higher average spend per customer (over $60). These options are essential and contribute significantly to our total revenue.

#### **6. What triggers higher satisfaction — product quality (category-wise) or speed of delivery (shipping type)?**
**Neither.** The analysis reveals that customer satisfaction is remarkably consistent across the board. Average review ratings are tightly clustered for all product categories (between 3.72 and 3.79) and all shipping types (between 3.71 and 3.82). This indicates that our baseline quality and delivery speed meet customer expectations uniformly.

#### **7. Should we bundle products or launch “Buy Again” recommendations?**
**Yes, we should do both.** Given the high satisfaction and sales volume in the **Clothing** and **Accessories** categories, a dual strategy is recommended. We should **bundle** complementary accessories with clothing items to increase the average order value and launch a **“Buy Again”** feature to encourage repeat purchases of popular items.

---

## 💡 Summary of Strategic Recommendations

Based on the comprehensive analysis of our customers' shopping behavior, the following actions are recommended to drive revenue and enhance retention:

> ### **1. Overhaul the Loyalty Program**
> The current subscription program is ineffective, as non-subscribers generate the majority of our revenue with no difference in average spend. **The program must be redesigned** with compelling, exclusive benefits to actually increase customer value and justify the investment.

> ### **2. Leverage Discounts as a Strategic Growth Tool**
> Instead of viewing discounts as a cost center, we should treat them as a strategic lever for growth. The data proves they are crucial for retaining high-value customers. We should **expand targeted promotions** to underperforming categories like **Footwear and Outerwear** to stimulate demand and acquire new customers.

> ### **3. Focus Retention Efforts on the Clothing Category**
> Our most at-risk customer segment (low frequency, low ratings, no subscription) is concentrated in the **Clothing** category. Immediate attention should be given to **improving product quality, trend alignment, and overall customer experience** in this area to prevent churn.

> ### **4. Lean into Premium and Free Shipping Options**
> Free and fast shipping options are not just a cost of doing business—they are significant revenue drivers. We should continue to **prominently feature and promote these options** as a key value proposition to our customers.
