/*
Find the station that has the most number of trips under 'Rain-Thunderstorm' weather in each zip code.
For simplicity, we only consider the start time of a trip when deciding the station and the weather for that trip.
Details:
  Print the zip code, the name of the station, and the total number of trips
  Sort by the zip code (increasing).
*/
SELECT zip_code, station_name, nb_trips
FROM
(
  SELECT
    zip_code, station_name, COUNT(id) AS nb_trips,
    RANK() OVER (PARTITION BY zip_code ORDER BY COUNT(id) DESC) nb_trips_rank
  FROM (
    SELECT station.zip_code, station.station_name, trip.id
    FROM station
    JOIN trip ON station.station_id = trip.start_station_id
    JOIN weather ON station.zip_code = weather.zip_code AND date(trip.start_time) = weather.date
    WHERE weather.events = 'Rain-Thunderstorm'
  )
  GROUP BY zip_code, station_name
)
WHERE nb_trips_rank = 1
;

/*
New data to test window functions:

INSERT INTO trip
VALUES (913461, 174, '2014-11-30 09:08:00', 'Cowper at University', 37, '2014-11-30 09:11:00', 'Cowper at University', 37, 288);
INSERT INTO trip
VALUES (913462, 174, '2014-11-30 09:18:00', 'Cowper at University', 37, '2014-11-30 09:21:00', 'Cowper at University', 37, 288);
INSERT INTO trip
VALUES (913463, 174, '2014-11-30 09:18:00', 'Park at Olive', 38, '2014-11-30 09:21:00', 'Park at Olive', 38, 288);
*/
