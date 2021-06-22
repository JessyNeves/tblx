SELECT DISTINCT
    distance,
    origin_city_name,
    dest_city_name
FROM {SOURCE}
WHERE UPPER(origin_city_name) LIKE 'BOSTON, MA'
ORDER BY 1 DESC
LIMIT 10
