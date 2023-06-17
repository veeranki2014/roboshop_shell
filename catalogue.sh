echo -e "\e[34m Setup NodeJS Repos \e[0m"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>/tmp/roboshop.log

echo -e "\e[34m Install NodeJS \e[0m"
yum install nodejs -y &>>/tmp/roboshop.log

echo -e "\e[34m Add App user \e[0m"
useradd roboshop &>>/tmp/roboshop.log

echo -e "\e[34m Remove Old Code \e[0m"
mkdir /app &>>/tmp/roboshop.log

echo -e "\e[34m Download App Code \e[0m"
curl -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue.zip &>>/tmp/roboshop.log

echo -e "\e[34m I \e[0m"
cd /app
unzip /tmp/catalogue.zip &>>/tmp/roboshop.log
cd /app

echo -e "\e[34m Install NodeJS \e[0m"
npm install &>>/tmp/roboshop.log