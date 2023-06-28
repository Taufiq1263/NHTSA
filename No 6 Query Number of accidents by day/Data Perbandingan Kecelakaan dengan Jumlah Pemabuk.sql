--Jumlah Kecelakaan Menurut Hari—
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

select to_char(local_time,'day') as day ,
count(local_time) as jumlah_kecelakaan 
, round (count(local_time)/sum(count(local_time)) over(),6)*100 ||'%' as presentase
from crash
group by day  
order by jumlah_kecelakaan desc
--

select to_char(local_time,'day') as day ,
count(local_time) as jumlah_kecelakaan 
, round (count(local_time)/sum(count(local_time)) over(),6)*100 ||'%' as presentase
,SUM (number_of_drunk_drivers) as jumlah_pemabuk
, round (count(local_time)/sum(count(local_time)) over()/SUM (number_of_drunk_drivers) 
,4)||'%' as presentase_jumlah_pemabuk_terhadap_jumlah_kecelakaan
from crash
group by day  
order by jumlah_kecelakaan desc
