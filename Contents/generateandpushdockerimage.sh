#!/bin/bash

#	Example run for this file
#	./generateandpushdockerimage.sh s3:/bucket/path/command_to_execute.sh aws_ecr_repo_url image_tag

#	one sample run for this file
#	./generateandpushdockerimage.sh s3:/s3b-mail-repository/containerjobs/command_to_execute.sh 012345678901.dkr.ecr.eu-west-1.amazonwas.com ecr-mail-np-sqlplus-01

if  [ "$#" -ne 3 ]; then
	echo "Pass 3 params properly. sample command:"
	echo "./generateandpushdockerimage.sh s3:/bucket/path/command_to_execute.sh aws_ecr_repo_url image_tag"
	exit 1;
fi

S3_SCRIPT_PATH=$1
ECR_REPO_PATH=$2
IMAGE_NAME=$3

echo "s3 path for this Job's script = " $S3_SCRIPT_PATH
echo "ECR Repo URL = " $ECR_REPO_PATH
echo "Image tag that we want to give = " $IMAGE_NAME

DEST_IMAGE_TAG = "$ECR_REPO_PATH/$IMAGE_NAME:latest"
echo "Complete destination image tag = " $DEST_IMAGE_TAG

aws --version
if [ ! $? ]; then
	echo 'AWS CLI is not installed' ;
	exit 1;
fi

docker --version
if [ ! $? ]; then
	echo 'Docker is not installed' ;
	exit 1;
fi

docker build --build-arg S3_SCRIPT_PATH=$S3_SCRIPT_PATH -t $IMAGE_NAME .
if [ ! $? ]; then
	echo 'Image build failed' ;
	exit 1;
fi

echo 'Docker build executed.. '

docker tag $IMAGE_NAME $DEST_IMAGE_TAG
if [ ! $? ]; then
	echo 'Image tagging failed' ;
	exit 1;
fi

echo 'Docker tag executed.. ' ;

dockerlogin=$(aws ecr get-login --no-include-email --region eu-west-1)
dockerlogin=$(dockerlogin/https/' ')
$dockerlogin
if [ ! $? ]; then
	echo 'Login failed' ;
	exit 1;
fi

echo 'ECR Login executed .. ' ;

docker push $DEST_IMAGE_TAG
if [ ! $? ]; then
	echo 'Image pushed to ECR Repository failed' ;
	exit 1;
fi

echo 'Docker push executed .. ' ;