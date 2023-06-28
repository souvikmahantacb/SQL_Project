select * from `population_database`.`growth_table`;

--show the number of rows in growth table --

select count(*) from population_database.growth_table;

--database of west bengle and orissa--
select * from population_database.growth_table where state in ( 'West Bengal' , 'Orissa' );

--population of contry--

select sum(population) as population from population_database.population_table

--avg growth of india --
select state, avg(growth)*100 as avg_growth from population_database.growth_table group by state;

--avg sex ratio--
select state, round(avg(Sex_Ratio),0) as avg_sex_ratio from population_database.growth_table group by state order by avg_sex_ratio ;

--avg literacy greater than 90--
select state, round(avg(Literacy),0) as avg_Literacy from population_database.growth_table 
group by state having round(avg(Literacy),0) >90 order by avg_Literacy ;

--showing top 3 growth ratio state--
select state, avg(growth)*100 as avg_growth from population_database.growth_table group by state order by avg_growth desc limit 3;

--showing both top and bottom literacy rate states--

-- states starts with g---
select distinct state from population_database.population_table where lower(state) like 'g%' or lower(state) like 't%';

select distinct state from population_database.population_table where lower(state) like 'g%' and lower(state) like '%t';

--joining both tables--
select b.state, b.district, b.sex_ratio, a.Population from population_database.population_table a inner join population_database.growth_table b on a.district=b.district;

--number of male nad female--


-- total literacy rate and literate and illiterate peoples--
select d.state, d.district, round((d.population * d.literacy/100), 0) literate_people ,round((population - (d.population * d.literacy)/100), 0) illiterate_people from

(select b.state, b.district, b.Literacy, a.Population from population_database.population_table a inner join population_database.growth_table b on a.district=b.district) d;
 
 --window function--
 --top 3 dist from each state with highest literacy ratio--

select a. * from 
(select state, district literacy, rank() over (partition by state order by literacy desc ) rnk from population_database.growth_table) a
where a.rnk in (1,2,3) order by state