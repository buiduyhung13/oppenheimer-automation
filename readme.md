# Oppenheimer-automation

## Prerequisite

- Python 3
- Chrome

## Install requirement library

- pip3 install -U robotframework
- pip3 install -U robotframework-jsonlibrary
- pip3 install -U robotframework-seleniumlibrary

## Step to run

Skip step 1 & 2 if you load from .env file

1. export ROBOT_OPTIONS="--outputdir results"
1. export ROBOT_SYSLOG_FILE="./results/logs"
1. Download latest app from github `https://github.com/auronsiow/oppenheimer-project-dev/raw/master/OppenheimerProjectDev.jar`
1. Go to downloaded folder
1. Start server by `java -jar OppenheimerProjectDev.jar`
1. Open another terminal, go to automation project folder

### Run all test cases

`python3 -m robot ./`

### Run all test case for {bookeeper|clerks|govenor} suites

`python3 -m robot ./tests/{bookeeper|clerks|govenor}`

- bookeeper:
`python3 -m robot ./tests/bookeeper`

- clerks:
`python3 -m robot ./tests/clerks`

- govenor:
`python3 -m robot ./tests/clerks`

## Improvement

Can use docker to container all test and app so we don't need to setup environment
