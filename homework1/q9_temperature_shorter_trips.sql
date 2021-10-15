/*
A short trip is a trip whose duration is <= 60 seconds.

Print the average temperature that a short trip starts and the average temperature that a non-short trip starts.
*/

WITH trip_cte AS (
  SELECT
    weather.mean_temp,
    (JULIANDAY(trip.end_time) - JULIANDAY(trip.start_time)) * 24 * 60 * 60 AS duration_seconds
  FROM trip
  JOIN station ON trip.start_station_id = station.station_id
  JOIN weather ON station.zip_code = weather.zip_code AND date(trip.start_time) = weather.date
)

SELECT average_temp_short_trip, average_temp_long_trip FROM (
  (
    SELECT ROUND(AVG(mean_temp), 4) AS average_temp_short_trip
    FROM trip_cte
    WHERE duration_seconds <= 60
  ) short_trip
  JOIN
  (
    SELECT ROUND(AVG(mean_temp), 4) AS average_temp_long_trip
    FROM trip_cte
    WHERE duration_seconds > 60
  ) long_trip ON 1 = 1
);
