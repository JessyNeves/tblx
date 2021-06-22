SELECT
    AVG(ARR_DELAY) AS average_delay,
    origin
FROM {SOURCE}
GROUP BY 2
ORDER BY 1 DESC
LIMIT 1
