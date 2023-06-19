
echo -e "\e[33m Install Python \e[0m"
yum install python36 gcc python3-devel -y &>>/tmp/roboshop.log

echo -e "\e[33m Crate App User\e[0m"
useradd roboshop  &>>/tmp/roboshop.log

echo -e "\e[33m Create App \e[0m"
rm -rf /app* &>>/tmp/roboshop.log
mkdir /app  &>>/tmp/roboshop.log

echo -e "\e[33m Copy and Unzip App code\e[0m"
curl -L -o /tmp/payment.zip https://roboshop-artifacts.s3.amazonaws.com/payment.zip &>>/tmp/roboshop.log
cd /app
unzip /tmp/payment.zip  &>>/tmp/roboshop.log

echo -e "\e[33m install Python  \e[0m"
cd /app
pip3.6 install -r requirements.txt  &>>/tmp/roboshop.log

echo -e "\e[33m Load Payment Service \e[0m"
cp /home/centos/roboshop_shell/payment.service /etc/systemd/system/payment.service  &>>/tmp/roboshop.log

echo -e "\e[33m Restart Payment Service\e[0m"
systemctl daemon-reload &>>/tmp/roboshop.log
systemctl enable payment  &>>/tmp/roboshop.log
systemctl start payment &>>/tmp/roboshop.log