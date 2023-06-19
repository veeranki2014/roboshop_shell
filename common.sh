colour="\e[33m"
nocolour="${\e[0m]}"
log_file=/tmp/roboshop.log
app_path=/app

nodejs(){
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

}

mongo_schema_setup(){
  echo -e "\e[33m  Create SystemD catalogue Service \e[0m"
  cp /home/centos/roboshop_shell/mongodb.repo /etc/yum.repos.d/mongod.repo &>>/tmp/roboshop.log

  echo -e "\e[33m  Create SystemD catalogue Service \e[0m"
  yum install mongodb-org-shell -y &>>/tmp/roboshop.log &>>/tmp/roboshop.log

  echo -e "\e[33m  Create SystemD catalogue Service \e[0m"
  mongo --host mongodb-dev.veerankitek.com </app/schema/user.js &>>/tmp/roboshop.log
}
