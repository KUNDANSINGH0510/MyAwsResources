sudo su

AWS-CLI Instllation
---------------------
python --version
sudo mkdir workspace
cd workspace
sudo curl "https://s3.amazonaws.com/aws-cli/awscli-bundle.zip" -o "awscli-bundle.zip"
sudo yum -y install unzip
sudo unzip awscli-bundle.zip
sudo ./awscli-bundle/install -i /usr/local/aws -b /usr/local/bin/aws
export PATH=$PATH:/usr/local/bin
aws --version
sudo rm -rf awscli-bundle.zip
sudo rm -rf awscli-bundle/

aws s3 cp .htaccess s3://testing-poc-src/ddm-resource/ddm/	(Copy file to S3 bucket)
aws s3 sync ./ s3://testing-poc-src/ddm-resource/ddm/	(Copy all files of directory to S3 bucket)
aws s3 cp s3://testing-poc-src/ddm-resource/ddm/jboss-eap-7.2.0.zip jboss-eap-7.2.0	(Copy from S3 bucket)
aws s3 cp s3://testing-poc-src/ddm-resource/ddm/* /var/www/html		(Copy all files of s3 bucket folder to a particular location)
unzip jboss-eap-7.2.0.zip
rm -rf jboss-eap-7.2.0.zip
rm -i , rm *, rm -r *	(To delete all files and folders, subfolders from a directory)
ls -a
cp * /var/www/html	(From a directory, copy all files to a partiular location

chmod a+x standalone.sh	(To make a file executable)
./standalone.sh -Djboss.bind.address=10.12.8.233 -c standalone-full.xml		(Deploy jboss application on EC2)
curl -v http://10.12.8.233:8080

cat file.txt	(Read a file on linux)
vi file.txt		(open a file to edit on linux)
Esc + :q (Exit without save)
Esc + :wq	(Exit with saving file)
i (Insert into file or write into file)

yum -y update
sudo yum install java-1.8.0-openjdk
To uninstall openjdk ->		rmp -qa | grep openjdk | xargs yum -y remove

sudo yum install nodejs
node -v
npm -v
npm install -g @angular/latest
ng --version
ng new hellow-angular (New angular application)
ng serve

yum -y update
yum install httpd
systemctl start httpd
systemctl enable httpd
systemctl status httpd
systemctl restart httpd

yum install firewalld
systemctl start firewalld
systemctl enable firewalld
systemctl status firewalld
sudo firewall-cmd --zone=public --add-port=80/tcp --permanent
sudo firewall-cmd --zone=public --add-port=8080/tcp --permanent
sudo firewall-cmd --zone=public --add-port=443/tcp --permanent
sudo firewall-cmd --zone=public --add-port=8443/tcp --permanent
sudo firewall-cmd --reload
systemctl restart firewalld

sudo vim /etc/hosts
127.0.0.1 ip-10-12-8-89.post.bpgnet.net localhost localhost.localdomain localhost4 localhost4.localdomain4

git init
git add .
git commit -m "Initial Comment"
git push -u https://git-codecommit.eu-west-1.amazonaws.com/v1/repos/RepositoryName -all master

Install Code Deploy Agent on EC2 Instance
------------------------------------------
https://docs.aws.amazon.com/codebuild/latest/userguide/sample-codedeploy.html
https://baihaqie.com/blog/how-reinstall-codedeploy-agent-at-ubuntu-18.04
sudo service codedeploy-agent status
https://docs.amazon.com/codebuild/latest/userguide/instances-view-details.html

cd /opt/codedeploy-agent/deployment-root	-> cd d72cb0as-3d7c-5a4c-a786-ec34mfj7c7  ->  cd d-5XHND7HD		->  cd deployment-archive
(delete all)
cd /tmp (delete application.ear)

Cron Jobs
----------
yum install cronie
systemctl enable crond.service
systemctl start crond.service
crontab -e
0 3 * * * root /usr/bin/workspace/jboss-eap-7.2.0/jboss-eap-7.2/scripts/scrptname.sh

lsblk
yum install gdisk
sudo growpart /dev/xvda2
sudo xfs_growfs /dev/xvda2
yum install cloud-guest-utils

ping vlds648.netpost	->	10.123.178.32
yum install telnet

jdbc:oracle:thin:@//rds-mail-ds-euwe04-a2-001-cu2kuqoyaedy.eu-west-1.rds.amazonaws.com:1521/DMOMIG

Install Docker- https://www.cyberciti.biz/faq/install-use-setup-docker-on-rhel7-centos7-linux/

Secret of AWS Secrets Manager
-------------------------------
aws secretsmanager get-secret-value --region eu-west-1 --secret-id MyTestDatabaseSecret
{
  "ARN": "arn:aws:secretsmanager:us-west-2:123456789012:secret:MyTestDatabaseSecret-a1b2c3",
  "Name": "MyTestDatabaseSecret",
  "VersionId": "EXAMPLE1-90ab-cdef-fedc-ba987EXAMPLE",
  "SecretString": "{\n  \"username\":\"david\",\n  \"password\":\"MyDBPassword\"\n}\n",
  "CreatedDate": 1523477145.713
}

aws secretsmanager get-secret-value --region eu-west-1 --secret-id MyTestDatabaseSecret | jq --raw-output .SecretString | jq -r ."password"
Output - MyDBPassword

DBUSER = $(aws secretsmanager get-secret-value --region eu-west-1 --secret-id MyTestDatabaseSecret | jq --raw-output .SecretString | jq -r ."DBUSER")
DBPASSWORD = $(aws secretsmanager get-secret-value --region eu-west-1 --secret-id MyTestDatabaseSecret | jq --raw-output .SecretString | jq -r ."DBPASSWORD")
DB = $(aws secretsmanager get-secret-value --region eu-west-1 --secret-id MyTestDatabaseSecret | jq --raw-output .SecretString | jq -r ."DB")

In Secret Manger- Secret is : MyTestDatabaseSecret
Key				Value
DBUSER			UserName
DBPASSWORD		ThisIsMyPassword
DB				rdi-mail-ds-euwe04-a2-001-cu2kuqoyaedy.eu-west-1.rds.amazonaws.com:1521/SSID

sqlplus -s $DBUSER/$DBPASSWORD@$DB

To install Jasonquery on Linux
-------------------------------
yum install -y rpm wget
wget -o jq https://github.com/stedolan/jq/releases/download/jq-1.6/jq-linux64
chmod +x ./jq
cp jq /usr/bin

