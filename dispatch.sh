echo -e "\e[33m Install GoLang \e[0m"
yum install golang -y

echo -e "\e[33m Create App user \e[0m"
useradd roboshop

echo -e "\e[33m Create App directory \e[0m"
rm -rf /app*
mkdir /app


echo -e "\e[33m Download App Code \e[0m"
curl -L -o /tmp/dispatch.zip https://roboshop-artifacts.s3.amazonaws.com/dispatch.zip
cd /app
unzip /tmp/dispatch.zip

echo -e "\e[33m Build App Code \e[0m"
cd /app
go mod init dispatch
go get
go build

echo -e "\e[33m Restart Dispatch Services \e[0m"
systemctl daemon-reload
systemctl enable dispatch
systemctl start dispatch