source common.sh
component=catalogue

echo -e "${colour} Setup NodeJS Repos ${nocolour}"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>/tmp/roboshop.log

echo -e "${colour} Install NodeJS ${nocolour}"
yum install nodejs -y &>>${log_file}

echo -e "${colour} Add App user ${nocolour}"
useradd roboshop &>>${log_file}

echo -e "${colour} Remove Old Code ${nocolour}"
rm -rf ${app_path}/* &>>${log_file}
mkdir ${app_path} &>>${log_file}

echo -e "${colour} Download App Code ${nocolour}"
curl -o /tmp/$catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/$catalogue.zip &>>${log_file}

echo -e "${colour} Extract the App Code ${nocolour}"
cd ${app_path}
unzip /tmp/$catalogue.zip &>>${log_file}

echo -e "${colour} Install NodeJS ${nocolour}"
cd ${app_path}
npm install &>>${log_file}

echo -e "${colour}  Create SystemD $catalogue Service ${nocolour}"
cp /home/centos/roboshop_shell/$catalogue.service /etc/systemd/system/$catalogue.service &>>${log_file}

echo -e "${colour}  Enable and restart $catalogue ${nocolour}"
systemctl daemon-reload &>>${log_file}
systemctl enable $catalogue &>>${log_file}
systemctl restart $catalogue &>>${log_file}

echo -e "${colour}  Create SystemD $catalogue Service ${nocolour}"
cp /home/centos/roboshop_shell/mongodb.repo /etc/yum.repos.d/mongod.repo &>>${log_file}

echo -e "${colour}  Create SystemD $catalogue Service ${nocolour}"
yum install mongodb-org-shell -y &>>${log_file} &>>${log_file}

echo -e "${colour}  Create SystemD $catalogue Service ${nocolour}"
mongo --host mongodb-dev.veerankitek.com <${app_path}/schema/$catalogue.js &>>${log_file}






