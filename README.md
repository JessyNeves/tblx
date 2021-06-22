# tblx-challenge
Resolution proposal for tb.lx challenge

This Install & Run guide was tested in different machines via DOCKER

# 1. Installation

  ### 1.1 Dependencies
   - DOCKER (run & build)
  
  ### 1.2 Build
  Once the repository is cloned browse to the directory and run:

  - ```sudo docker build -t tblx-challenge```

 # 2. Run
  
  - ```sudo docker run -e ORIGIN_AIRPORT=SFO -e DESTINATION_AIRPORT=LAX tblx-challenge```
  Please notice the two parameters passed to the Run command. If left blank default parameters are defined in Dockerfile.
  These parameters are meant to be used to answer Question 9 (Most punctual route given ORIGIN / DESTINATION)
  
  The answers will be displayed in stdout and will not be written to disk, nonetheless in folder ./aux you will find .csv files 
  for each answer.
  


