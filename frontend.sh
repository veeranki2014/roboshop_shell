
echo -e "\e[34m Installing Nginx Server \e[0m"
yum install nginx -y

echo -e "\e[34m Removing Old App Files \e[0m"
rm -rf /usr/share/nginx/html/*

echo -e "\e[34m Downloading Frontend Content \e[0m"
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend.zip

echo -e "\e[34m Extracting Frontend Content \e[0m"
cd /usr/share/nginx/html
unzip /tmp/frontend.zip
## we need to copy config file

echo -e "\e[34m Starting Nginx Servers \e[0m"
systemctl enable nginx
systemctl start nginx

