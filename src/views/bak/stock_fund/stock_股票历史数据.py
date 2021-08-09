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
sql_basic = "select ts_code from stock_basic_info"
cur.execute(sql_basic)
stock_ts_code_list = cur.fetchall()
# 股票队列
stock_code_queue = queue.Queue(len(stock_ts_code_list))
for i in range(len(stock_ts_code_list)):
    stock_code_queue.put(stock_ts_code_list[i][0])

start_date = '20210809'
end_date = '20210810'
sql_del = "delete from stock_history where date_trade >= date(%s) and date_trade < date(%s)"
cur.execute(sql_del, (start_date, end_date))
conn.commit()

def get_stock_history():
    try:
        count = 0
        while not stock_code_queue.empty():
            stock_code = stock_code_queue.get()
            print(stock_code)
            df = pro.daily(ts_code=stock_code, start_date=start_date, end_date=end_date)
            for row in df.itertuples():
                cur.execute(
                    "INSERT INTO stock_history(code,date_trade,pre_close, close, change_v, pct_chg, vol, amount) VALUES(%s,%s,%s,%s,%s,%s,%s,%s)",
                    (row[1].split('.')[0], row[2], row[7], row[6], row[8], row[9], row[10], row[11]))
            # 提交
            conn.commit()
            count = count+1
            print(count)
    except Exception:
        print("访问失败", Exception)
        time.sleep(7)
        stock_code_queue.put(stock_code)
        get_stock_history()
    finally:
        conn.close()

if __name__ == '__main__':
    get_stock_history()