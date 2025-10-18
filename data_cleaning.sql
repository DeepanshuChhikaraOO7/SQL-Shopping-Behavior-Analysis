-- This script contains the data cleaning and validation steps for the shopping_behavior table.

-- Step 1: Remove any erroneous columns that may have been created during the CSV import process.
-- Note: This command is commented out but is here for reference if an extra column like "Item Purchased" appears.
-- ALTER TABLE shopping_behavior DROP COLUMN IF EXISTS "Item Purchased";

-- Step 2: Verify the total number of rows in the table.
SELECT
    COUNT(*) AS total_rows
FROM
    shopping_behavior;

-- Step 3: Perform a comprehensive check for NULL values across all columns to ensure data completeness.
-- A count of 0 for each column confirms that there is no missing data.
SELECT
    COUNT(*) FILTER (WHERE customer_id IS NULL) AS ci_null,
    COUNT(*) FILTER (WHERE age IS NULL) AS age_null,
    COUNT(*) FILTER (WHERE gender IS NULL) AS gender_null,
    COUNT(*) FILTER (WHERE item_purchased IS NULL) AS ip_null,
    COUNT(*) FILTER (WHERE category IS NULL) AS category_null,
    COUNT(*) FILTER (WHERE purchase_amount IS NULL) AS pa_null,
    COUNT(*) FILTER (WHERE location IS NULL) AS location_null,
    COUNT(*) FILTER (WHERE size IS NULL) AS size_null,
    COUNT(*) FILTER (WHERE color IS NULL) AS color_null,
    COUNT(*) FILTER (WHERE season IS NULL) AS season_null,
    COUNT(*) FILTER (WHERE review_rating IS NULL) AS rr_null,
    COUNT(*) FILTER (WHERE subscription_status IS NULL) AS ss_null,
    COUNT(*) FILTER (WHERE shipping_type IS NULL) AS st_null,
    COUNT(*) FILTER (WHERE discount_applied IS NULL) AS da_null,
    COUNT(*) FILTER (WHERE promo_code_used IS NULL) AS pcu_null,
    COUNT(*) FILTER (WHERE previouse_purchase IS NULL) AS pp_null,
    COUNT(*) FILTER (WHERE payment_method IS NULL) AS pm_null,
    COUNT(*) FILTER (WHERE frequency_of_purchases IS NULL) AS fp_null
FROM
    shopping_behavior;

-- Conclusion: The data integrity check confirms that there are 0 null values across all columns.
-- The dataset is clean, complete, and ready for analysis.