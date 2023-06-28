--Kecelakaan Karena Mabuk dan Tidak Mabuk Beserta Presentase (Query Adit)
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


--Kecelakaan Mabuk Berdasarkan Daerah
SELECT
(CASE WHEN land_use_name in ('Not Reported', 'Unknown', 'Trafficway Not in State Inventory') THEN 'Other'
ELSE land_use_name END) AS daerah,
COUNT(*) kecelakaan_karena_mabuk
FROM crash
WHERE number_of_drunk_drivers > 0
GROUP BY daerah
ORDER BY kecelakaan_karena_mabuk desc
--Kecelakaan Mabuk Berdasarkan Atmosfir
SELECT
(CASE WHEN atmospheric_conditions_1_name in ('Not Reported', 'Reported as Unknown') THEN 'Other'
ELSE atmospheric_conditions_1_name END) AS atmosfir,
COUNT(*) kecelakaan_karena_mabuk
FROM crash
WHERE number_of_drunk_drivers > 0
GROUP BY atmosfir
ORDER BY kecelakaan_karena_mabuk desc


---Kecelakaan Mabuk Berdasarkan Berdasarkan Kondisi Pencahayaan
SELECT
(CASE WHEN light_condition_name in ('Not Reported', 'Unknown', 'Reported as Unknown') THEN 'Other'
ELSE light_condition_name END) AS pencahayaan,
COUNT(*) AS kecelakaan_karena_mabuk
FROM crash
WHERE number_of_drunk_drivers > 0
GROUP BY pencahayaan
ORDER BY kecelakaan_karena_mabuk desc
--Kecelakaan Mabuk Berdasarkan Kondisi Dark Digabungkan (Query Nawir)
SELECT
(CASE WHEN x.kondisi in ('Not Reported', 'Reported as Unknown') THEN 'Other'
ELSE x.kondisi END) AS pencahayaan,
		count(x.kondisi) as jumlah_karena_mabuk
from
(
select split_part(light_condition_name,'-',1) kondisi,
		split_part(light_condition_name,'-',2) cahaya
from crash
	where number_of_drunk_drivers > 0
)x
group by pencahayaan
order by jumlah_karena_mabuk DESC


--Kecelakaan Mabuk berdasarkan Proses Kecelakaan
SELECT
(CASE WHEN manner_of_collision_name in ('Not Reported', 'Reported as Unknown') THEN 'Other'
ELSE manner_of_collision_name END) AS proses_kecelakaan,
COUNT(*) kecelakaan_karena_mabuk
FROM crash
WHERE number_of_drunk_drivers > 0
GROUP BY proses_kecelakaan
ORDER BY kecelakaan_karena_mabuk desc


--Kecelakaan Mabuk Berdasarkan Proses Kecelakaan Tertinggi dan Pencahayaan
SELECT
manner_of_collision_name, (CASE WHEN light_condition_name in ('Not Reported', 'Reported as Unknown') THEN 'Other'
ELSE light_condition_name END) AS pencahayaan,
COUNT(*) kecelakaan_karena_mabuk
FROM crash
WHERE manner_of_collision_name = 'The First Harmful Event was Not a Collision with a Motor Vehicle in Transport'
AND number_of_drunk_drivers > 0
GROUP BY manner_of_collision_name, pencahayaan
ORDER BY kecelakaan_karena_mabuk desc


--Kecelakaan Mabuk Berdasarkan Atmosfir dan Daerah
SELECT
(CASE WHEN land_use_name in ('Not Reported', 'Reported as Unknown', 'Trafficway Not in State Inventory', 'Unknown') THEN 'Other'
ELSE land_use_name END) AS daerah,
(CASE WHEN atmospheric_conditions_1_name in ('Not Reported', 'Reported as Unknown') THEN 'Other'
ELSE atmospheric_conditions_1_name END) AS cuaca,
COUNT(*) kecelakaan_karena_mabuk
FROM crash
WHERE number_of_drunk_drivers > 0
GROUP BY land_use_name, cuaca
ORDER BY kecelakaan_karena_mabuk desc


--Kecelakaan Mabuk Berdasarkan Atmosfir Daerah Urban
SELECT
land_use_name as daerah, (CASE WHEN atmospheric_conditions_1_name in ('Not Reported', 'Reported as Unknown') THEN 'Other'
ELSE atmospheric_conditions_1_name END) AS cuaca,
COUNT(*) kecelakaan_karena_mabuk
FROM crash
WHERE land_use_name = 'Urban' AND number_of_drunk_drivers > 0
GROUP BY land_use_name, cuaca
ORDER BY kecelakaan_karena_mabuk desc


--Kecelakaan Mabuk Berdasarkan Kondisi Atmosfir Daerah Rural
SELECT
land_use_name as daerah, (CASE WHEN atmospheric_conditions_1_name in ('Not Reported', 'Reported as Unknown') THEN 'Other'
ELSE atmospheric_conditions_1_name END) AS cuaca,
COUNT(*) kecelakaan_karena_mabuk
FROM crash
WHERE land_use_name = 'Rural' AND number_of_drunk_drivers > 0
GROUP BY daerah, cuaca
ORDER BY kecelakaan_karena_mabuk desc


--Kecelakaan Mabuk Berdasarkan Kondisi Cahaya dan Daerah
SELECT
(CASE WHEN land_use_name in ('Not Reported', 'Reported as Unknown', 'Trafficway Not in State Inventory', 'Unknown') THEN 'Other'
ELSE land_use_name END) AS daerah,
(CASE WHEN light_condition_name in ('Not Reported', 'Reported as Unknown', 'Trafficway Not in State Inventory') THEN 'Other'
ELSE light_condition_name END) AS pencahayaan,
COUNT(*) kecelakaan_karena_mabuk
FROM crash
WHERE number_of_drunk_drivers > 0
GROUP BY daerah, pencahayaan
ORDER BY kecelakaan_karena_mabuk desc


--Kecelakaan Mabuk Berdasarkan Kondisi Cahaya Daerah Urban
SELECT
land_use_name as daerah, (CASE WHEN light_condition_name in ('Not Reported', 'Reported as Unknown') THEN 'Other'
ELSE light_condition_name END) AS pencahayaan,
COUNT(*) kecelakaan_karena_mabuk
FROM crash
WHERE land_use_name = 'Urban' AND number_of_drunk_drivers > 0
GROUP BY daerah, pencahayaan
ORDER BY kecelakaan_karena_mabuk desc


--Kecelakaan Mabuk Berdasarkan Kondisi Cahaya Daerah Rural
SELECT
land_use_name as daerah, (CASE WHEN light_condition_name in ('Not Reported', 'Reported as Unknown') THEN 'Other'
ELSE light_condition_name END) AS pencahayaan,
COUNT(*) kecelakaan_karena_mabuk
FROM crash
WHERE land_use_name = 'Rural' AND number_of_drunk_drivers > 0
GROUP BY daerah, pencahayaan
ORDER BY kecelakaan_karena_mabuk desc


--Kecelakaan Mabuk Berdasarkan Hari dan Penyesuaian Timezone (Query Adit dan Zaki)
ALTER TABLE crash ADD COLUMN local_time timestamp
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
	
select c.state_name, c.timestamp_of_crash, c.local_time from crash c
SELECT * FROM crash

SELECT to_char(local_time,'day') AS hari,
COUNT(*) kecelakaan_karena_mabuk
FROM crash
WHERE number_of_drunk_drivers > 0
GROUP BY hari
ORDER BY kecelakaan_karena_mabuk desc