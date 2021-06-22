SELECT
    COUNT(1) AS num_flights,
    op_unique_carrier
FROM {SOURCE}
WHERE ORIGIN_CITY_NAME = 'New York, NY'
GROUP BY 2
ORDER BY 1 DESC
LIMIT 3
