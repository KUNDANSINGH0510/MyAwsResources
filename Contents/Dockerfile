from amazonlinux:latest

ARG S3_SCRIPT_PATH

run yum -y update
run yum -y install unzip aws-cli
run yum -y install java-1.8.0-openjdk

run yum install -y rpm wget libaio
run wget https://download.oracle.com/otn_software/linux/instantclient/oracle-instantclient-basic-linuxx64.rpm
run wget https://download.oracle.com/otn_software/linux/instantclient/oracle-instantclient-sqlplus-linuxx64.rpm
run rpm -ivh oracle-instantclient-basic*.rpm oracle-instantclient-sqlplus*.rpm

run echo $S3_SCRIPT_PATH
run aws s3 cp $S3_SCRIPT_PATH command_to_execute.sh
run sed -i 's/\r$//' command_to_execute.sh
run chmod -v +x command_to_execute.sh

ENTRYPOINT ["bash","/command_to_execute.sh"]