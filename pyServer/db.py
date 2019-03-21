#import redis
import MySQLdb
from DBUtils.PooledDB import PooledDB

dbpool = PooledDB(MySQLdb,4,host='localhost',user='root',passwd='',db='wechat_bot',port=3306,charset='utf8') #10为连接池里的最少连接数
class db:
    def __init__(self):
        global dbpool
        self.conn = dbpool.connection()  #以后每次需要数据库连接就是用connection（）函数获取连接就好了
        self.cur=self.conn.cursor()
    def __del__(self):
        self.cur.close()
        self.conn.close()
    def get(self,*sql):
        if len(sql)>1:
            self.r=self.cur.execute(sql[0],sql[1])
        else:
            self.r=self.cur.execute(sql[0])
        if self.r:
            self.r=self.cur.fetchall()
            return self.r
        else:
            return False
    def get1(self,*sql):
        if len(sql)>1:
            self.r=self.cur.execute(sql[0],sql[1])
        else:
            self.r=self.cur.execute(sql[0])
        if self.r:
            self.r=self.cur.fetchone()
            return self.r
        else:
            return False
    def set(self,*sql):
        if len(sql)>1:
            self.r=self.cur.execute(sql[0],sql[1])
        else:
            self.r=self.cur.execute(sql[0])
        if self.r:
            self.conn.commit()
        return True if self.r else False
    def mset(self,*sql):
        self.r=self.cur.executemany(sql[0],sql[1])
        if self.r:
            self.conn.commit()
        return True if self.r else False

#rdbpool = redis.ConnectionPool(host='localhost', port=6379, db=3) #redis数据库3
#def rdb():
#    return redis.Redis(connection_pool=rdbpool)
