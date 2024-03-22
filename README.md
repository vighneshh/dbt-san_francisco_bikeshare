## dbt tutorial steps


##  create the environment
```
python -m venv dbt-env              
```
## activate the environment
```
. dbt-env/Scripts/activate
```
## Install dbt 
```
pip install dbt-bigquery
```
##  Make sure you have dbt Core installed and check the version using the dbt --version command:
```
dbt --version
```
## Initiate the jaffle_shop project using the init command:
```
dbt init jaffle_shop
```
## Navigate into your project's directory:
```
cd jaffle_shop
```

## create a file in the ~/.dbt/ directory named profiles.yml
```
jaffle_shop:
  outputs:
    dev:
      dataset: san_francisco_bikeshare
      job_execution_timeout_seconds: 300
      job_retries: 1
      keyfile: C:\dataengcourse\07-BigQurey\bqadmin_key.json
      location: US
      method: service-account
      priority: interactive
      project: dataengzoomcamp-413305
      threads: 1
      type: bigquery
  target: dev
```
## Run the debug command from your project to confirm that you can successfully connect:
```
dbt debug
```
> Connection test: OK connection ok

## Enter the run command to build example models:
dbt run

## Link the GitHub repository you created to your dbt project by running the following commands in Terminal. Make sure you use the correct git URL for your repository, which you should have saved from step 5 in Create a repository.
```
echo "# dbt-san_francisco_bikeshare" >> README.md
git init
git add .
git commit -m "first commit"
git branch -M master
git remote add origin https://github.com/vighneshh/dbt-san_francisco_bikeshare.git
git push -u origin master
```
## Create a new branch by using the checkout command and passing the -b flag:
$ git checkout -b add-bikshare-tables


## Create a new SQL file in the models directory, named `models/dbt_bikeshare_station_region_info.sql`
## in datawarehouse table or view will be create as per filename given to model. in this case `dbt_bikeshare_station_region_info`

```
{{
  config(
    materialized='table'
  )
}}
with bikeshare_stations as (

    select
        station_id,
    name as station_name,
    short_name,
    lat,
    lon,
    region_id,
    capacity,
    has_kiosk
    from `dataengzoomcamp-413305.san_francisco_bikeshare.bikeshare_station_info`

),
regions as (

    select
        region_id,
        name as region_name
 
    from `dataengzoomcamp-413305.san_francisco_bikeshare.bikeshare_regions`

),
dbt_bikeshare_station_region_info as (

    select
        bikeshare_stations.station_id,
        bikeshare_stations.station_name,
        bikeshare_stations.short_name,
        bikeshare_stations.lat,
        bikeshare_stations.lon,
        bikeshare_stations.region_id,
        bikeshare_stations.capacity,
        bikeshare_stations.has_kiosk,
        regions.region_name

    from bikeshare_stations

    left join regions using (region_id)

)
select * from dbt_bikeshare_station_region_info
```

## By default, everything gets created as a view. You can override that at the directory level so everything in that directory will materialize to a different materialization.

Edit your dbt_project.yml file.
Configure jaffle_shop so everything in it will be materialized as a table
```
models:
  jaffle_shop:
    +materialized: table
```

## Edit models/dbt_bikeshare_station_region_info.sql to override the dbt_project.yml for the customers model only by adding the following snippet to the top, and click Save:
```
{{
  config(
    materialized='view'
  )
}}
```
## Enter the dbt run command. Your model, customers, should now build as a view.

BigQuery users need to run `dbt run --full-refresh` instead of dbt run to full apply materialization changes.
Enter the `dbt run --full-refresh` command for this to take effect in your warehouse.

## Commit updated changes
You need to commit the changes you made to the project so that the repository has your latest code.

Add all your changes to git: `git add -A`
Commit your changes: `git commit -m "Add Bikshare stations and regions model"`
Push your changes to your repository: `git push`
Navigate to your repository, and open a pull request to merge the code into your master branch.