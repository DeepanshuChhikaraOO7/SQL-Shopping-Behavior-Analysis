/*
Business Question 1: Which demographics (Age/Gender/Location) generate the most revenue?
*/
WITH demographic_group AS (
    SELECT
        CASE 
            WHEN age BETWEEN 18 AND 30 THEN '18-30'
            WHEN age BETWEEN 31 AND 40 THEN '31-40'
            WHEN age BETWEEN 41 AND 50 THEN '41-50'
            WHEN age BETWEEN 51 AND 60 THEN '51-60'
            WHEN age BETWEEN 61 AND 70 THEN '61-70'
        END AS age_group,
        gender,
        location,
        SUM(purchase_amount) AS total_revenue 
    FROM
        shopping_behavior
    GROUP BY
        age_group, gender, location
)
SELECT
    age_group,
    gender,
    location,
    SUM(total_revenue) AS total_amount
FROM
    demographic_group
GROUP BY
    age_group, gender, location
ORDER BY
    total_amount DESC
LIMIT 10;
-- Conclusion: The demographic analysis reveals that Male customers consistently generate the highest revenue across various age groups and locations. The top-performing segment is Males aged 41-50 in Delaware, followed closely by Males aged 18-30 in California and Illinois. This indicates that marketing and retention efforts should be strongly focused on the male demographic.


/*
Business Question 2: Do discounts increase profit or only attract low-value customers?
*/
WITH customer_segments AS (
    SELECT
        customer_id,
        CASE
            WHEN SUM(purchase_amount) > 60 THEN 'High-Value Customer'
            ELSE 'Low-Value Customer'
        END AS customer_segment
    FROM
        shopping_behavior
    GROUP BY
        customer_id
)
SELECT
    cs.customer_segment,
    sb.discount_applied,
    COUNT(sb.customer_id) AS number_of_purchases,
    SUM(sb.purchase_amount) AS total_revenue,
    AVG(sb.purchase_amount) AS avg_purchase_amount
FROM
    shopping_behavior sb
JOIN
    customer_segments cs ON sb.customer_id = cs.customer_id
GROUP BY
    cs.customer_segment,
    sb.discount_applied
ORDER BY
    cs.customer_segment,
    sb.discount_applied;
-- Conclusion: Contrary to the concern that discounts only attract low-value shoppers, the data demonstrates that they are a critical driver of revenue across all customer segments. High-value customers are significant users of discounts, with 819 discounted purchases generating $65,742 in revenue. Instead of being viewed as a cost, discounts should be recognized as a key tool for retaining and engaging our most profitable customers. The strategy should be to target promotions effectively to encourage repeat business from this core group.


/*
Business Question 3: Are Subscribed Customers more profitable? Should more push be given to loyalty programs?
*/
SELECT
    subscription_status,
    COUNT(customer_id) AS total_customers,
    SUM(purchase_amount) AS total_purchasing_amount,
    ROUND(AVG(purchase_amount), 2) AS avg_cost
FROM 
    shopping_behavior
GROUP BY
    subscription_status
ORDER BY
    total_purchasing_amount DESC;
-- Conclusion: The analysis indicates that non-subscribed customers currently generate the majority of revenue ($170,436) compared to subscribers ($62,645). With the average spend being nearly identical for both groups (~$59), the current loyalty program is not effectively increasing customer value or spend. The program requires a strategic overhaul to become a meaningful driver of sales and retention.


/*
Business Question 4: Does higher product satisfaction lead to higher frequency or higher-priced purchases?
*/
SELECT
    CASE
        WHEN review_rating >= 2.5 AND review_rating < 3 THEN '2.5 - 3.0'
        WHEN review_rating >= 3 AND review_rating < 4 THEN '3.0 - 3.9'
        WHEN review_rating >= 4 AND review_rating < 5 THEN '4.0 - 4.9'
        WHEN review_rating = 5 THEN '5.0'
    END AS rating_category,
    ROUND(AVG(purchase_amount), 2) AS avg_purchase_value,
    MODE() WITHIN GROUP (ORDER BY frequency_of_purchases) AS most_common_frequency
FROM 
    shopping_behavior
WHERE
    review_rating >= 2.5
GROUP BY
    rating_category
ORDER BY
    rating_category;
-- Conclusion: A clear and positive correlation exists between product satisfaction and purchase value. As review ratings increase from the 2.5-3.0 range to a perfect 5.0, the average purchase amount steadily rises from $58.52 to $64.35. However, the data does not support the claim that higher satisfaction leads to higher purchase frequency, as the purchase cycle is inconsistent across rating levels. The primary benefit of higher product satisfaction is driving higher-value transactions, not increasing purchase frequency.


/*
Business Question 5: Which Shipping Type and Payment Method correlate with higher spend?
*/
SELECT
    shipping_type,
    payment_method,
    COUNT(customer_id) AS total_customers,
    SUM(purchase_amount) AS total_purchasing_amount,
    ROUND(AVG(purchase_amount), 2) AS avg_cost
FROM 
    shopping_behavior
GROUP BY
    shipping_type, payment_method
ORDER BY
    total_purchasing_amount DESC;
-- Conclusion: While the combination of Express Shipping and PayPal drives the highest overall sales volume ($7,695), it does not correlate with the highest average spend per customer. Customers opting for immediate fulfillment methods like Store Pickup (with Debit Card) and Express (with Cash) tend to have a higher average purchase value, spending over $62 per transaction. Conversely, Standard Shipping is consistently correlated with lower average order values, suggesting it is preferred by more price-sensitive customers.


/*
Business Question 6: Identify low-frequency buyers with low ratings and propose retention strategies.
*/
WITH low_engagement_customers AS (
    SELECT
        * 
    FROM
        shopping_behavior
    WHERE
        review_rating BETWEEN 2.5 AND 3.0
        AND subscription_status = 'No'
        AND frequency_of_purchases IN ('Annually', 'Quarterly')
)
SELECT
    category,
    COUNT(customer_id) AS total_at_risk_customers,
    ROUND(AVG(review_rating), 2) AS avg_rating,
    ROUND(AVG(purchase_amount), 2) AS avg_purchase_amount
FROM
    low_engagement_customers
GROUP BY
    category
ORDER BY
    total_at_risk_customers DESC;
-- Conclusion: By segmenting for customers with low ratings (2.5-3.0), low purchase frequency (Annually or Quarterly), and no subscription, we can identify a key at-risk cohort. A significant 44% of these disengaged customers come from the Clothing category. This strongly suggests that retention strategies should focus on investigating and improving the product quality, store experience, and fashion diversity within the clothing line to re-engage this customer segment.


/*
Business Question 7: Should we restrict promo codes for customers who always buy with discounts?
*/
SELECT
    category,
    COUNT(item_purchased) AS total_discounted_purchases
FROM
    shopping_behavior
WHERE
    discount_applied = 'Yes'
GROUP BY
    category
ORDER BY
    total_discounted_purchases DESC;
-- Conclusion: The analysis shows that the Clothing category accounts for 43% of all promo code usage. Restricting promo codes is not recommended, as they are an essential part of customer buying behavior. A more effective strategy would be to leverage promotions to stimulate growth in underperforming categories, such as Footwear and Outerwear, to increase their sales volume and attract new customers.


/*
Business Question 8: Is free or fast shipping actually increasing revenue?
*/
SELECT
    shipping_type,
    ROUND(AVG(purchase_amount), 2) AS avg_revenue,
    SUM(purchase_amount) AS total_revenue,
    COUNT(item_purchased) AS total_buys
FROM
    shopping_behavior
GROUP BY
    shipping_type
ORDER BY
    total_revenue DESC;
-- Conclusion: Yes, both free and fast shipping options are correlated with strong revenue generation. "Free Shipping" drives the highest number of orders (675) and "Express" and "2-Day Shipping" are associated with a higher average spend per customer (over $60). Collectively, these premium and free options account for a significant portion of total revenue, confirming their value.


/*
Business Question 9: What triggers higher satisfaction — product quality or speed of delivery?
*/
SELECT
    'Category' AS dimension,
    category AS detail,
    ROUND(AVG(review_rating), 2) AS avg_rating
FROM shopping_behavior GROUP BY category
UNION ALL
SELECT
    'Shipping Type' AS dimension,
    shipping_type AS detail,
    ROUND(AVG(review_rating), 2) AS avg_rating
FROM shopping_behavior GROUP BY shipping_type;
-- Conclusion: The analysis reveals that neither product category nor shipping type is a dominant driver of customer satisfaction. Average review ratings are tightly clustered for all product categories (between 3.72 and 3.79) and all shipping types (between 3.71 and 3.82). This indicates a highly consistent level of customer satisfaction across the board, regardless of the item purchased or the delivery method chosen.


/*
Business Question 10: Should we bundle products or launch “Buy Again” recommendations?
*/
-- Conclusion: Given the high satisfaction ratings and sales volume in both the Clothing and Accessories categories, a dual strategy is recommended. Apple should **bundle** complementary accessories with clothing items to increase average order value. Simultaneously, they should launch a **"Buy Again"** feature to encourage repeat purchases of popular and essential items.