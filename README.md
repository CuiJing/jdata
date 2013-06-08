jdata
=====
Jdata(http://jdata..domain/) 是一款对日志统计结果数据（事实表）进行存储、查询和展示的服务。
Jdata的角色，在数据分析所处的位置：

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;源数据（日志）   ---->  （日志）收集系统   -->   计算系统（Hadoop MapReduce等）  --->  对统计结果的保存、查询（Jdata）



****Requriements****
python2.7
 -django
 -simplejson
 -MySQLdb
 -memcache
 -dateutil


****安装 & 配置****

1, 先安装软件： Nginx, Memcached, MySQL Server

2, 安装python2.7，并安装模块：django  simplejson  MySQLdb  memcache  dateutil

3, 配置  ($JDATABASE为jdata根目录）

  3.0 中心数据库初始化：  $JDATABASE/init_jdata.sql  把该文件导入到jdata数据库中
  3.1 中心数据库连接配置：$JDATABASE/settings.py 文件中的DMC_MASTER_W 和 DMC_MASTER_R
  3.2 python路径 和 Memcached连接配置： $JDATABASE/admin.sh 文件中的PYTHON27 和 MEMCACHED 
  3.3 所有供Jdata使用的MySQL集群连接配置： 中心数据库中的表jdata_dmc_cluster，字段write和reader分别指向写/读连接串
        格式：user/password@host:port/db
        例子：jdata/jdata@192.168.9.152:3306/jdata2

  3.4 nginx的conf配置，请参考 $JDATABASE/nginx_jdata.conf 配置文件，首先将其中的servername更改为自己的domain。
        更改完之后，在现有的nginx.conf中include 该配置文件即可。


4, 启动关闭
   
   启动关闭fastcgi
   $JDATABASE/admin.sh start|stop|restart|test  

   启动关闭nginx（http）

5、使用

   访问http://localhost/  （或IP,或domain），能看到简单的帮助
   访问http://localhost/web/index 可看到目前的数据对象（表）的列表，点“创建”即可创建新“表”。
