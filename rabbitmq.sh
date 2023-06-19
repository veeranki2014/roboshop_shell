echo -e "\e[33m Configure YUM Repos by vendor \e[0m"
curl -s https://packagecloud.io/install/repositories/rabbitmq/erlang/script.rpm.sh | bash &>>/tmp/roboshop.log

echo -e "\e[33m Configure YUM Repos  \e[0m"
curl -s https://packagecloud.io/install/repositories/rabbitmq/rabbitmq-server/script.rpm.sh | bash  &>>/tmp/roboshop.log

echo -e "\e[33m Install rabbitmq \e[0m"
yum install rabbitmq-server -y  &>>/tmp/roboshop.log

echo -e "\e[33m Restart the Server \e[0m"
systemctl enable rabbitmq-server  &>>/tmp/roboshop.log
systemctl restart rabbitmq-server   &>>/tmp/roboshop.log

echo -e "\e[33m Reset Passwords \e[0m"
rabbitmqctl add_user roboshop roboshop123 &>>/tmp/roboshop.log
rabbitmqctl set_permissions -p / roboshop ".*" ".*" ".*"  &>>/tmp/roboshop.log

