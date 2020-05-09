use taxi;
insert overwrite local directory '/home/p_o_laskowski/project/hive/output' row format delimited fields terminated by ','
        SELECT tt.month_year, tz.borough, SUM(tt.passenger_count) as passenger_c FROM taxi_tripdata tt
        INNER JOIN taxi_zones tz ON tt.zone = tz.id
        WHERE tt.month_year = "2018-1"
        GROUP BY tt.month_year, tz.borough
        ORDER BY passenger_c DESC
        LIMIT 3;