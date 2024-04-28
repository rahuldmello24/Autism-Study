select * 
from study

create view rel_study as
select author,
	   title,
	   year_published,
	   country,
	   area,
	   age_range,
	   study_years,
	   sample_size,
	   number_of_cases,
	   ASD_prevelance_est_per_1000,
	   confidence_int,
	   male_female_ratio,
	   iq_score_less_than_70,
	   percentage_of_ind_co_occuring_conds,
	   autism_types_include
from study

create view adult_asd_counts as
select country_of_res, 
       count(*) as asd_count,
       (SELECT COUNT(*) FROM adult WHERE country_of_res = t.country_of_res) AS total_count,
       ROUND(COUNT(*) * 1.0 / (SELECT COUNT(*) FROM adult WHERE country_of_res = t.country_of_res), 2) AS proportion_of_asd
from adult t
where ASD = 'YES'
group by country_of_res
order by asd_count desc

create view child_asd_counts as
select country_of_res, 
       count(*) as asd_count,
       (SELECT COUNT(*) FROM child WHERE country_of_res = t.country_of_res) AS total_count,
       ROUND(COUNT(*) * 1.0 / (SELECT COUNT(*) FROM child WHERE country_of_res = t.country_of_res), 2) AS proportion_of_asd
from child t
where ASD = 'YES'
group by country_of_res
order by asd_count desc

select *
from child_asd_counts
