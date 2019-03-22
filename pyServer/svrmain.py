import json
import requests
from bottle import request,response,run,get,post,template,view,static_file,redirect,default_app

@post('/fc_test')
def fc_test():
    q=request.forms.get('q')
    if not q:
        return
    url="https://www.sogou.com/labs/webservice/sogou_word_seg.php"
    r=requests.post(url,{'q':q.decode('utf8'),'fmt':'js'})
    print q.decode('utf8')
    print r.text
    if not r.text:
        return u'没有获取到数据'
    j=json.loads(r.text)
    r=''
    if j['status']=='OK':
        #print j['input']
        for i in j['result']:
            r+=i[0]+'|'+i[1]+' '
    else:
        print 'status error'
        print j
    return r

@post('/turing')
def do_turing():
    #图灵机器人接口 可以自己注册key，目前作者的是5000条/天
    #http://www.tuling123.com/openapi/record.do?channel=338
    q=request.forms.get('q')
    payload={'key':'9e01d5c29994c579040270b557a99295','info':q}
    url="http://www.tuling123.com/openapi/api"
    r=requests.post(url,params=payload)
    return json.loads(r.text)['text']

@get('/jquery.js')
@view('jquery-2.0.0.min.js')
def jquery():
    return

@post('/mybot')
def do_mybot():
    #这里添加自己的机器人处理
    return

@get('/admin')
@view('admin')
def admin():
    return

@post('/admin')
def do_admin():
    #机器人后台调教
    q=request.forms.get('q')
    a=request.forms.get('a')
    if q and a:
        url="https://www.sogou.com/labs/webservice/sogou_word_seg.php"
        r=requests.post(url,{'q':q.decode('utf8'),'fmt':'js'})
        if not r.text:
            return {'code':1,'msg':u'分词器1异常'}
        qfc=json.loads(r.text)
        r=requests.post(url,{'q':a.decode('utf8'),'fmt':'js'})
        if not r.text:
            return {'code':1,'msg':u'分词器2异常'}
        afc=json.loads(r.text)
        h={}
        if qfc['status']=='OK':
            for i in qfc['result']:
                h[i[1]]=i[0]
                db().set("INSERT INTO `wb_ck` (`cy`, `cx`) VALUES (%s, %s)",(i[0],i[1]))
        if afc['status']=='OK':
            for i in afc['result']:
                if h.has_key(i[1]):
                    db().set("INSERT INTO `wb_ck` (`cy`, `cx`) VALUES (%s, %s)",(i[0],i[1]))
                    s1=db().get1("SELECT `id` FROM `wb_ck` WHERE `cy` = %s LIMIT 1",h[i[1]])[0]
                    s2=db().get1("SELECT `id` FROM `wb_ck` WHERE `cy` = %s LIMIT 1",i[0])[0]
                    db().set("INSERT INTO `wb_gx` (`cid`, `kid`) VALUES (%s, %s)",(s1,s2))
                    db().set("UPDATE `wb_gx` SET `qz`=`qz`+1 WHERE (`cid`=%s)",s1)
            return {'code':0}
    return {'code':1,'msg':u'执行操作失败!'}

run(host='0.0.0.0', port=8080,debug=True)
application=default_app()
