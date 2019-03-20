import json
import requests
from bottle import request,response,run,get,post,template,view,static_file,redirect,default_app

@post('/fc_test')
def fc_test():
    q=request.forms.get('q')
    r=requests.post("https://www.sogou.com/labs/webservice/sogou_word_seg.php",
                      {
                          'q':q,
                          'fmt':'js'
                       }
                  )
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
    
run(host='0.0.0.0', port=8080,debug=True)
application=default_app()
