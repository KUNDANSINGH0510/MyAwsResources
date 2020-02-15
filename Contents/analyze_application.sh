#!/bin/bash

# set -x

# sqlplus ABO_OWNER/user_password@rdi-mail-gp1-01-cu2kyqoyaedy.eu-west-1-rds.amazonaws.com:1521/DMODEV1

./analyze.sh -samplesize 25 -buckets AUTO -u ABO_OWNER ABO_OWNER/user_password
if [ ! $? ]; then
	exit 1;
fi