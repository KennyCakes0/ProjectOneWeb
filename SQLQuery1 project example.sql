select location,date,total_cases,new_cases,total_deaths,population
from [Portfolio 1 database 1]..CovidDeaths101
order by 1,2

-- Total cases vs Total deaths
select location,date,total_cases,new_cases,total_deaths,(total_deaths/total_cases)*100 as DeathRate
from [Portfolio 1 database 1]..CovidDeaths101
Where location='South Africa'
order by 1,2

-- Total cases vs population
-- the below will illustuate % that got covid
select location,date,total_cases,new_cases,total_deaths,(total_cases/population)*100 as DeathRate
from [Portfolio 1 database 1]..CovidDeaths101
Where location='South Africa'
order by 1,2

--countries with high infections vs population

select Location,Population,max(total_cases) as HighInfectionCount,max((total_cases/population))*100 as PopulationCount
from [Portfolio 1 database 1]..CovidDeaths101
--Where location='South Africa'
group by Location,Population


--Total death count by continents

select Continent, max(cast(total_deaths as int)) as TotalDeathCount
from [Portfolio 1 database 1]..CovidDeaths101
Where continent is not null
group by continent
order by TotalDeathCount

--Total Population vs Vaccination

select dea.continent,dea.location,dea.date,dea.population, vac.new_vaccinations 
from [Portfolio 1 database 1]..CovidDeaths101 dea join
[Portfolio 1 database 1]..CovidVaccination vac
on dea.location =vac.location
and dea.date =vac.date
where dea.continent is not null
order by 2,3

--Total Population vs Vaccination South Africa

select dea.continent,dea.location,dea.date,dea.population, vac.new_vaccinations 
,sum(convert(int,vac.new_vaccinations)) over(Partition by dea.location order by dea.location,dea.date)
from [Portfolio 1 database 1]..CovidDeaths101 dea join
[Portfolio 1 database 1]..CovidVaccination vac
on dea.location =vac.location
and dea.date =vac.date
where dea.location = 'South Africa'
order by 2,3

Visual_1

create view nduduzo1 as
select dea.continent,dea.location,dea.date,dea.population, vac.new_vaccinations 
,sum(convert(int,vac.new_vaccinations)) over(Partition by dea.location order by dea.location,dea.date) as newtotal_vaccinations
from [Portfolio 1 database 1]..CovidDeaths101 dea join
[Portfolio 1 database 1]..CovidVaccination vac
on dea.location =vac.location
and dea.date =vac.date
where dea.location = 'South Africa'
--order by 2,3

