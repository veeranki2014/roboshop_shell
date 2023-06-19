source common.sh
component=cart


curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>${log_file}

echo -e "${colour} Install NodeJS ${nocolour}"
yum install nodejs -y &>>${log_file}

echo -e "${colour} Add App user ${nocolour}"
useradd roboshop &>>${log_file}

echo -e "${colour} Remove Old Code ${nocolour}"
rm -rf ${app_path}/* &>>${log_file}
mkdir ${app_path} &>>${log_file}

echo -e "${colour} Download App Code ${nocolour}"
curl -o /tmp/${cart}.zip https://roboshop-artifacts.s3.amazonaws.com/${cart}.zip &>>${log_file}

echo -e "${colour} Extract the App Code ${nocolour}"
cd ${app_path}
unzip /tmp/${cart}.zip &>>${log_file}

echo -e "${colour} Install NodeJS ${nocolour}"
cd ${app_path}
npm install &>>${log_file}

echo -e "${colour}  Create SystemD ${cart} Service ${nocolour}"
cp /home/centos/roboshop_shell/${cart}.service /etc/systemd/system/${cart}.service &>>${log_file}

echo -e "${colour}  Enable and restart catalogue ${nocolour}"
systemctl daemon-reload &>>${log_file}
systemctl enable ${cart} &>>${log_file}
systemctl restart ${cart} &>>${log_file}








