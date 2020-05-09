create database taxi;
use taxi;
create table taxi_zones(id int, borough string, zone string, service_zone string) ROW FORMAT DELIMITED FIELDS TERMINATED BY ',' STORED AS TEXTFILE;
load data local inpath "/home/p_o_laskowski/taxi+_zone_lookup.csv
create table taxi_tripdata(month_year string, zone int, passenger_count int) ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t' STORED AS TEXTFILE;
load data local inpath "/home/p_o_laskowski/out/out_python_final_git/part-00000" into table taxi_tripdata;
load data local inpath "/home/p_o_laskowski/out/out_python_final_git/part-00001" into table taxi_tripdata;
load data local inpath "/home/p_o_laskowski/out/out_python_final_git/part-00002" into table taxi_tripdata;
load data local inpath "/home/p_o_laskowski/out/out_python_final_git/part-00003" into table taxi_tripdata;
load data local inpath "/home/p_o_laskowski/out/out_python_final_git/part-00004" into table taxi_tripdata;