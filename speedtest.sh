#!/bin/bash

# go to folder that contains the script in case running as cron
scriptpath="$( cd "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
cd $scriptpath

# get timestamp
timestamp=`date '+%F %T'`

# get ip of machine
ip="$(dig +short myip.opendns.com @resolver1.opendns.com)"

# get latest speedtest from git because the apt version gives bad upload results
wget -q https://raw.githubusercontent.com/sivel/speedtest-cli/master/speedtest.py -O speedtest.py

# make speedtest executable
chmod +x speedtest.py

# run speedtest and output log
python speedtest.py --simple > speedtest_output.log

# it will pick the closest speedtest.net server to you by default
# to get a specific server run: 
#   python speedtest.py --list | grep "Server Name"
# put the server number in the command: 
#   python speedtest.py --simple --server ###### > speedtest_output.log

# get results from log
download=$(cat speedtest_output.log | sed -ne 's/^Download: \([0-9]*\.[0-9]*\).*/\1/p')
upload=$(cat speedtest_output.log | sed -ne 's/^Upload: \([0-9]*\.[0-9]*\).*/\1/p')
ping=$(cat speedtest_output.log | sed -ne 's/^Ping: \([0-9]*\.[0-9]*\).*/\1/p')

# echo output in case run from command line
echo "Timestamp = $timestamp"
echo "IP = $ip"
echo "Ping =  $ping ms"
echo "Download = $download Mbps"
echo "Upload =  $upload Mbps"

# write data to csv file
echo "$timestamp,$ip,$ping,$download,$upload" >> speedtest_history.csv
