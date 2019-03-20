import json
import requests
from bottle import request,response,run,get,post,template,view,static_file,redirect,default_app

@post('/fc_test')
def do_fc_test():
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

run(host='0.0.0.0', port=8080,debug=True)
application=default_app()
