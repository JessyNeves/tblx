SELECT
    AVG(ARR_DELAY) AS average_delay,
    CASE
        WHEN DAYOFWEEK(FL_DATE) IN (6,7)
            THEN 'WEEKEND'
        ELSE 'WEEK'
    END AS WEEK_DAY,
    ORIGIN,
    DEST,
    OP_UNIQUE_CARRIER
FROM {SOURCE}
WHERE ORIGIN = 'SFO'
    AND DEST_CITY_NAME = 'New York, NY'
GROUP BY 2,3,4,5
ORDER BY 1 ASC
LIMIT 1
