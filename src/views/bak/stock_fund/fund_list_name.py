#!/usr/bin/env python3
# coding=utf-8
import queue
import random
import threading

import requests
import json
import pymysql
import re

# 'fundcode'  # 基金code 'name' # 基金名称 'jzrq'  # 净值日期
# 'dwjz'  # 单位净值 'gsz' # 估算值 'gszzl'  # 估算值涨幅   'gztime'   # 估算值时间

url = "http://fund.eastmoney.com/js/fundcode_search.js"
# 浏览器头
headers = {'content-type': 'application/json',
           'User-Agent': 'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:22.0) Gecko/20100101 Firefox/22.0'}

r = requests.get(url, headers=headers)
# 返回信息
content = r.text
c = content[8:-1]
c = json.loads(c)
try:
    # 连接数据库
    conn = pymysql.connect(host='127.0.0.1', user='root', password='123456', db='stock', port=3306)
    # 获取cursor
    cur = conn.cursor()  # 使用 execute() 方法执行 SQL，如果表存在则删除
    # 基金基本信息生成
    # alter table users AUTO_INCREMENT=10000;
    # for i in range(len(c)):
    # cur.execute("INSERT INTO fund_description(code,name,type) VALUES(%s,%s,%s)", (c[i][0], c[i][3], c[i][4],))
    # 提交
    # conn.commit()
    # 基金code
    sql = "select code from fund_description"
    cur.execute(sql)
    fund_code_list = cur.fetchall()

    # 基金队列
    fund_code_queue = queue.Queue(len(fund_code_list))
    for i in range(len(fund_code_list)):
        fund_code_queue.put(fund_code_list[i][0])

    # fund_basic_info = cur.fetchmany(1)
    # arr = np.array(all_gp)
    # print(fund_basic_info)
finally:
    print('连接未关闭')

user_agent_list = [
    'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.1 (KHTML, like Gecko) Chrome/21.0.1180.71 Safari/537.1 LBBROWSER',
    'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Maxthon/4.4.3.4000 Chrome/30.0.1599.101 Safari/537.36',
    'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/38.0.2125.122 UBrowser/4.0.3214.0 Safari/537.36'
]
referer_list = [
    'http://fund.eastmoney.com/110022.html',
    'http://fund.eastmoney.com/110023.html',
    'http://fund.eastmoney.com/110024.html',
    'http://fund.eastmoney.com/110025.html'
]
# 正则表达式
pattern = r'^jsonpgz\((.*)\)'

# 给定日期表数据是否存在
sql = "select count(1) from fund_detail where date(date_dwjz) = DATE_SUB(CURDATE(),INTERVAL +1 DAY)"
cur.execute(sql)
res_query = cur.fetchall()
# 若存在 则先删除
if res_query[0][0] > 0:
    sql_del = "delete from fund_detail where date(date_dwjz) = DATE_SUB(CURDATE(),INTERVAL +1 DAY)"
    cur.execute(sql_del)
    conn.commit()

# 基金数据
def get_fund_data():

    try:
        while not fund_code_queue.empty():
            fund_code = fund_code_queue.get()
            header = {'User-Agent': random.choice(user_agent_list),
                    'Referer': random.choice(referer_list)}
            req = requests.get("http://fundgz.1234567.com.cn/js/" + str(fund_code) + ".js", timeout=3, headers=header)
            req.encoding = 'utf-8'
            # 查找结果
            if (req.status_code == 200):
                search = re.findall(pattern, req.text)
                if len(search) > 0 and search[0] != '' :
                    print('search:', search)
                    json_res = json.loads(search[0])
                    cur.execute("INSERT INTO fund_detail(code,name,date_dwjz,dwjz,gsz,zf_rate_gsz,date_gsz) VALUES(%s,%s,%s,%s,%s,%s,%s)",
                     (json_res['fundcode'], json_res['name'], json_res['jzrq'], json_res['dwjz'],
                     json_res['gsz'], json_res['gszzl'], json_res['gztime'],))
                    conn.commit()
    except Exception:
        fund_code_queue.put(fund_code)
        print("访问失败", Exception)
        get_fund_data()

if __name__ == '__main__':
    get_fund_data()
    # 线程锁 防止多线程写入文件时发生错乱
    # mutex_lock = threading.Lock()
    #for i in range(4):
    #    t = threading.Thread(target=get_fund_data, name='loopThread'+str(i))
    #    t.start()

# 遍历结果
# for i in search:
#  data = json.loads(i)
#  # print(data,type(data))
#  print("日期:{},時間：{},基金: {},收益率: {}".format(data['jzrq'], data['jzrq'], data['name'], data['gsz']))
