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
git init
git branch -M main
git add .
git commit -m "Create a dbt project"
git remote add origin https://github.com/USERNAME/dbt-tutorial.git
git push -u origin main
```