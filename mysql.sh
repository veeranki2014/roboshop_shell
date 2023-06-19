
echo -e "\e[33m Disable MySQL Module\e[0m"
yum module disable mysql -y  &>>/tmp/roboshop.log

echo -e "\e[33m Create Mysql Repo \e[0m"
# cp mysql.repo
cp /home/centos/roboshop_shell/mysql.repo /etc/yum.repos.d/mysql.repo &>>/tmp/roboshop.log

echo -e "\e[33m Installation MySQL\e[0m"
yum install mysql-community-server -y &>>/tmp/roboshop.log

echo -e "\e[33m Restart the mysql\e[0m"
systemctl enable mysqld &>>/tmp/roboshop.log
systemctl restart mysqld &>>/tmp/roboshop.log

echo -e "\e[33m Set Root password\e[0m"
mysql_secure_installation --set-root-pass RoboShop@1 &>>/tmp/roboshop.log