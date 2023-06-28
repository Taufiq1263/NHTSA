select * from crash

-- jumlah crash berdasarkan kota dan desa
select land_use_name,
		count(land_use_name) as jumlah,
		round(count(land_use_name)/sum(count(land_use_name)) over (),4)*100 ||'%' as persentase
from crash
group by land_use_name
order by jumlah desc

-- jumlah crash di nama jalan fungsional
select functional_system_name,
		count(functional_system_name) as jumlah,
		round(count(functional_system_name)/sum(count(functional_system_name)) over (),4)*100 ||'%' as persentase
from crash
group by functional_system_name
order by jumlah desc

-- jumlah orang mabuk yang terlibat
select number_of_drunk_drivers,
		count(number_of_drunk_drivers) as jumlah,
		round(count(number_of_drunk_drivers)/sum(count(number_of_drunk_drivers)) over (),5)*100 ||'%' as persentase
from crash
group by number_of_drunk_drivers
order by jumlah desc

-- jumlah crash berdasarkan intersection
select type_of_intersection_name,
		count(type_of_intersection_name) as jumlah,
		round(count(type_of_intersection_name)/sum(count(type_of_intersection_name)) over (),5)*100 ||'%' as persentase
from crash
group by type_of_intersection_name
order by jumlah desc

-- jumlah crash berdasarkan kondisi atmosfir
select atmospheric_conditions_1_name,
		count(atmospheric_conditions_1_name) as jumlah,
		round(count(atmospheric_conditions_1_name)/sum(count(atmospheric_conditions_1_name)) over (),4)*100 ||'%' as persentase
from crash
group by atmospheric_conditions_1_name
order by jumlah desc

-- jumlah crash berdasarkan kondisi cahaya
select light_condition_name,
		count(light_condition_name) as jumlah,
		round(count(light_condition_name)/sum(count(light_condition_name)) over (),4)*100 ||'%' as persentase
from crash
group by light_condition_name
order by jumlah DESC

--jumlah crash berdasarkan kondisi cahaya di daerah urban
select 	land_use_name,
		light_condition_name,
		count(light_condition_name) as jumlah,
		round(count(light_condition_name)/sum(count(light_condition_name)) over (),4)*100 ||'%' as persentase
from crash
where land_use_name = 'Urban'
group by land_use_name, light_condition_name
order by jumlah DESC

--jumlah crash berdasarkan kondisi cahaya di daerah rural
select 	land_use_name,
		light_condition_name,
		count(light_condition_name) as jumlah,
		round(count(light_condition_name)/sum(count(light_condition_name)) over (),4)*100 ||'%' as persentase
from crash
where land_use_name = 'Rural'
group by land_use_name, light_condition_name
order by jumlah DESC

-- jumlah crash berdasarkan kondisi cahaya gelap disatukan
select x.kondisi,
		count(x.kondisi) as jumlah,
		round(count(x.kondisi)/sum(count(x.kondisi)) over (),4)*100 ||'%' as persentase
from
(
select split_part(light_condition_name,'-',1) kondisi,
		split_part(light_condition_name,'-',2) cahaya
from crash		
)x	
group by x.kondisi
order by jumlah desc	
		
-- kondisi gelap dan cloudy
select x.atmospheric_conditions_1_name, x.kondisi, 
		count(x.kondisi) as jumlah,
		round(count(x.kondisi)/sum(count(x.kondisi)) over (),4)*100 ||'%' as persentase
from
(
select split_part(light_condition_name,'-',1) kondisi,
		split_part(light_condition_name,'-',2) cahaya,
		atmospheric_conditions_1_name
from crash		
)x	
where atmospheric_conditions_1_name='Cloudy'
group by x.kondisi, atmospheric_conditions_1_name
order by jumlah desc

-- kondisi gelap dan clear
select x.atmospheric_conditions_1_name, x.kondisi, 
		count(x.kondisi) as jumlah,
		round(count(x.kondisi)/sum(count(x.kondisi)) over (),4)*100 ||'%' as persentase
from
(
select split_part(light_condition_name,'-',1) kondisi,
		split_part(light_condition_name,'-',2) cahaya,
		atmospheric_conditions_1_name
from crash		
)x	
where atmospheric_conditions_1_name='Cloudy'
group by x.kondisi, atmospheric_conditions_1_name
order by jumlah desc

--jumlah crash berdasarkan jenis tabrakan
select manner_of_collision_name,
		count(manner_of_collision_name) as jumlah,
		round(count(manner_of_collision_name)/sum(count(manner_of_collision_name)) over (),4)*100 ||'%' as persentase
from crash
group by manner_of_collision_name
order by jumlah desc


-- jumlah crash tunggal di desa dan kota
select 	manner_of_collision_name,
		land_use_name,
		count(land_use_name) as jumlah,
		round(count(land_use_name)/sum(count(land_use_name)) over (),4)*100 ||'%' as persentase
from crash
where manner_of_collision_name='The First Harmful Event was Not a Collision with a Motor Vehicle in Transport'
group by manner_of_collision_name, land_use_name
order by jumlah desc



--jumlah kecelakaan tunggal berdasarkan kondisi cahayaa
select 	manner_of_collision_name,
		light_condition_name,
		count(light_condition_name) as jumlah,
		round(count(light_condition_name)/sum(count(light_condition_name)) over (),4)*100 ||'%' as persentase
from crash
where manner_of_collision_name='The First Harmful Event was Not a Collision with a Motor Vehicle in Transport'
group by light_condition_name, manner_of_collision_name
order by jumlah DESC



--jumlah kecelakaan tunggal berdasarkan kondisi cahaya gelap disatukan
select x.manner_of_collision_name, x.kondisi, 
		count(x.kondisi) as jumlah,
		round(count(x.kondisi)/sum(count(x.kondisi)) over (),3)*100 ||'%' as persentase
from
(
select split_part(light_condition_name,'-',1) kondisi,
		split_part(light_condition_name,'-',2) cahaya,
		manner_of_collision_name
from crash		
)x	
where x.manner_of_collision_name='The First Harmful Event was Not a Collision with a Motor Vehicle in Transport'
group by x.kondisi, x.manner_of_collision_name
order by jumlah desc


-- kondisi gelap di Principal Arterial - Other
select x.functional_system_name, x.kondisi, 
		count(x.kondisi) as jumlah,
		round(count(x.kondisi)/sum(count(x.kondisi)) over (),4)*100 ||'%' as persentase
from
(
select split_part(light_condition_name,'-',1) kondisi,
		split_part(light_condition_name,'-',2) cahaya,
		functional_system_name
from crash		
)x	
where x.functional_system_name='Principal Arterial - Other'
group by x.kondisi, x.functional_system_name
order by jumlah desc


-- kondisi gelap di Minor Arterial
select x.functional_system_name, x.kondisi, 
		count(x.kondisi) as jumlah,
		round(count(x.kondisi)/sum(count(x.kondisi)) over (),4)*100 ||'%' as persentase
from
(
select split_part(light_condition_name,'-',1) kondisi,
		split_part(light_condition_name,'-',2) cahaya,
		functional_system_name
from crash		
)x	
where x.functional_system_name='Minor Arterial'
group by x.kondisi, x.functional_system_name
order by jumlah desc


-- jumlah kecelakaan berdasarkan hari (query zaki)
select to_char(local_time,'day') as day,
		count(local_time) as jumlah_kecelakaan,
		round (count(local_time)/sum(count(local_time)) over(),4)*100 ||'%' as presentase
from crash
group by day
order by jumlah_kecelakaan desc


-- Jumlah kecelakaan di principal arterial per hari
select functional_system_name, 
		to_char(local_time,'day') as hari , count(local_time) as jumlah_kecelakaan , 
		count(CASE WHEN land_use_name = 'Rural' THEN 1 END) as pedesaan,
		count(CASE WHEN land_use_name = 'Urban' THEN 1 END) as perkotaan,
		count(CASE WHEN land_use_name = 'Trafficway Not in State Inventory' THEN 1 END) as bukan_inventaris_negara,
		count(CASE WHEN land_use_name = 'Not Reported' THEN 1 END) as tidak_dilaporkan,
		count(CASE WHEN land_use_name = 'Unknown'THEN 1 END) as tidak_diketahui
from crash
where functional_system_name='Principal Arterial - Other'
group by hari, functional_system_name
order by jumlah_kecelakaan desc


-- query nada
select distinct on(jenis_kecelakaan)
	case
		when c.number_of_drunk_drivers::text = '0' then 'kecelakaan tanpa mabuk'
		else 'kecelakaan dengan mabuk'
	end as jenis_kecelakaan,
	case
		when c.number_of_drunk_drivers::text = '0' then count(c.number_of_drunk_drivers)
		else (
				select count(number_of_drunk_drivers)
				from crash
				where number_of_drunk_drivers!=0
			)
	end as jumlah,
	case
		when c.number_of_drunk_drivers::text = '0' then 
			(
				select round(count(number_of_drunk_drivers)::decimal*100.0
						/(select count(*) from crash)::decimal,2)||'%'
				from crash
				where number_of_drunk_drivers=0
			)
		else (
				select round(count(number_of_drunk_drivers)::decimal*100.0
						/(select count(*) from crash)::decimal,2)||'%'
				from crash
				where number_of_drunk_drivers!=0
			)
	end as persentase
from crash c
group by c.number_of_drunk_drivers

select 
	crash.state_name,
	sum(crash.number_of_fatalities) as korban
from crash
group by crash.state_name
order by korban desc
limit 10

select 
	crash.state_name,
	count(crash.state_name) as jumlah
from crash
group by crash.state_name
order by jumlah desc
limit 10

--jumlah kecelakaan di tennessee berdasarkan kondisi cahaya
select 	state_name,
		light_condition_name,
		count(light_condition_name) as jumlah,
		round(count(light_condition_name)/sum(count(light_condition_name)) over (),4)*100 ||'%' as persentase
from crash
where state_name='Tennessee'
group by light_condition_name, state_name
order by jumlah DESC



--query no 3 adit
select 
	to_char(crash.local_time, 'HH24') as jam,
	count(crash.number_of_vehicle_forms_submitted_all) as jumlah,
	count(crash.number_of_vehicle_forms_submitted_all)/365 as ratarata_kecelakaan
from crash
group by jam
order by jumlah desc




select	
case when light_condition_name= 'Daylight' then 'Gelap' end as kondisicahaya,
case when light_condition_name= 'Daylight' then (select to_char(local_time, 'HH24') from crash) end as jam,
case when light_condition_name= 'Daylight' then (select count(to_char(local_time, 'HH24')) from crash) end as jumlah,
case when light_condition_name= 'Daylight' then (select round(count(to_char(local_time, 'HH24'))/366.00,2) from crash) end as ratarata
from crash
group by to_char(local_time, 'HH24'), light_condition_name
order by jumlah desc


--query taufiq
select state_name, count(state_name) as jumlah
FROM crash
group by 1
ORDER by 2 desc
limit 10


select 
	crash.state_name,
	sum(crash.number_of_fatalities) as korban
from crash
group by crash.state_name
order by korban desc
limit 10

/*
CST: Alabama, Arkansas, Illinois, Indiana, Iowa, Kansas, Kentucky, Louisiana, Minnesota, Mississippi,
Missouri, Nebraska, North Dakota, Oklahoma, South Dakota, Tennessee, Texas, Wisconsin
AKST: Alaska
MST: Arizona, Colorado, Idaho, Montana, New Mexico, Utah, Wyoming
PST: California, Nevada, Oregon, Washington
EST: Connecticut, Delaware, District of Columbia, Florida, Georgia, Indiana, Maine, Maryland, Massachusetts, Michigan,
New Hampshire, New Jersey, New York, North Carolina, Ohio, Pennsylvania, Rhode Island, South Carolina, Vermont, Virginia, West Virginia
HST: Hawaii

BEGIN;
update crash
	set local_time = timestamp_of_crash at time zone 
	case 
		when state_name in ('Alabama', 'Arkansas', 'Illinois', 
							  'Iowa', 'Kansas', 'Kentucky', 'Louisiana', 'Minnesota', 'Mississippi',
							  'Missouri', 'Nebraska', 'North Dakota', 'Oklahoma', 'South Dakota',
							  'Tennessee', 'Texas', 'Wisconsin') then 'CST'
		when state_name in ('Alaska') then 'AKST'
		when state_name in ('Arizona', 'Colorado', 'Idaho', 'Montana', 
							  'New Mexico', 'Utah', 'Wyoming') then 'MST'
		when state_name in ('California', 'Nevada', 'Oregon', 'Washington') then 'PST'
		when state_name in ('Connecticut', 'Delaware', 'District of Columbia', 'Florida',
							  'Georgia', 'Indiana', 'Maine', 'Maryland', 'Massachusetts', 'Michigan',
							  'New Hampshire', 'New Jersey', 'New York', 'North Carolina', 'Ohio', 
							  'Pennsylvania', 'Rhode Island', 'South Carolina', 'Vermont',
							  'Virginia', 'West Virginia') then 'EST'
		when state_name in ('Hawaii') then 'HST'
	end;
COMMIT;
ROLLBACK;

show timezone
select * from pg_timezone_names where name = 'Asia/Bangkok'

alter table crash add column local_time timestamp
alter table crash drop column local_time
*/


select c.state_name, c.timestamp_of_crash, c.local_time from crash c
