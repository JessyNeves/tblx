SELECT
    MIN(distance) as distance,
    dest_city_name
FROM {SOURCE}
WHERE UPPER(origin_city_name) LIKE 'CHICAGO, IL'
GROUP BY 2
ORDER BY MIN(distance) ASC
LIMIT 1
