# 引入包
import pymysql
import tushare as ts

# 实时数据
data = ts.get_realtime_quotes(['600519','000651'])
print(data)
# 也可以设置只显示某些值
print(data[['code', 'name', 'price', 'bid', 'ask', 'volume', 'amount', 'time']])
# 上证指数 深圳成指 沪深300指数 上证50 中小板 创业板
index = ts.get_realtime_quotes(['sh', 'sz', 'hs300', 'sz50', 'zxb', 'cyb'])
print(index)

#设置token
token = '33fafd87a649b02e6700c554a0469297bac5ddcbaaabadf900204fad'
ts.set_token(token)

pro = ts.pro_api()
#查询当前所有正常上市交易的股票列表
data = pro.stock_basic(exchange='', list_status='L')
try:
    # 连接数据库
    conn = pymysql.connect(host='127.0.0.1', user='root', password='123456', db='stock', port=3306)
    # 获取cursor
    cur = conn.cursor()  # 使用 execute() 方法执行 SQL，如果表存在则删除
    # 股票基本信息生成
    for row in data.itertuples():
        print(row[1])
        print(row[2])
        print(row[3])
        print(row[4])
        print(row[5])
        cur.execute("INSERT INTO stock_basic_info(ts_code, code,name,area, industry, market, date_create) VALUES(%s,%s,%s,%s,%s,%s,%s)",
                    (row[1], row[2], row[3], row[4], row[5], row[6], row[7]))
    # 提交
    conn.commit()
finally:
    print('连接未关闭')
    conn.close()
print(type(data))

if __name__ == '__main__':
    print('')