-- Create the table structure to hold customer shopping behavior data
CREATE TABLE shopping_behavior (
    customer_id INT PRIMARY KEY,
    age INT,
    gender VARCHAR(10),
    item_purchased VARCHAR(30),
    category VARCHAR(30),
    purchase_amount INT,
    location VARCHAR(30),
    size VARCHAR(3),
    color VARCHAR(10),
    season VARCHAR(10),
    review_rating NUMERIC(2, 1),
    subscription_status VARCHAR(5),
    shipping_type VARCHAR(15),
    discount_applied VARCHAR(5),
    promo_code_used VARCHAR(5),
    previouse_purchase INT,
    payment_method VARCHAR(20),
    frequency_of_purchases VARCHAR(20)
);