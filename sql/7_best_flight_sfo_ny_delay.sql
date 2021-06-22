SELECT
    AVG(ARR_DELAY) AS average_arrival_delay,
    ORIGIN,
    DEST,
    OP_UNIQUE_CARRIER
FROM {SOURCE}
WHERE ORIGIN = 'SFO'
    AND DEST_CITY_NAME LIKE '%NY'
GROUP BY 2,3,4
ORDER BY 1 ASC
LIMIT 1
