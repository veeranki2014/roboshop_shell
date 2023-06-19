source common.sh
component=catalogue

nodejs

echo -e "${colour}  Create SystemD $catalogue Service ${nocolour}"
cp /home/centos/roboshop_shell/mongodb.repo /etc/yum.repos.d/mongod.repo &>>${log_file}

echo -e "${colour}  Create SystemD $catalogue Service ${nocolour}"
yum install mongodb-org-shell -y &>>${log_file} &>>${log_file}

echo -e "${colour}  Create SystemD $catalogue Service ${nocolour}"
mongo --host mongodb-dev.veerankitek.com <${app_path}/schema/$catalogue.js &>>${log_file}






