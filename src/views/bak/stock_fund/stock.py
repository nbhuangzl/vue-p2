#!/usr/bin/env python3
#coding=utf-8

import pymysql
import numpy as np
import sys
import json
import urllib.request
import urllib
import os
import time
# 连接数据库
db = pymysql.connect(host='127.0.0.1', user='root', password='123456', db='stock', port=3306)
# 获取cursor
cursor = db.cursor() # 使用 execute() 方法执行 SQL，如果表存在则删除

sql = "select * from stock_m_record"
cursor.execute(sql)

all_gp = cursor.fetchall()
arr = np.array(all_gp)

print(arr)


def mkdir(path):                     # 股票保存路径函数
    folder = os.path.exists(path)
    if not folder:                   # 判断是否存在文件夹如果不存在则创建为文件夹
        os.makedirs(path)            # makedirs 创建文件时如果路径不存在会创建这个路径
        print(path)


def getData(url):   # 函数——从接口中获取单只股票当天每分钟的数据
    content = ""
    try:        # 网络会偶发出现奔溃情况，为了保证不中断和保证数据齐全，休息5秒重新执行
        response = urllib.request.urlopen(url)
        content = response.read().decode('utf-8')
    except:
        print("发生网络异常")
        time.sleep(5)
        return getData(url)
    if content != "":
        return content
    else:
        print("内容为空")
        return getData(url)


def csv_create(path, msg):     # 函数——将单只股票的数据保存进指定文件夹
    file = open(path, 'w')
    file.write(msg)
    print("文件"+path+"创建成功")
    file.close()


def tranformToCSV(content, filepath):        # 函数——将下载的数据转换为csv数据，以便读取
    content = content.replace("(", "").replace(")", "")
    json_str = json.loads(content)
    a_str = json_str.get("data")
    a_time = json_str.get("info").get("time")
    a_date = str(a_time).split(" ")         # 用以文件命名
    mkdir(filepath)
    array_str = np.array(a_str)
    csv_str = "time,first,second,third,fourth\n"    # time为当天时间点，first为该分钟股票价格
    for item in array_str:
        item = str(item)
        items = item.split(",")
        arr_items = (str(items[0])).split(" ")
        items0 = arr_items[1]
        csv_str += '"'+items0+'",'+items[1]+','+items[2]+','+items[3]+','+items[4]+'\n'
    csv_create(filepath+"/"+a_date[0]+".csv", csv_str)


for item in arr:
    url = "http://pdfm.eastmoney.com/EM_UBG_PDTI_Fast/api/js?rtntype=5&id=" + item[3] + item[1] + "&type=r&iscr=false"
    data = getData(url)
    item2 = item[2].replace("*", "")
    tranformToCSV(data, "D://gp/" + str(gp_count) + "、" + item2 + item[3])  # 股票信息的保存路径是（D：//pg/序号+股票名字+股票代号/日期.csv）
    gp_count = gp_count + 1;
    # 使用 DebugLog

db.commit()
db.close()

