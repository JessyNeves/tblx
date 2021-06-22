SELECT
    MIN(distance) as distance,
    dest_city_name
FROM {SOURCE}
WHERE origin_city_name = 'Chicago, IL'
GROUP BY 2
ORDER BY MIN(distance) ASC
LIMIT 1
