CREATE TABLE station(
station_id smallint not null,
station_name text,
lat real,
long real,
dock_count smallint,
city text,
installation_date date,
zip_code text,
PRIMARY KEY (station_id)
);

CREATE TABLE trip(
id integer not null,
duration integer,
start_time timestamp,
start_station_name text,
start_station_id smallint,
end_time timestamp,
end_station_name text,
end_station_id smallint,
bike_id smallint,
PRIMARY KEY (id),
FOREIGN KEY (start_station_id) REFERENCES  station(station_id),
FOREIGN KEY (end_station_id) REFERENCES  station(station_id)
);

CREATE TABLE weather(
date date not null,
max_temp real,
mean_temp real,
min_team real,
max_visibility_miles real,
mean_visibility_miles real,
min_visibility_miles real,
max_wind_speed_mph real,
mean_wind_speed_mph real,
max_gust_speed_mph real,
cloud_cover real,
events text,
wind_dir_degrees real,
zip_code text not null,
PRIMARY KEY (date, zip_code)
);

.separator ,

.import station.csv station

.import trip.csv trip

.import weather.csv weather
