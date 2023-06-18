echo -e "\e[31m Setup NodeJS Repos \e[0m"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>/tmp/roboshop.log

echo -e "\e[31m Install NodeJS \e[0m"
yum install nodejs -y &>>/tmp/roboshop.log

echo -e "\e[31m Add App user \e[0m"
useradd roboshop &>>/tmp/roboshop.log

echo -e "\e[31m Remove Old Code \e[0m"
rm -rf /app/* &>>/tmp/roboshop.log
mkdir /app &>>/tmp/roboshop.log

echo -e "\e[31m Download App Code \e[0m"
curl -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue.zip &>>/tmp/roboshop.log

echo -e "\e[31m Extract the App Code \e[0m"
cd /app
unzip /tmp/catalogue.zip &>>/tmp/roboshop.log

echo -e "\e[31m Install NodeJS \e[0m"
cd /app
npm install &>>/tmp/roboshop.log

echo -e "\e[31m  Create SystemD catalogue Service \e[0m"
cp /home/centos/roboshop_shell/catalogue.service /etc/systemd/system/catalogue.service &>>/tmp/roboshop.log

echo -e "\e[31m  Enable and restart catalogue \e[0m"
systemctl daemon-reload &>>/tmp/roboshop.log
systemctl enable catalogue &>>/tmp/roboshop.log
systemctl restart catalogue &>>/tmp/roboshop.log

echo -e "\e[31m  Create SystemD catalogue Service \e[0m"
cp /home/centos/roboshop_shell/mongodb.repo /etc/yum.repos.d/mongod.repo &>>/tmp/roboshop.log

echo -e "\e[31m  Create SystemD catalogue Service \e[0m"
yum install mongodb-org-shell -y &>>/tmp/roboshop.log &>>/tmp/roboshop.log

echo -e "\e[31m  Create SystemD catalogue Service \e[0m"
mongo --host mongodb-dev.veerankitek.com </app/schema/catalogue.js &>>/tmp/roboshop.log






