echo -e "\e[34m Setup Mongodb Repo \e[0m"
cp mongodb.repo /etc/yum.repos.d/mongo.repo &>>/tmp/roboshop.log

echo -e "\e[34m Install MongoDB \e[0m"
yum install mongodb-org -y &>>/tmp/roboshop.log

echo -e "\e[34m Update Listen address \e[0m"
sed -i 's/127.0.0.1/0.0.0.0/g' /etc/mongod.conf &>>/tmp/roboshop.log
##Update listen address from 127.0.0.1 to 0.0.0.0 in /etc/mongod.conf

echo -e "\e[34m Start and Enable MongoDB Service \e[0m"
systemctl enable mongod &>>/tmp/roboshop.log
systemctl start mongod &>>/tmp/roboshop.log
