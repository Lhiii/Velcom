# 项目介绍
---

## 项目功能简介

<p>&emsp;&emsp;提供留言功能。本设计在Linux环境下，采用Asp，llS等技术来编辑网页，并运用ODBC技术把数据库和动态网页相关联，开发了基于校园网上留言板管理系统。</p>

## 程序运行方式

### <li><b>大致流程</b>
<p>&emsp;&emsp;使用bash ./start.sh实现自动化步骤。</p>
<p>&emsp;&emsp;运行根目录下start.sh文件，实现以下操作：运行mysql容器，并且宿主机能够配置和访问mysql；宿主机再次运行flask容器，由于flask容器需要连接mysql容器；完成两个容器之间的通信。</p>
 
### <li><b>具体流程</b>
<p>&emsp;&emsp;根据velcom的创建连接数据库的bash脚本，本实验在此脚本上做了一些改动，在docker run命令加入了—network，在此之前需要先用指令：docker network create velcom_net创建网络，之后加入velcom_net，指令如下：</p>

 ```
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
 ```

<p>&emsp;&emsp;本实验所用的MariaDB版本是10.6.5。在上述的基础上，docker运行flask容器指令如下：</p>

 ```
 contaienr_name="velcom-nginx"
docker build -t velcom .
docker container stop ${contaienr_name}
docker container rm ${contaienr_name}
sleep 1
docker run --name ${contaienr_name} -d -p 18080:80 velcom
 ```
 
<p>&emsp;&emsp;因为flask连接数据库用的是flask内置的连接数据库的框架，在flask容器里具体连接MariaDB容器指令如下：</p>

 ```
 mysql -u root -h "127.0.0.1" -P 3306 -p${db_rootpass} -e "
 ```
 

<p>&emsp;&emsp;在flask运行之前，提前创建好数据库QA，指令如下：</p>

 ```
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
```
 
<p>&emsp;&emsp;当以上步骤都完成之后，就可以运行flask的web应用了。</p>


## 项目截图
 
### <li>程序运行截图
 
<center>
  <img src="screenShot_img\1.png" width="400" height=""> 
  </center>
<center>
  <img src="screenShot_img\2.png" width="400" height=""> 
  </center>

<center>
  <img src="screenShot_img\3.png" width="400" height=""> 
  </center>

<center>
  <img src="screenShot_img\4.png" width="400" height=""> 
  </center>
 
### <li>数据库中留言信息截图
 
<center>
  <img src="screenShot_img\5.png" width="400" height=""> 
  </center>

## 小组项目心得体会
 
<p>&emsp;&emsp;本项目论述了一个基于云南大学校园的网上留言板管理系统，重点讨论了开发系统的工具，开发环境的配置，后台数据库连接等技术。本系统只实现了留言板最基本的功能，该留言板管理系统简洁实用，而且界面友好，为教师和学生的交流提供了一个广阔的空间和平台。还有很多具体的功能还未实现，如置顶功能，留言板回复讨论功能等。</p>


