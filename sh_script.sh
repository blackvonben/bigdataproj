wget https://raw.githubusercontent.com/blackvonben/bigdataproj/master/get_monthly.hql
wget https://raw.githubusercontent.com/blackvonben/bigdataproj/master/reducer.py
wget https://raw.githubusercontent.com/blackvonben/bigdataproj/master/mapper.py

wget https://s3.amazonaws.com/nyc-tlc/trip+data/yellow_tripdata_2018-01.csv
wget https://s3.amazonaws.com/nyc-tlc/trip+data/yellow_tripdata_2018-02.csv
wget https://s3.amazonaws.com/nyc-tlc/trip+data/yellow_tripdata_2018-03.csv
wget https://s3.amazonaws.com/nyc-tlc/trip+data/yellow_tripdata_2018-04.csv
wget https://s3.amazonaws.com/nyc-tlc/trip+data/yellow_tripdata_2018-05.csv
wget https://s3.amazonaws.com/nyc-tlc/trip+data/yellow_tripdata_2018-06.csv
wget https://s3.amazonaws.com/nyc-tlc/trip+data/yellow_tripdata_2018-07.csv
wget https://s3.amazonaws.com/nyc-tlc/trip+data/yellow_tripdata_2018-08.csv
wget https://s3.amazonaws.com/nyc-tlc/trip+data/yellow_tripdata_2018-09.csv
wget https://s3.amazonaws.com/nyc-tlc/trip+data/yellow_tripdata_2018-10.csv
wget https://s3.amazonaws.com/nyc-tlc/trip+data/yellow_tripdata_2018-11.csv
wget https://s3.amazonaws.com/nyc-tlc/trip+data/yellow_tripdata_2018-12.csv

hadoop fs -mkdir -p in_csv/
hadoop fs -copyFromLocal yellow_tripdata_2018-01.csv in_csv/
hadoop fs -copyFromLocal yellow_tripdata_2018-02.csv in_csv/
hadoop fs -copyFromLocal yellow_tripdata_2018-03.csv in_csv/
hadoop fs -copyFromLocal yellow_tripdata_2018-04.csv in_csv/
hadoop fs -copyFromLocal yellow_tripdata_2018-05.csv in_csv/
hadoop fs -copyFromLocal yellow_tripdata_2018-06.csv in_csv/
hadoop fs -copyFromLocal yellow_tripdata_2018-07.csv in_csv/
hadoop fs -copyFromLocal yellow_tripdata_2018-08.csv in_csv/
hadoop fs -copyFromLocal yellow_tripdata_2018-09.csv in_csv/
hadoop fs -copyFromLocal yellow_tripdata_2018-10.csv in_csv/
hadoop fs -copyFromLocal yellow_tripdata_2018-11.csv in_csv/
hadoop fs -copyFromLocal yellow_tripdata_2018-12.csv in_csv/

cd ..

hadoop jar /usr/lib/hadoop-mapreduce/hadoop-streaming.jar -files reducer.py,mapper.py -input in_csv\* -mapper mapper.py -reducer reducer.py -output out_python_final_git

mkdir out

hadoop fs -copyFromLocal out_python_final_git out

wget https://s3.amazonaws.com/nyc-tlc/misc/taxi+_zone_lookup.csv
wget https://raw.githubusercontent.com/blackvonben/bigdataproj/master/do_hive.hql
wget https://raw.githubusercontent.com/blackvonben/bigdataproj/master/get_monthly.hql

hive -f do_hive.hql

for i in {1..2}
do
  mkdir out/2018-$i
  hive -hiveconf i=$i -f get_monthly.hql
done

cat out/2018-1/000000_0 out/2018-2/000000_0 out/2018-3/000000_0 out/2018-4/000000_0 out/2018-5/000000_0 out/2018-6/000000_0 out/2018-7/000000_0 out/2018-8/000000_0 out/2018-9/000000_0 out/2018-10/000000_0 out/2018-11/000000_0 out/2018-12/000000_0 > out/final
cat out/2018-1/000000_0 out/2018-2/000000_0 > output/final_test


echo "----------------- HIVE RESULT -----------------"
cat out/final