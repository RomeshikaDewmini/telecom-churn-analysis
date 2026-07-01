-- =============================================
-- TELECOM CHURN ANALYSIS - SQL QUERIES
-- Database: telecom_churn
-- Table: telco_churn
-- =============================================

-- =============================================
-- 1. OVERALL CHURN RATE
-- =============================================
-- Purpose: Calculate overall churn rate
-- Expected Result: 26.54%

SELECT 
    COUNT(*) AS Total_Customers,
    SUM(CASE WHEN Churn_Status = 'Yes' THEN 1 ELSE 0 END) AS Churned_Customers,
    ROUND(
        SUM(CASE WHEN Churn_Status = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 
        2
    ) AS Churn_Rate_Percent
FROM telco_churn;

-- =============================================
-- 2. CHURN BY CONTRACT TYPE
-- =============================================
-- Purpose: Identify which contract types have highest churn
-- Expected Result: Month-to-month has highest churn (42.71%)

SELECT 
    Contract,
    COUNT(*) AS Total_Customers,
    SUM(CASE WHEN Churn_Status = 'Yes' THEN 1 ELSE 0 END) AS Churned_Customers,
    ROUND(
        SUM(CASE WHEN Churn_Status = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 
        2
    ) AS Churn_Rate_Percent
FROM telco_churn
GROUP BY Contract
ORDER BY Churn_Rate_Percent DESC;

-- =============================================
-- 3. CHURN BY INTERNET SERVICE
-- =============================================
-- Purpose: Identify which internet services have highest churn
-- Expected Result: Fiber optic has highest churn (35.01%)

SELECT 
    Internet_Service_Type,
    COUNT(*) AS Total_Customers,
    SUM(CASE WHEN Churn_Status = 'Yes' THEN 1 ELSE 0 END) AS Churned_Customers,
    ROUND(
        SUM(CASE WHEN Churn_Status = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 
        2
    ) AS Churn_Rate_Percent
FROM telco_churn
GROUP BY Internet_Service_Type
ORDER BY Churn_Rate_Percent DESC;

-- =============================================
-- 4. CHURN BY PAYMENT METHOD
-- =============================================
-- Purpose: Identify which payment methods have highest churn
-- Expected Result: Electronic check has highest churn (45.28%)

SELECT 
    Payment_Method,
    COUNT(*) AS Total_Customers,
    SUM(CASE WHEN Churn_Status = 'Yes' THEN 1 ELSE 0 END) AS Churned_Customers,
    ROUND(
        SUM(CASE WHEN Churn_Status = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 
        2
    ) AS Churn_Rate_Percent
FROM telco_churn
GROUP BY Payment_Method
ORDER BY Churn_Rate_Percent DESC;

-- =============================================
-- 5. CHURN BY TENURE GROUP
-- =============================================
-- Purpose: Identify which tenure groups have highest churn
-- Expected Result: 0-1 Year has highest churn (50.46%)

SELECT 
    CASE 
        WHEN Tenure_Months <= 12 THEN '0-1 Year'
        WHEN Tenure_Months <= 24 THEN '1-2 Years'
        WHEN Tenure_Months <= 48 THEN '2-4 Years'
        ELSE '4+ Years'
    END AS Tenure_Group,
    COUNT(*) AS Total_Customers,
    SUM(CASE WHEN Churn_Status = 'Yes' THEN 1 ELSE 0 END) AS Churned_Customers,
    ROUND(
        SUM(CASE WHEN Churn_Status = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 
        2
    ) AS Churn_Rate_Percent
FROM telco_churn
GROUP BY 
    CASE 
        WHEN Tenure_Months <= 12 THEN '0-1 Year'
        WHEN Tenure_Months <= 24 THEN '1-2 Years'
        WHEN Tenure_Months <= 48 THEN '2-4 Years'
        ELSE '4+ Years'
    END
ORDER BY Churn_Rate_Percent DESC;

-- =============================================
-- 6. CHURN BY TECH SUPPORT
-- =============================================
-- Purpose: Identify if tech support affects churn
-- Expected Result: No tech support has higher churn (39.45%)

SELECT 
    Has_Tech_Support,
    COUNT(*) AS Total_Customers,
    SUM(CASE WHEN Churn_Status = 'Yes' THEN 1 ELSE 0 END) AS Churned_Customers,
    ROUND(
        SUM(CASE WHEN Churn_Status = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 
        2
    ) AS Churn_Rate_Percent
FROM telco_churn
GROUP BY Has_Tech_Support
ORDER BY Churn_Rate_Percent DESC;

-- =============================================
-- 7. CHURN BY SENIOR CITIZEN
-- =============================================
-- Purpose: Identify if senior citizens churn differently

SELECT 
    CASE 
        WHEN Senior_Citizen = 1 THEN 'Yes'
        ELSE 'No'
    END AS Senior_Citizen_Status,
    COUNT(*) AS Total_Customers,
    SUM(CASE WHEN Churn_Status = 'Yes' THEN 1 ELSE 0 END) AS Churned_Customers,
    ROUND(
        SUM(CASE WHEN Churn_Status = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 
        2
    ) AS Churn_Rate_Percent
FROM telco_churn
GROUP BY Senior_Citizen
ORDER BY Senior_Citizen;

-- =============================================
-- 8. CHURN BY PARTNER STATUS
-- =============================================
-- Purpose: Identify if having a partner affects churn

SELECT 
    Partner,
    COUNT(*) AS Total_Customers,
    SUM(CASE WHEN Churn_Status = 'Yes' THEN 1 ELSE 0 END) AS Churned_Customers,
    ROUND(
        SUM(CASE WHEN Churn_Status = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 
        2
    ) AS Churn_Rate_Percent
FROM telco_churn
GROUP BY Partner
ORDER BY Churn_Rate_Percent DESC;

-- =============================================
-- 9. CHURN BY GENDER
-- =============================================
-- Purpose: Identify if gender affects churn

SELECT 
    Gender,
    COUNT(*) AS Total_Customers,
    SUM(CASE WHEN Churn_Status = 'Yes' THEN 1 ELSE 0 END) AS Churned_Customers,
    ROUND(
        SUM(CASE WHEN Churn_Status = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 
        2
    ) AS Churn_Rate_Percent
FROM telco_churn
GROUP BY Gender
ORDER BY Churn_Rate_Percent DESC;

-- =============================================
-- 10. CUSTOMER RISK SCORE SUMMARY
-- =============================================
-- Purpose: Summary of customer risk distribution
-- Expected Result: High: 19.6%, Medium: 19.4%, Low: 61.0%

SELECT 
    Risk_Level,
    COUNT(*) AS Total_Customers,
    ROUND(
        COUNT(*) * 100.0 / (SELECT COUNT(*) FROM telco_churn), 
        2
    ) AS Percentage_of_Total
FROM telco_churn
GROUP BY Risk_Level
ORDER BY Risk_Level;

-- =============================================
-- 11. CHURN MATRIX - CONTRACT VS INTERNET SERVICE
-- =============================================
-- Purpose: Cross-tabulation of churn by contract and internet service

SELECT 
    Contract,
    Internet_Service_Type,
    COUNT(*) AS Total_Customers,
    SUM(CASE WHEN Churn_Status = 'Yes' THEN 1 ELSE 0 END) AS Churned_Customers,
    ROUND(
        SUM(CASE WHEN Churn_Status = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 
        2
    ) AS Churn_Rate_Percent
FROM telco_churn
GROUP BY Contract, Internet_Service_Type
ORDER BY Contract, Internet_Service_Type;

-- =============================================
-- 12. TOP 10 CHURN DRIVERS SUMMARY
-- =============================================
-- Purpose: Summary of key churn drivers

SELECT 
    'Month-to-month Contract' AS Churn_Driver,
    COUNT(*) AS Affected_Customers,
    ROUND(
        SUM(CASE WHEN Churn_Status = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 
        2
    ) AS Churn_Rate_Percent
FROM telco_churn
WHERE Contract = 'Month-to-month'

UNION ALL

SELECT 
    'Electronic Check Payment' AS Churn_Driver,
    COUNT(*) AS Affected_Customers,
    ROUND(
        SUM(CASE WHEN Churn_Status = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 
        2
    ) AS Churn_Rate_Percent
FROM telco_churn
WHERE Payment_Method = 'Electronic check'

UNION ALL

SELECT 
    'No Tech Support' AS Churn_Driver,
    COUNT(*) AS Affected_Customers,
    ROUND(
        SUM(CASE WHEN Churn_Status = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 
        2
    ) AS Churn_Rate_Percent
FROM telco_churn
WHERE Has_Tech_Support = 'No'

UNION ALL

SELECT 
    'Fiber Optic Service' AS Churn_Driver,
    COUNT(*) AS Affected_Customers,
    ROUND(
        SUM(CASE WHEN Churn_Status = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 
        2
    ) AS Churn_Rate_Percent
FROM telco_churn
WHERE Internet_Service_Type = 'Fiber optic'

UNION ALL

SELECT 
    'New Customer (0-1 Year)' AS Churn_Driver,
    COUNT(*) AS Affected_Customers,
    ROUND(
        SUM(CASE WHEN Churn_Status = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 
        2
    ) AS Churn_Rate_Percent
FROM telco_churn
WHERE Tenure_Months <= 12

ORDER BY Churn_Rate_Percent DESC;

-- =============================================
-- END OF QUERIES
-- =============================================