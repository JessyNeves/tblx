# tblx-challenge
Resolution proposal for tb.lx challenge

This Install & Run guide was tested in different machines via DOCKER

# 1. Installation

  ### 1.1 Dependencies
   - DOCKER (run & build)
   https://www.docker.com/
  
  ### 1.2 Build
  Once the repository is downloaded browse to the directory and build the docker image (this can take up to 5 minutes, depending on internet connection and machine):

  - ```sudo docker build -t tblx-challenge .```

 # 2. Run
 
  After the build is completed you are now able to run the docker image:
 
  - ```sudo docker run -e ORIGIN_AIRPORT=SFO -e DESTINATION_AIRPORT=LAX tblx-challenge```
  
  !!! Please notice the two parameters ORIGIN_AIRPORT and DESTINATION_AIRPORT passed to docker run !!!
  
  These parameters are meant to be used to answer Question 9 (Most punctual route given ORIGIN / DESTINATION)
  You can find in point 4 a table with some (ORIGIN, DESTINATION) combinations you can use.
  
  ### 2.1 Optional
  Raw data was obtained from transtats as csv files, as data preparation these were converted to partitioned parquet files which we ingest to calculate the report data.
  If you wish to ingest the raw csv files you can add a new parameter:
  - ```sudo docker run -e ORIGIN_AIRPORT=SFO -e DESTINATION_AIRPORT=LAX -e PREPARE=1 tblx-challenge```

  Before executing please make sure you unrar the file raw.rar in ./data/raw_data/
  
# 3. Ouput
  The answers will be displayed only in STDOUT and will not be written to disk.
  
# 4. Example route to use for question 9
| origin | dest |
| ------ | ---- |
| BQN | MCO |
| SFO | EUG |
| ATL | EVV |
| MSY | JFK |
| HPN | RSW |
| FLL | LGA |
| STT | SJU |
| RSW | HPN |
| HNL | SMF |
| GSO | DCA |

# 5. Question break-down ( this is not meant to replace the output obtained by running the solution.)

  Query 1: Which are the top 3 airlines that operate the maximum out of New York?
    +-----------+-----------------+
    |num_flights|op_unique_carrier|
    +-----------+-----------------+
    |      12750|               DL|
    |      12309|               9E|
    |      11760|               B6|
    +-----------+-----------------+
    
  Query 2: How many flights do they operate a week?
    See output. The result will show how many flights each airline has operated for each week of the year.
  
  Query 3: Which airport on destination has the worst average delay?
    PPG airport.
 
 Query 4: From what airport, flights end up arriving with the worse (average) delay?
    PPG airport.
 
 Query 5: If the source of flying was Boston what are the top 10 longest flights you could take?
    --------+----------------+------------------+
    |distance|origin_city_name|    dest_city_name|
    +--------+----------------+------------------+
    | 2704.00|      Boston, MA| San Francisco, CA|
    | 2689.00|      Boston, MA|      San Jose, CA|
    | 2611.00|      Boston, MA|   Los Angeles, CA|
    | 2602.00|      Boston, MA|    Long Beach, CA|
    | 2588.00|      Boston, MA|     San Diego, CA|
    | 2537.00|      Boston, MA|      Portland, OR|
    | 2496.00|      Boston, MA|       Seattle, WA|
    | 2381.00|      Boston, MA|     Las Vegas, NV|
    | 2300.00|      Boston, MA|       Phoenix, AZ|
    | 2105.00|      Boston, MA|Salt Lake City, UT|
    +--------+----------------+------------------+
 
 Query 6: What is the shortest flight that operates from Chicago?
    Milwaukee, WI. with a distance of 67 miles.
  
 Query 7: Suppose that you want to traverse from SFO to NY, which is the best flight in terms of average delay?
    DL's flight with an average delay of -9.42
 
 Query 8: If the flight were to be on weekdays or weekends, do these delays change?
    Yes, the values change. On weekend the best is to fly with VX, on weekdays with DL.
    +------------------+--------+-----------------+
    |min(AVERAGE_DELAY)|WEEK_DAY|OP_UNIQUE_CARRIER|
    +------------------+--------+-----------------+
    |        -11.826923| WEEKEND|               VX|
    |        -10.275362| WEEKEND|               DL|
    |         -9.154567|    WEEK|               DL|
    |         -7.353333|    WEEK|               VX|
    |         -3.075908|    WEEK|               AA|
    |          1.917526| WEEKEND|               AA|
    |          2.262431|    WEEK|               B6|
    |          7.147541| WEEKEND|               B6|
    +------------------+--------+-----------------+
 
 Query 9: How could you find the most punctual route for a parametrized pair (origin, destination) airport?
    For the route (origin, destination) -> (SFO, LAX) the most punctual route is with UA carrier and the average delay is 0.85
  

