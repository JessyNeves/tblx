SELECT DISTINCT
    distance,
    origin_city_name,
    dest_city_name
FROM {SOURCE}
WHERE origin = 'BOS'
ORDER BY 1 DESC
LIMIT 10
