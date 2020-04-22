# Bash Speedtest

[![MIT](https://flat.badgen.net/badge/license/MIT/orange)](LICENSE)

This is a simple bash script that runs a speed test against speedtest.net and saves the results.

## Introduction

The script pulls the latest version of [speedtest-cli](https://github.com/sivel/speedtest-cli) from its Git repository, makes it executable, runs a speed test, and stores the results in a CSV file. It can be run manually and will echo the results in the terminal or it can be set to run as a cron job and will save the results in the folder that the script is run in.

The CSV file contains 5 columns:

- time stamp
- ip address of the machine running the speed test
- ping in milliseconds
- download speed in megabits/second
- upload speed in megabits/second

## License

[The MIT License (MIT)](LICENSE)
