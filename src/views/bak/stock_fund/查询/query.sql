# alter table fund_detail AUTO_INCREMENT=0;

select * from fund_detail where code = '002560'


select * from fund_detail limit 10


select code,name, sum(dwjz) a from fund_detail  group by code,name order by a desc


select count(1) from fund_description;

alter table fund_description AUTO_INCREMENT=0;

select count(1) from fund_detail where date(date_dwjz) = DATE_SUB(CURDATE(),INTERVAL +2 DAY)

select date(date_dwjz) from fund_detail
# delete from fund_detail where date(date_dwjz) = DATE_SUB(CURDATE(),INTERVAL +1 DAY)
select *  from fund_detail where date(date_dwjz) = DATE_SUB(CURDATE(),INTERVAL +1 DAY)

# 查去重
 select * from fund_detail where code in (
 select code from ( 
select code,name,count(code) c_code from (
select  * from fund_detail where  date(date_dwjz) = DATE_SUB(CURDATE(),INTERVAL +1 DAY))aa 
group by code,name ) c 
where c_code > 1 ) 

-- select DATE_SUB(CURDATE(),INTERVAL +2 DAY)
-- select date('2021/07/28')

select * from (

# 查看基金增长率排名
select code,name, value_jz/fm*100 v from (

select code,name,sum(value_jz) value_jz,sum(value_fm) fm from 
-- select * from 
(
 select code,name,
 case  when date(date_dwjz) = date('2021/07/29') then dwjz
       when date(date_dwjz) = date('2021/07/27') then -dwjz 
	end value_jz,
 case  
       when date(date_dwjz) = date('2021/07/27') then dwjz
			 else 0 
	end value_fm
 from fund_detail where date(date_dwjz) = date('2021/07/29') or date(date_dwjz) = date('2021/07/27')
 ) a 
 group by code,name 
 )b where value_jz < 0.9539 order by v desc
 # 查看基金增长率排名
 
 ) c where code = '001298'
 
 select (4.1220-3.7770) from fund_detail where code = '001404'
 
  select * from fund_detail where code = '001298'
 
 # 验证计算值
 select * from (select code,name,
 case  when date(date_dwjz) = date('2021/07/28') then dwjz
       when date(date_dwjz) = date('2021/07/27') then -dwjz 
	end value_jz 
 from fund_detail where date(date_dwjz) = date('2021/07/28') or date(date_dwjz) = date('2021/07/27')) a_check
 where code ='002501'
 
 
 # 股票基本信息
 SELECT * FROM `stock_basic_info`;
 SELECT market,industry,max(name) name FROM `stock_basic_info` group by market,industry; 
 SELECT * FROM stock_history
select ts_code from stock_basic_info  where  market = '创业板' code = '300693'
select * from stock_history where date_trade >= date('20180703') and date_trade < date('20180718')


select sum(change_v) from (
-- select * from (
select * from stock_history where code = '000001')a
left join 
stock_basic_info b
on a.code = b.code  -- -1.47
-- select (19.34- 17.69)/17.69
-- select -0.43 + -0.74+1.39+0.34 - 0.05
-- select -0.060/5.800
-- 建立索引
CREATE INDEX idx_stock_history_code ON stock_history (code);
CREATE INDEX idx_stock_basic_info_code ON stock_basic_info (code);

SELECT * FROM (
select code, COUNT(1) count from (
select * from stock_history_copy1
where 
-- code = '000059' and 
pct_chg >9 ) a 
group by code) b
where b.count >5

-- 
select * from (
select b.*,sum(change_v),b.pre_close yesterday_close,sum(change_v)/b.pre_close from (
select t.* from stock_history t order by date_trade asc ) b
group by code  )c
where c.code = '002142'

-- sum 4.120 
-- select 
code,
 sum(change_v)
 from stock_history where code = '002142' group by code -- -2.440 select 32.400 -35.340
select 2.44/35.34

-- 近半年-增长率-排名
select c.*,(select name from stock_basic_info where code = c.code) name,c.code code_ from (
select b.*,sum(change_v),b.pre_close yesterday_close,sum(change_v)/b.pre_close final from (
select t.* from stock_history t order by date_trade asc ) b
group by code ) c
where c.final > 2
order by final desc

-- 历史多天查询
select sh.*,(select name from stock_basic_info where code = sh.code) name 
from stock_history sh 
where code = '000545' 
order by date_trade desc

-- 涨幅率排名
select * from (

select sh.*,bi.name, bi.industry from stock_history sh
left join stock_basic_info bi
on sh.code = bi.code
where date_trade = date('20210806')
  and sh.code not like '300%'
	-- and amount > 100000
	and pct_chg > 5
	-- and name like '江%'
  order by industry, pct_chg desc
	
	) c where code = '000545'
-- 类型 industry 110
	select count(1) from (
     select distinct industry from stock_basic_info ) a -- 300311
		 
-- select count(distinct(code)) from stock_history where date_trade = date('20210810')
-- select 23.301*3100 72233.1
-- select 2345+2332+12955+2527+7050+11800+9212+11670+2350+7848+2088

-- 查询3日连涨幅 
select code,close,amount,sum_pct_chg,abs_sum_pct_chg,(select name from stock_basic_info where code = b.code) name from (
select *, sum(pct_chg) sum_pct_chg, sum(ABS(pct_chg)) abs_sum_pct_chg from (
select * from stock_history
where date_trade >= date('20210805') and date_trade < date('202108010')
order by date_trade desc ) a
group by code
) b 
where sum_pct_chg = abs_sum_pct_chg
and code not like '300%'
and sum_pct_chg > 5

-- 查询2日连涨幅 
select * from (
select code,close,amount,sum_pct_chg,abs_sum_pct_chg,(select name from stock_basic_info where code = b.code) name,(select industry from stock_basic_info where code = b.code) industry from (
select *, sum(pct_chg) sum_pct_chg, sum(ABS(pct_chg)) abs_sum_pct_chg from (
select * from stock_history
where date_trade >= date('20210806') and date_trade < date('20210810')
order by date_trade desc ) a
group by code
) b 
where sum_pct_chg = abs_sum_pct_chg
and code not like '300%'
and sum_pct_chg > 5) c -- 1工作日
where c.sum_pct_chg >15 or amount>1000000 -- 2工作日
order by sum_pct_chg desc

-- 查询日涨幅 
select * from (
select code,close,amount,sum_pct_chg,abs_sum_pct_chg,(select name from stock_basic_info where code = b.code) name,(select industry from stock_basic_info where code = b.code) industry from (
select *, sum(pct_chg) sum_pct_chg, sum(ABS(pct_chg)) abs_sum_pct_chg from (
select * from stock_history
where date_trade >= date('20210810') and date_trade < date('20210811')
order by date_trade desc ) a
group by code
) b 
where sum_pct_chg = abs_sum_pct_chg
and code not like '300%'
and sum_pct_chg > 5) c  -- 1工作日
where c.sum_pct_chg >5 or amount>1000000 -- 1工作日
order by sum_pct_chg desc

-- select * from stock_basic_info where name like '%美%' 
-- select * from stock_basic_info where name like '%华阳%'

-- 煤炭开采
select distinct * from (
select c.code,c.name,c.price,c.change_percent cv,d.change_percent dv,e.change_percent ev, f.change_percent fv from (
select a.*,b.industry from (
select * from stock_realtime_today where date_trade = '20210813') a
left join 
stock_basic_info b
on a.code = b.code
where industry = '煤炭开采'
order by change_percent desc ) c
left join 
(
select a.code,a.name,a.change_percent,b.industry from (
select * from stock_realtime_today_21081215 ) a
left join 
stock_basic_info b
on a.code = b.code
where b.industry = '煤炭开采'
order by a.change_percent desc ) d
on c.code = d.code
left join 
(
select a.code,a.name,a.change_percent,b.industry from (
select * from stock_realtime_today_21081115 ) a
left join 
stock_basic_info b
on a.code = b.code
where b.industry = '煤炭开采'
order by a.change_percent desc ) e
on c.code = e.code
left join 
(
select a.code,a.name,a.change_percent,b.industry from (
select * from stock_realtime_today_21081115 ) a
left join 
stock_basic_info b
on a.code = b.code
where b.industry = '煤炭开采'
order by a.change_percent desc ) f
on c.code = f.code
order by c.change_percent desc ) o
where cv < 5 or dv < 5 or ev < 5 or fv < 5

-- 焦炭加工
select distinct * from (
select c.code,c.name,c.price,c.change_percent cv,d.change_percent dv,e.change_percent ev, f.change_percent fv from (
select a.*,b.industry from (
select * from stock_realtime_today where date_trade = '20210813') a
left join 
stock_basic_info b
on a.code = b.code
where industry = '焦炭加工'
order by change_percent desc ) c
left join 
(
select a.code,a.name,a.change_percent,b.industry from (
select * from stock_realtime_today_21081215 ) a
left join 
stock_basic_info b
on a.code = b.code
where b.industry = '焦炭加工'
order by a.change_percent desc ) d
on c.code = d.code
left join 
(
select a.code,a.name,a.change_percent,b.industry from (
select * from stock_realtime_today_21081115 ) a
left join 
stock_basic_info b
on a.code = b.code
where b.industry = '焦炭加工'
order by a.change_percent desc ) e
on c.code = e.code
left join 
(
select a.code,a.name,a.change_percent,b.industry from (
select * from stock_realtime_today_21081115 ) a
left join 
stock_basic_info b
on a.code = b.code
where b.industry = '焦炭加工'
order by a.change_percent desc ) f
on c.code = f.code
order by c.change_percent desc ) o
-- where cv < 5 or dv < 5 or ev < 5 or fv < 5



-- 查詢2日連漲幅
select * from (

select code, name,price, change_percent,amount/100000000 amount,volume/1000000 volume
-- (select industry from stock_basic_info bi where bi.code = b.code ) industry,level,
-- (select vol/10000 volume from stock_history sh where sh.date_trade = date('20210810') and sh.code=b.code) yesterday_volume,
-- (select amount/100000 amount from stock_history sh where sh.date_trade = date('20210810') and sh.code=b.code) yesterday_amount,
-- (select vol/10000 volume from stock_history sh where sh.date_trade = date('20210809') and sh.code=b.code) b1_yesterday_volume,
-- (select vol/10000 volume from stock_history sh where sh.date_trade = date('20210806') and sh.code=b.code) b2_yesterday_volume
from (
select date_trade,code, name,price,amount,change_percent, volume,level from stock_realtime_today)b
where change_percent >5
and date_trade = '20210813'
and code not like '300%'
and price < 50
order by change_percent desc

) table01
left join 
(
select code, name,price, change_percent,amount/100000000 amount,volume/1000000 volume
from (
select code, name,price,amount,change_percent, volume,level from stock_realtime_today_21081115)b
where change_percent >1
and code not like '300%'
and price < 30
order by change_percent desc
) table02
on table01.code = table02.code
order by table01.change_percent desc

-- select 124618+678

-- select 45692+5690.97+73894.6
-- select * from stock_realtime_today_21081115 where code = '000676'
-- 漲幅率
select * from (

select code, name,price, change_percent,amount/100000000 amount,volume/1000000 volume,
(select industry from stock_basic_info bi where bi.code = b.code ) industry,level,

(select vol/10000 volume from stock_history sh where sh.date_trade = date('20210810') and sh.code=b.code) yesterday_volume,
(select amount/100000 amount from stock_history sh where sh.date_trade = date('20210810') and sh.code=b.code) yesterday_amount,
(select vol/10000 volume from stock_history sh where sh.date_trade = date('20210809') and sh.code=b.code) b1_yesterday_volume,
(select vol/10000 volume from stock_history sh where sh.date_trade = date('20210806') and sh.code=b.code) b2_yesterday_volume
from (
select code, name,price,amount,change_percent, volume,level from stock_realtime_today)b
where change_percent >5
and code not like '300%'
and price < 30
order by change_percent desc
)o1
where o1.amount < o1.yesterday_amount

-- select count(distinct code ) from stock_realtime_today set level = 1 where code = '000420' -- 4445

-- 证券账户
-- select 12705+107662.58 + 5775.75   -- 126143.33 
-- select 101237 + 20157.89 +5775.75  -- 127170.65
-- select 101051.00 + 20157.89 + 5775.75  -- 126984.64 

# 余數
-- select 73894.60 + 45692 + 5690.97
-- select count(1) from stock_basic_info
select * from (
select distinct code,name from stock_realtime_today)a
left join stock_basic_info b
on a.code = b.code
where b.code is null
select * from (
select  a.code,a.name,(select distinct code from stock_history b where b.code = a.code) value  from stock_realtime_today a)c
where c.value is null
select * from (
select count(1) c,code from stock_realtime_today group by code ) t
where 
t.c > 1

select * from stock_realtime_today where code = '603157'

-- 
select * from (
select a.*,substr(ts_code,1,6), count(1) count from 
(select * from stock_week where date(trade_date) >= date('20210702') and date(trade_date) < date('20211201') order by trade_date asc) a 
group by a.ts_code) b
where  sum_week_close >  b.count*pre_week_close*0.05

select * from (
select a.*,sum(change_price) sum_chg_price,sum(abs_chg_price) sum_abs_chg_price from (
select ts_code code,trade_date,change_price,abs(change_price) abs_chg_price from stock_week)a
group by a.code
) b
where b.sum_chg_price > 3 
-- where b.sum_chg_price = b.sum_abs_chg_price
order by sum_chg_price desc

select CURRENT_TIMESTAMP ('2011080115')