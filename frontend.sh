
echo -e "\e[33m Installing Nginx Server \e[0m"
yum install nginx -y &>>/tmp/roboshop.log

echo -e "\e[33m Removing Old App Files \e[0m"
rm -rf /usr/share/nginx/html/* &>>/tmp/roboshop.log

echo -e "\e[33m Downloading Frontend Content \e[0m"
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend.zip &>>/tmp/roboshop.log

echo -e "\e[33m Extracting Frontend Content \e[0m"
cd /usr/share/nginx/html
unzip /tmp/frontend.zip &>>/tmp/roboshop.log
## we need to copy config file
# vim /etc/nginx/default.d/roboshop.conf
echo -e "\e[33m update Nginx Reverse Proxy \e[0m"
cp /home/centos/roboshop_shell/roboshop.conf /etc/nginx/default.d/roboshop.conf &>>/tmp/roboshop.log

echo -e "\e[33m Starting Nginx Servers \e[0m"
systemctl enable nginx &>>/tmp/roboshop.log
systemctl start nginx &>>/tmp/roboshop.log

