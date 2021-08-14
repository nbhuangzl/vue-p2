

-- 添加索引
-- ALTER TABLE `stock_realtime_today` ADD INDEX idx_srt_code (`code`);
-- ALTER TABLE `stock_realtime_today_21081015` ADD INDEX idx_srt10_code (`code`); 
-- ALTER TABLE `stock_realtime_today_21081115` ADD INDEX idx_srt11_code (`code`);
-- ALTER TABLE `stock_realtime_today_21081215` ADD INDEX idx_srt12_code (`code`);
-- select * from stock_basic_info where code = '002454'
-- 煤炭开采
select * from (
select code,name,price,cv,dv,ev,fv,industry,sum(cv+dv+ev+fv) sum_v
from (
select distinct * from (
select c.code,c.name,c.price,c.industry, c.change_percent cv,d.change_percent dv,e.change_percent ev, f.change_percent fv from (
select a.*,b.industry from (
select * from stock_realtime_today where date_trade = '20210813') a
left join 
stock_basic_info b
on a.code = b.code
-- where industry = '煤炭开采'
order by change_percent desc ) c
left join 
(
select a.code,a.name,a.change_percent,b.industry from (
select * from stock_realtime_today_21081215 ) a
left join 
stock_basic_info b
on a.code = b.code
-- where b.industry = '煤炭开采'
order by a.change_percent desc ) d
on c.code = d.code
left join 
(
select a.code,a.name,a.change_percent,b.industry from (
select * from stock_realtime_today_21081115 ) a
left join 
stock_basic_info b
on a.code = b.code
-- where b.industry = '煤炭开采'
order by a.change_percent desc ) e
on c.code = e.code
left join 
(
select a.code,a.name,a.change_percent,b.industry from (
select * from stock_realtime_today_21081115 ) a
left join 
stock_basic_info b
on a.code = b.code
-- where b.industry = '煤炭开采'
order by a.change_percent desc ) f
on c.code = f.code
order by c.change_percent desc ) o1) o2
group by code,name,price,cv,dv,ev,fv,industry ) o3 
where code not like '300%'
order by industry,sum_v desc
-- where cv < 5 or dv < 5 or ev < 5 or fv < 5

-- 焦炭加工
select * from (
select code,name,price,cv,dv,ev,fv,sum(cv+dv+ev+fv) sum_v
from (
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
order by c.change_percent desc ) o1) o2
group by code,name,price,cv,dv,ev,fv ) o3 order by sum_v desc
-- where cv < 5 or dv < 5 or ev < 5 or fv < 5
