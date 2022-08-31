import io
import time
import json
import requests
from contextlib import redirect_stdout
from urllib.parse import urlencode
from urllib.parse import quote
from azure.cli.core import get_default_cli
f = io.StringIO()
with redirect_stdout(f):
    get_default_cli().invoke(["account", "list"], None, f)
s = f.getvalue()

json_list = []
json_list.append(json.loads(s))
json.dumps(json_list)


account=json_list[0][0]
name = account['name']
print("设置订阅："+name)
# get_default_cli().invoke(["account", "set", "--subscription",  account['name'] ])



# get_default_cli().invoke(['group', 'create', '--name', 'myResourceGroup',
#                                       '--location', 'eastus'])

# get_default_cli().invoke(
#                         ['vm', 'create', '--resource-group', 'myResourceGroup', '--name',
#                          'free', '--image', 'UbuntuLTS',
#                          '--size', 'Standard_B1s', '--location', 'eastasia', '--admin-username',
#                          'azureuser', '--admin-password', '~uwerfdksfnsf', "--no-wait"])
s=''
for i in range (1,5):
    sub_id=account['id']
    
    f = io.StringIO()
    with redirect_stdout(f):
        get_default_cli().invoke(["ad","sp","create-for-rbac", "--role","contributor" ,"--scopes","/subscriptions/"+sub_id], None, f)
    s = f.getvalue()
    # if len(s.strip())>0:
    if "appId" in s:
        print(s)
        break
    print ("未获取到api。。等待15分钟重试")
    time.sleep(60*15)

print(s)

print(account['user']['name'])

domain='https://webcat.live'
email='text%40qq.com'
password='wzm80988'




payload='email='+email+'&password='+password
headers = {
  'authority': domain,
  'sec-ch-ua': '" Not A;Brand";v="99", "Chromium";v="99", "Google Chrome";v="99"',
  'accept': 'application/json, text/javascript',
  'content-type': 'application/x-www-form-urlencoded',
  'x-requested-with': 'XMLHttpRequest',
  'sec-ch-ua-mobile': '?0',
  'user-agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/99.0.4844.51 Safari/537.36',
  'sec-ch-ua-platform': '"Windows"',
  'origin': domain,
  'sec-fetch-site': 'same-origin',
  'sec-fetch-mode': 'cors',
  'sec-fetch-dest': 'empty',
  'referer': domain+'login',
  'accept-language': 'zh-CN,zh;q=0.9',
  'Cookie': 'PHPSESSID=f493a42b8d6d5cc4de99c201bf86da47'
}





response = requests.request("POST", domain+'/login', headers=headers, data=payload)

session=response.headers['Set-Cookie'].split(';')[0].split('=')[1]


import requests

url = domain+"/user/azure"

# s=json.loads(s)
# s=urlencode(s)

payload='user_mark=&az_email='+quote(account['user']['name'])+'&az_configs='+quote(s.strip())


# payload=urlencode(payload)

print(payload)
time.sleep(30)


headers = {
  'authority': domain,
  'sec-ch-ua': '" Not A;Brand";v="99", "Chromium";v="99", "Google Chrome";v="99"',
  'accept': 'application/json, text/javascript',
  'content-type': 'application/x-www-form-urlencoded',
  'x-requested-with': 'XMLHttpRequest',
  'sec-ch-ua-mobile': '?0',
  'user-agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/99.0.4844.51 Safari/537.36',
  'sec-ch-ua-platform': '"Windows"',
  'origin': domain,
  'sec-fetch-site': 'same-origin',
  'sec-fetch-mode': 'cors',
  'sec-fetch-dest': 'empty',
  'referer': domain+'/user/azure/create',
  'Cookie': 'PHPSESSID='+session+';'
}

response = requests.request("POST", domain+'/user/azure', headers=headers, data=payload)

print(response.text)
