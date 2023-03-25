/*
Find all the bikes that have been to more than one city.
A bike has been to a city as long as the start station or end station in one of its trips is in that city.
Details:
  For each bike that has been to more than one city, print the bike id and the number of cities it has been to.
  Sort by the number of cities (decreasing), then bike id (increasing).
*/
SELECT trip.bike_id, COUNT(DISTINCT(station.city)) AS nb_cities
FROM trip
JOIN station ON trip.start_station_id = station.station_id OR trip.end_station_id = station.station_id
GROUP BY bike_id
HAVING nb_cities > 1
ORDER BY nb_cities DESC, bike_id;
