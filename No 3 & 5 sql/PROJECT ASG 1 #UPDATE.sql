--3
select 
	to_char(crash.local_time, 'HH24') as jam,
	count(crash.number_of_vehicle_forms_submitted_all) as jumlah,
	count(crash.number_of_vehicle_forms_submitted_all)/x.days
	as ratarata_kecelakaan
from crash,
(select distinct
 split_part((max(crash.local_time) over() - min(crash.local_time) over())::text,' ',1)::int as days
from crash) as x
group by jam, x.days
order by jam asc

--5
--general
select 
	land_use_name,
	count(land_use_name) as total,
	round(
	 count(land_use_name)::decimal*100.0 / x.total::decimal , 3
	)||'%' as percentage
from crash,
(select count(*) as total from crash) x
group by land_use_name, x.total
