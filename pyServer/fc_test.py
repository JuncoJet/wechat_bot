import requests,json

r=requests.post("https://www.sogou.com/labs/webservice/sogou_word_seg.php",
                  {
                      'q':u'这个是输入文字测试，你测了吗',
                      'fmt':'js'
                   }
              )
j=json.loads(r.text)
if j['status']=='OK':
    print j['input']
    for i in j['result']:
        print i[0],i[1],
else:
    print 'status error'
    print j
