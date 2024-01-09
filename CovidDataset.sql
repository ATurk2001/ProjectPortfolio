use projectportfolio;


/*  
select*
from coviddeaths
order by 1,2;

select *
from covidvaccinations
order by 1,2;  */

-- select data that I am going to use
select location
, date
, total_cases
, new_cases
, total_deaths
, population
from coviddeaths;

-- looking for total cases vs total deaths
-- shows the possibility of dying if you contract covid in the United States
select location
, date
, total_cases
, total_deaths
, (total_deaths/total_cases)*100 as DeathPercentage
from coviddeaths;

-- looking at total cases vs population
-- Shows what percentage of population got covid
select location
, date
, population
, total_cases
, (total_cases/population)*100 as CovidContracted
from coviddeaths;
-- highest infection rate
select location
, population
, MAX(total_cases) as HighestInfected
,  MAX((total_cases/population))*100 as CovidContracted
from coviddeaths
group by location, population;

-- This is showing highest death count per population
select location
, MAX(total_deaths) as TotalDeathCount
from coviddeaths
group by location;


select dea.location
, dea.date
, dea.population
, vac.new_Vaccinations
, SUM(vac.new_Vaccinations) over 
(Partition by dea.location order by dea.date) as PeopleVacinationOverTime
from coviddeaths dea
join covidvaccinations vac
	on dea.location=vac.location
    and dea.date=vac.date;
    
    
-- use CTE

with PopvsVac (location, date, population, new_Vaccinations, PeopleVacinationOverTime)
as
(
select dea.location
, dea.date
, dea.population
, vac.new_Vaccinations
, SUM(vac.new_Vaccinations) over 
(Partition by dea.location order by dea.date) as PeopleVacinationOverTime
from coviddeaths dea
join covidvaccinations vac
	on dea.location=vac.location
    and dea.date=vac.date
)
select*, (PeopleVacinationOverTime/population)*100 as PopulationVacinationPercentageOverTime
from PopvsVac;

-- Create view for visualisations

Create View PercentPopulationVaccinatedinUSA as
select dea.location
, dea.date
, dea.population
, vac.new_Vaccinations
, SUM(vac.new_Vaccinations) over 
(Partition by dea.location order by dea.date) as PeopleVacinationOverTime
from coviddeaths dea
join covidvaccinations vac
	on dea.location=vac.location
    and dea.date=vac.date