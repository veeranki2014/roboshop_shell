echo -e "\e[33m  Install Maven \e[0m"
yum install maven -y  &>>/tmp/roboshop.log

echo -e "\e[33m  Create App User \e[0m"
useradd roboshop  &>>/tmp/roboshop.log

echo -e "\e[33m Create App Directory  \e[0m"
mkdir /app  &>>/tmp/roboshop.log

echo -e "\e[33m  Copy APP Code \e[0m"
curl -L -o /tmp/shipping.zip https://roboshop-artifacts.s3.amazonaws.com/shipping.zip &>>/tmp/roboshop.log
cd /app
unzip /tmp/shipping.zip &>>/tmp/roboshop.log

echo -e "\e[33m Build the code and target  \e[0m"
cd /app
mvn clean package &>>/tmp/roboshop.log
mv target/shipping-1.0.jar shipping.jar &>>/tmp/roboshop.log

echo -e "\e[33m Copy Shipping service  \e[0m"
##copy shipping service
cp /home/centos/roboshop_shell/shipping.service /etc/systemd/system/shipping.service

echo -e "\e[33m Install MYSQL  \e[0m"
yum install mysql -y  &>>/tmp/roboshop.log

echo -e "\e[33m  Load Mysql schema \e[0m"
mysql -h mysql-dev.veerankitek.com -uroot -pRoboShop@1 < /app/schema/shipping.sql  &>>/tmp/roboshop.log

echo -e "\e[33m Restart shipping services again  \e[0m"
systemctl daemon-reload &>>/tmp/roboshop.log
systemctl enable shipping &>>/tmp/roboshop.log
systemctl restart shipping  &>>/tmp/roboshop.log