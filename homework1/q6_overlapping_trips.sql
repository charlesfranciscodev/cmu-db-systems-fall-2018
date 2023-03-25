/*
One of the possible data-entry errors is to record a bike as being used in two different trips, at the same time.
Thus, we want to spot pairs of overlapping intervals (start time, end time).
We ask you to do this check for bikes with id between 100 and 200.
Details: For each conflict, print the bike id, former and latter trip ids, start times and end times.
Sort by bike id (increasing), break ties with former trip id (increasing) and then latter trip id (increasing).
*/
SELECT former.bike_id, former.id, former.start_time, former.end_time, latter.id, latter.start_time, latter.end_time
FROM trip AS former
JOIN trip AS latter
WHERE
  former.bike_id >= 100 AND former.bike_id <= 200 AND
  former.bike_id == latter.bike_id AND -- same bike
  former.start_time < latter.end_time AND former.end_time > latter.start_time AND -- check for overlap
  former.id < latter.id; -- eliminate duplicates
