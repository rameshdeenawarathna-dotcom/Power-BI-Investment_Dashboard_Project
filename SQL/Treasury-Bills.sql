/*
Project: Financial Market Analytics Dashboard
Module: Treasury Bill Analysis
Author: Ramesh Nawarathna

Purpose:
Prepare Treasury Bill investment data for analysis
and visualization in Power BI.

Key Analysis:
- Face Value
- Purchase Value
- Discount Income
- Annualised Yield
- Days to Maturity
- Maturity Classification
*/

SELECT
    investment_id,
    security_code,
    purchase_date,
    maturity_date,
    face_value,
    purchase_value,
    purchase_yield,

    face_value - purchase_value AS discount_income,

    DATEDIFF(day, purchase_date, maturity_date)
        AS original_tenor_days,

    DATEDIFF(day, CURRENT_TIMESTAMP, maturity_date)
        AS days_to_maturity,

    CASE
        WHEN maturity_date < CAST(CURRENT_TIMESTAMP AS DATE)
            THEN 'Matured'

        WHEN DATEDIFF(day, CURRENT_TIMESTAMP, maturity_date)
             BETWEEN 0 AND 30
            THEN 'Maturing Within 30 Days'

        WHEN DATEDIFF(day, CURRENT_TIMESTAMP, maturity_date)
             BETWEEN 31 AND 90
            THEN 'Maturing Within 90 Days'

        ELSE 'Active'
    END AS investment_status

FROM treasury_bill_portfolio

ORDER BY maturity_date;
