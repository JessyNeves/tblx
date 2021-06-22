SELECT
    COUNT(1) AS flights_per_week,
    OP_UNIQUE_CARRIER,
    WEEKOFYEAR(FL_DATE) AS week_of_year
FROM {SOURCE}
WHERE UPPER(ORIGIN_CITY_NAME) = 'NEW YORK, NY'
    AND OP_UNIQUE_CARRIER IN (
                        SELECT OP_UNIQUE_CARRIER
                        FROM (
                            SELECT
                                COUNT(1),
                                OP_UNIQUE_CARRIER
                            FROM {SOURCE}
                        WHERE UPPER(ORIGIN_CITY_NAME) = 'NEW YORK, NY'
                        GROUP BY 2
                        ORDER BY 1 DESC
                        LIMIT 3
                            )
                        )
GROUP BY 2,3
ORDER BY 2,3 ASC,
    1 DESC
