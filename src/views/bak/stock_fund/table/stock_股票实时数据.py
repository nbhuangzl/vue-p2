# 引入包
import queue
import time

import pymysql
import tushare as ts

#设置token
token = '33fafd87a649b02e6700c554a0469297bac5ddcbaaabadf900204fad'
ts.set_token(token)
pro = ts.pro_api()

# 连接数据库
conn = pymysql.connect(host='127.0.0.1', user='root', password='123456', db='stock', port=3306)
# 获取cursor
cur = conn.cursor()  # 使用 execute() 方法执行 SQL，如果表存在则删除
sql_basic = "select code from stock_basic_info where code not like '300%'"
cur.execute(sql_basic)
stock_code_tuple = cur.fetchall()

# 股票队列
stock_code_queue = queue.Queue(len(stock_code_tuple))
for i in range(len(stock_code_tuple)):
    stock_code_queue.put(stock_code_tuple[i][0])
def get_stock_today():

    stock = ts.get_today_all()

    for row in stock.itertuples():
        cur.execute(
            "INSERT INTO stock_realtime_today(code,name,pre_close,price,change_percent, open, high, low, volume,amount)"
            "VALUES(%s,%s,%s,%s,%s,%s,%s,%s,%s,%s)",
            (row[1], row[2], row[8], row[4], row[3], row[5], row[6], row[7], row[9], row[11])
        )
        # 提交
        conn.commit()
    conn.close()

def get_stock_realtime():
    try:
        count = 0
        while not stock_code_queue.empty():
            stock_code = stock_code_queue.get()
            data = ts.get_realtime_quotes(stock_code)
            print(data)
            for row in data.itertuples():
                print(row[9])
                cur.execute(
                    "INSERT INTO stock_realtime(name,open,pre_close, price, high, low, bid, ask,volume,amount, b1_v,b1_p,b2_v,b2_p,b3_v,b3_p,b4_v,b4_p,b5_v,b5_p, a1_v,a1_p,a2_v,a2_p,a3_v,a3_p,a4_v,a4_p,a5_v,a5_p,code)"
                    "VALUES(%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s)",
                    (row[1], float(row[2]), float(row[3]), float(row[4]), float(row[5]), float(row[6]), float(row[7]), float(row[8]), int(row[9]), float(row[10]),float(row[11]), float(row[12]), float(row[13]), float(row[14]), float(row[15]), float(row[16]), float(row[17]), float(row[18]), float(row[19]), float(row[20]), float(row[21]), float(row[22]), float(row[23]), float(row[24]), float(row[25]), float(row[26]), float(row[27]), float(row[28]), float(row[29]), float(row[30]), row[33])
                )
            # 提交
            conn.commit()
            count = count + 1
            print(count)
    except Exception:
        print("访问失败", Exception)
        time.sleep(7)
        stock_code_queue.put(stock_code)
        get_stock_realtime()
    finally:
        conn.close()

# 上证指数 深圳成指 沪深300指数 上证50 中小板 创业板
# index = ts.get_realtime_quotes(['sh', 'sz', 'hs300', 'sz50', 'zxb', 'cyb'])
# print(index)

if __name__ == '__main__':
    get_stock_today()