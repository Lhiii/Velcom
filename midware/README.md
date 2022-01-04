1. 项目功能简介
	留言：提供留言功能。本设计在Linux环境下，采用Asp，llS等技术来编辑网页，并运用ODBC技术把数据库和动态网页相关联，开发了基于校园网上留言板管理系统。
2. 程序运行方式
	大致流程
使用bash ./start.sh实现自动化步骤。
运行根目录下start.sh文件，实现以下操作：运行mysql容器，并且宿主机能够配置和访问mysql；宿主机再次运行flask容器，由于flask容器需要连接mysql容器；完成两个容器之间的通信。
	具体流程
根据velcom的创建连接数据库的bash脚本，本实验在此脚本上做了一些改动，在docker run命令加入了—network，在此之前需要先用指令：docker network create velcom_net创建网络，之后加入velcom_net，指令如下：
docker network rm velcom_net
docker network create velcom_net
contaienr_name="velcom-midware"
db_host_name="velcom-database"
docker run \
    --name ${contaienr_name} \
    -d \
    -p 5000:5000 \
    --network velcom_net \
    --env DB_HOST=${db_host_name} \
    ${contaienr_name}
本实验所用的MariaDB版本是10.6.5。在上述的基础上，docker运行flask容器指令如下：
contaienr_name="velcom-nginx"
docker build -t velcom .
docker container stop ${contaienr_name}
docker container rm ${contaienr_name}
sleep 1
docker run --name ${contaienr_name} -d -p 18080:80 velcom
因为flask连接数据库用的是flask内置的连接数据库的框架，在flask容器里具体连接MariaDB容器指令如下：
mysql -u root -h "127.0.0.1" -P 3306 -p${db_rootpass} -e "
在flask运行之前，提前创建好数据库QA，指令如下：
contaienr_name="velcom-database"
db_username="velcom"
db_userpass="velcom_alksdjflkakjei"
db_rootpass="velcom_rootlkdjalienfklae"
db_name="velcom"
table_msg_name="velcom_msg"
docker run \
    --detach \
    --name ${contaienr_name} \
    --env MARIADB_USER=${db_username} \
    --env MARIADB_PASSWORD=${db_userpass} \
    --env MARIADB_ROOT_PASSWORD=${db_rootpass} \
    -p 3306:3306 \
    --network velcom_net \
    mariadb:latest
sudo apt install -y mysql-client
mysql -u root -h "127.0.0.1" -P 3306 -p${db_rootpass} -e "
CREATE DATABASE ${db_name};
 USE ${db_name};
 CREATE TABLE IF NOT EXISTS ${table_msg_name}
当以上步骤都完成之后，就可以运行flask的web应用了。
3.项目截图
	程序运行截图
    
	数据库中留言信息截图：
 
 
