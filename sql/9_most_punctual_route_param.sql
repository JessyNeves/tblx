SELECT
    AVG(arr_delay) as average_delay,
    origin,
    dest,
    op_unique_carrier
FROM {SOURCE}
WHERE origin = '{ORIGIN_AIRPORT}'
    AND dest = '{DESTINATION_AIRPORT}'
GROUP BY 2,3,4
ORDER BY 1 ASC
LIMIT 1
