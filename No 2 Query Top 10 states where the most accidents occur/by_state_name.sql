select 
	crash.state_name,
	count(crash.state_name) as total,
	round(
	 count(crash.state_name)::decimal*100.0 / x.total::decimal , 2
	)||'%' as percentage
from crash,
(select count(*) as total from crash) x
group by crash.state_name, x.total
order by total desc
limit 10