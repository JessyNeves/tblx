SELECT
    COUNT(1) AS flights_per_week,
    OP_UNIQUE_CARRIER,
    WEEKOFYEAR(FL_DATE) AS week_of_year
FROM {SOURCE}
WHERE ORIGIN_CITY_NAME = 'New York, NY'
    AND OP_UNIQUE_CARRIER IN (
                        SELECT OP_UNIQUE_CARRIER
                        FROM (
                            SELECT
                                COUNT(1),
                                OP_UNIQUE_CARRIER
                            FROM {SOURCE}
                        WHERE ORIGIN_CITY_NAME = 'New York, NY'
                        GROUP BY 2
                        ORDER BY 1 DESC
                        LIMIT 3
                            )
                        )
GROUP BY 2,3
ORDER BY 2,3 ASC,
    1 DESC
