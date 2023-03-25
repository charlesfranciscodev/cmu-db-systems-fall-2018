/*
Count the number of stations in each city.
Details:
  Print city name and number of stations.
  Sort by number of stations (increasing), and break ties by city name (increasing).
*/
SELECT city, COUNT(station_id) AS nb_stations
FROM station
GROUP BY city
ORDER BY nb_stations, city;
