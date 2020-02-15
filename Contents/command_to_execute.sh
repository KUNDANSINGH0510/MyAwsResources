#!/bin/bash

# Example run for this file:
# command_to_execute.sh

# This file is introduced to create complete independence from all the hardcoded paths
# this layer will allow us to create any number of jobs with the same image to run various jobs
# Precondition to run this file
### AWS CLI installed container
### zip file with one executejob.sh file, which will have the sequence of job execution commands
### S3_SCRIPT_PATH environment variable defined (In AWS Batch, vale of variable will be the path of zip folder)

if [ $S3_SCRIPT_PATH -eq '' ]; then
	echo 'S3_SCRIPT_PATH env variable is not defined.' ;
	exit 1;
fi
echo $S3_SCRIPT_PATH

aws --version
if [ ! $? ]; then
	echo 'AWS CLI is not installed' ;
	exit 1;
fi

aws s3 cp $S3_SCRIPT_PATH scripts.zip
if [ ! $? ]; then
	echo 'Download from S3 failed.' ;
	exit 1;
fi

unzip scripts.zip -d scripts
rm -rf scripts.zip

cd scripts
sed -i 's/\r$//' executejob.sh

chmod -v +x ./*

bash executejob.sh
if [ ! $? ]; then
	echo 'Job execution failed.' ;
	exit 1;
fi

echo "Script executed successfully";