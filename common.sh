colour="\e[33m"
nocolour="\e[0m"
log_file=/tmp/roboshop.log
app_path=/app

app_presetup(){
  echo -e "${colour} Add App user ${nocolour}"
  useradd roboshop &>>${log_file}
  echo $?

  echo -e "${colour} Remove Old Code ${nocolour}"
  rm -rf ${app_path}/* &>>${log_file}
  mkdir ${app_path} &>>${log_file}
  echo $?

  echo -e "${colour} Download App Code ${nocolour}"
  curl -o /tmp/$catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/$catalogue.zip &>>${log_file}
  echo $?

  echo -e "${colour} Extract the App Code ${nocolour}"
  cd ${app_path}
  unzip /tmp/${component}.zip &>>${log_file}
  echo $?

}

systemd_setup(){
  echo -e "${colour}  Create SystemD ${component} Service ${nocolour}"
  cp /home/centos/roboshop_shell/$catalogue.service /etc/systemd/system/${component}.service &>>${log_file}
  echo $?

  echo -e "${colour}  Enable and restart ${component} ${nocolour}"
  systemctl daemon-reload &>>${log_file}
  systemctl enable ${component} &>>${log_file}
  systemctl restart ${component} &>>${log_file}
  echo $?
}

nodejs(){
  echo -e "${colour} Setup NodeJS Repos ${nocolour}"
  curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>/tmp/roboshop.log
  echo $?

  echo -e "${colour} Install NodeJS ${nocolour}"
  yum install nodejs -y &>>${log_file}
  echo $?

 app_presetup

  echo -e "${colour} Install NodeJS Dependencies${nocolour}"
  cd ${app_path}
  npm install &>>${log_file}
  echo $?

  systemd_setup

}

mongo_schema_setup(){
  echo -e "\e[33m  Create SystemD catalogue Service \e[0m"
  cp /home/centos/roboshop_shell/mongodb.repo /etc/yum.repos.d/mongod.repo &>>/tmp/roboshop.log
  echo $?

  echo -e "\e[33m  Create SystemD catalogue Service \e[0m"
  yum install mongodb-org-shell -y &>>/tmp/roboshop.log &>>/tmp/roboshop.log
  echo $?

  echo -e "\e[33m  Create SystemD catalogue Service \e[0m"
  mongo --host mongodb-dev.veerankitek.com </app/schema/user.js &>>/tmp/roboshop.log
  echo $?
}

maven(){
  echo -e "${colour}  Install Maven ${nocolour}"
  yum install maven -y  &>>${log_file}
  echo $?

  app_presetup

  echo -e "${colour} Build the code and target  ${nocolour}"
  cd ${app_path}
  mvn clean package &>>${log_file}
  mv target/${component}-1.0.jar ${component}.jar &>>${log_file}
  echo $?

  echo -e "${colour} Copy ${component} service  ${nocolour}"
  ##copy ${component} service
  cp /home/centos/roboshop_shell/${component}.service /etc/systemd/system/${component}.service
  echo $?

  echo -e "${colour} Install MYSQL  ${nocolour}"
  yum install mysql -y  &>>${log_file}
  echo $?

  echo -e "${colour}  Load Mysql schema ${nocolour}"
  mysql -h mysql-dev.veerankitek.com -uroot -pRoboShop@1 < ${app_path}/schema/${component}.sql  &>>${log_file}
  echo $?

  echo -e "${colour} Restart ${component} services again  ${nocolour}"
  systemctl daemon-reload &>>${log_file}
  systemctl enable ${component} &>>${log_file}
  systemctl restart ${component}  &>>${log_file}
  echo $?
}

python(){

  echo -e "${colour} Install Python ${nocolour}"
  yum install python36 gcc python3-devel -y &>>${log_file}
  echo $?

  app_presetup

  echo -e "${colour} install Python  ${nocolour}"
  cd /app
  pip3.6 install -r requirements.txt  &>>${log_file}
  echo $?

  systemd_setup
}
