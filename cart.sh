echo -e "\e[33m Setup NodeJS Repos \e[0m"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>/tmp/roboshop.log

echo -e "\e[33m Install NodeJS \e[0m"
yum install nodejs -y &>>/tmp/roboshop.log

echo -e "\e[33m Add App user \e[0m"
useradd roboshop &>>/tmp/roboshop.log

echo -e "\e[33m Remove Old Code \e[0m"
rm -rf /app/* &>>/tmp/roboshop.log
mkdir /app &>>/tmp/roboshop.log

echo -e "\e[33m Download App Code \e[0m"
curl -o /tmp/cart.zip https://roboshop-artifacts.s3.amazonaws.com/cart.zip &>>/tmp/roboshop.log

echo -e "\e[33m Extract the App Code \e[0m"
cd /app
unzip /tmp/cart.zip &>>/tmp/roboshop.log

echo -e "\e[33m Install NodeJS \e[0m"
cd /app
npm install &>>/tmp/roboshop.log

echo -e "\e[33m  Create SystemD cart Service \e[0m"
cp /home/centos/roboshop_shell/cart.service /etc/systemd/system/cart.service &>>/tmp/roboshop.log

echo -e "\e[33m  Enable and restart catalogue \e[0m"
systemctl daemon-reload &>>/tmp/roboshop.log
systemctl enable cart &>>/tmp/roboshop.log
systemctl restart cart &>>/tmp/roboshop.log

echo -e "\e[33m  Create SystemD cart Service \e[0m"
cp /home/centos/roboshop_shell/mongodb.repo /etc/yum.repos.d/mongod.repo &>>/tmp/roboshop.log

echo -e "\e[33m  Create SystemD catalogue Service \e[0m"
yum install mongodb-org-shell -y &>>/tmp/roboshop.log &>>/tmp/roboshop.log

echo -e "\e[33m  Create SystemD catalogue Service \e[0m"
mongo --host mongodb-dev.veerankitek.com </app/schema/cart.js &>>/tmp/roboshop.log






