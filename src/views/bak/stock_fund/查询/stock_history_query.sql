-- select * from stock_basic_info where name like '%线缆%';

-- select * from stock_history sh where code='605028' DATE_FORMAT(sh.date_trade,'%m%d') = '0531' and sh.code= '600803'
SELECT * FROM (
SELECT o2.industry,o2.code, o2.name,o2.month_fmt,o2.close,
o2.d1,o2.d2,o2.d3,o2.d4,o2.d5,o2.d6,o2.d7,o2.d8,o2.d9,
case o2.month_fmt 
             when '01' then d4+d5+d6+d7+d8
						 when '06' then (select d31 from stock_history sh where DATE_FORMAT(sh.date_trade,'%m%d') = '0531' and sh.code=o2.code )+d1+d2+d3+d4
						 when '07' then d5+d6+d7+d8+d9
						 when '08' then d2+d3+d4+d5+d6
						 end week1,
o2.d10,o2.d11,o2.d12,o2.d13,o2.d14,o2.d15,o2.d16,
case o2.month_fmt 
             when '01' then d15+d11+d12+d13+d14
						 when '06' then d7+d8+d9+d10+d11
						 when '07' then d12+d13+d14+d15+d16
						 when '08' then d9+d10+d11+d12+d13
						 end week2,
o2.d17,o2.d18,o2.d19,o2.d20,o2.d21,o2.d22,
case o2.month_fmt 
             when '01' then d18+d19+d20+d21+d22
						 when '06' then d14+d15+d16+d17+d18
						 when '07' then d19+d20+d21+d22+d23
						 when '08' then d16+d17+d18+d19+d20
						 end week3,
o2.d25,o2.d26,o2.d27,o2.d28,o2.d29,						 
case o2.month_fmt 
             when '01' then d25+d26+d27+d28+d29
						 when '06' then d21+d22+d23+d24+d25
						 when '07' then d26+d27+d28+d29+d30
						 when '08' then d23+d24+d25+d26+d27
						 end week4 FROM (
select 
      o.industry,o.name,o.code,o.month_fmt,o.close,      SUM(CASE o.date_fmt WHEN '01' THEN o.pct_chg  ELSE 0 END ) as d1,
			SUM(CASE o.date_fmt WHEN '02' THEN o.pct_chg  ELSE 0 END ) as d2,
			      SUM(CASE o.date_fmt WHEN '03' THEN o.pct_chg  ELSE 0 END ) as d3,
			SUM(CASE o.date_fmt WHEN '04' THEN o.pct_chg  ELSE 0 END ) as d4,
			      SUM(CASE o.date_fmt WHEN '05' THEN o.pct_chg  ELSE 0 END ) as d5,
			SUM(CASE o.date_fmt WHEN '06' THEN o.pct_chg  ELSE 0 END ) as d6,
			      SUM(CASE o.date_fmt WHEN '07' THEN o.pct_chg  ELSE 0 END ) as d7,
			SUM(CASE o.date_fmt WHEN '08' THEN o.pct_chg  ELSE 0 END ) as d8,
			      SUM(CASE o.date_fmt WHEN '09' THEN o.pct_chg  ELSE 0 END ) as d9,
			SUM(CASE o.date_fmt WHEN '10' THEN o.pct_chg  ELSE 0 END ) as d10,
			      SUM(CASE o.date_fmt WHEN '11' THEN o.pct_chg  ELSE 0 END ) as d11,
			SUM(CASE o.date_fmt WHEN '12' THEN o.pct_chg  ELSE 0 END ) as d12,
						SUM(CASE o.date_fmt WHEN '13' THEN o.pct_chg  ELSE 0 END ) as d13,
			      SUM(CASE o.date_fmt WHEN '14' THEN o.pct_chg  ELSE 0 END ) as d14,
			SUM(CASE o.date_fmt WHEN '15' THEN o.pct_chg  ELSE 0 END ) as d15,
			      SUM(CASE o.date_fmt WHEN '16' THEN o.pct_chg  ELSE 0 END ) as d16,
			SUM(CASE o.date_fmt WHEN '17' THEN o.pct_chg  ELSE 0 END ) as d17,
			      SUM(CASE o.date_fmt WHEN '18' THEN o.pct_chg  ELSE 0 END ) as d18,
			SUM(CASE o.date_fmt WHEN '19' THEN o.pct_chg  ELSE 0 END ) as d19,
			      SUM(CASE o.date_fmt WHEN '20' THEN o.pct_chg  ELSE 0 END ) as d20,
			SUM(CASE o.date_fmt WHEN '21' THEN o.pct_chg  ELSE 0 END ) as d21,
						      SUM(CASE o.date_fmt WHEN '22' THEN o.pct_chg  ELSE 0 END ) as d22,
			SUM(CASE o.date_fmt WHEN '23' THEN o.pct_chg  ELSE 0 END ) as d23,
						SUM(CASE o.date_fmt WHEN '24' THEN o.pct_chg  ELSE 0 END ) as d24,
			      SUM(CASE o.date_fmt WHEN '25' THEN o.pct_chg  ELSE 0 END ) as d25,
			SUM(CASE o.date_fmt WHEN '26' THEN o.pct_chg  ELSE 0 END ) as d26,
			      SUM(CASE o.date_fmt WHEN '27' THEN o.pct_chg  ELSE 0 END ) as d27,
			SUM(CASE o.date_fmt WHEN '28' THEN o.pct_chg  ELSE 0 END ) as d28,
			      SUM(CASE o.date_fmt WHEN '29' THEN o.pct_chg  ELSE 0 END ) as d29,
			SUM(CASE o.date_fmt WHEN '30' THEN o.pct_chg  ELSE 0 END ) as d30,
			      SUM(CASE o.date_fmt WHEN '31' THEN o.pct_chg  ELSE 0 END ) as d31
from (
select b.industry,b.name,a.code,DATE_FORMAT(a.date_trade,'%m') month_fmt,date_format(a.date_trade, '%d') date_fmt,
a.close,a.pct_chg,a.vol,a.amount from stock_history a
left join 
stock_basic_info b
on a.code = b.code
where b.industry = '供气供热' 
and b.code = '605028'
order by date_fmt desc

) o
group by o.industry,o.name,o.code,o.month_fmt
)o2
where o2.month_fmt = '08' or o2.month_fmt = '07' or o2.month_fmt = '06'
)o3
order by o3.week2 desc