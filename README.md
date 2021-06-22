# tblx-challenge
Resolution proposal for tb.lx challenge

This Install & Run guide was tested in different machines via DOCKER

# 1. Installation

  ### 1.1 Dependencies
   - DOCKER (run & build)
  
  ### 1.2 Build
  Once the repository is cloned browse to the directory and run:

  - ```sudo docker build -t tblx-challenge .```

 # 2. Run
 
  - ```sudo docker run -e ORIGIN_AIRPORT=SFO -e DESTINATION_AIRPORT=LAX tblx-challenge```
  
  !!! Please notice the two parameters ORIGIN_AIRPORT and DESTINATION_AIRPORT passed to docker run !!!
  
  These parameters are meant to be used to answer Question 9 (Most punctual route given ORIGIN / DESTINATION)
  
  ### 2.1 Optional
  Raw data was obtained from transtats as csv files, as data preparation these were converted to partitioned parquet files which we ingest to calculate the report data.
  If you wish to ingest the raw csv files you can add a new parameter:
  - ```sudo docker run -e ORIGIN_AIRPORT=SFO -e DESTINATION_AIRPORT=LAX -e PREPARE=1 tblx-challenge```

  Before executing please make sure you unrar the file raw.rar in ./data/raw_data/
  
# 3. Ouput
  The answers will be displayed only in STDOUT and will not be written to disk.
  


