covid19-rmarkdown
==============================

RMarkdown fact sheets for COVID-19 Indicators

Project Organization
------------

    ├── LICENSE
    ├── Makefile                 <- Makefile with commands like `make data` or `make train`
    ├── README.md                <- The top-level README for developers using this project.
    ├── Dockerfile               <- Docker image for this project.
    |
    ├── catalogs                 <- A data catalog.
    ├── data                     <- A directory for local data.
    |
    ├── notebooks                <- Jupyter notebooks.
    │
    ├── conda-requirements.txt   <- The requirements file for conda installs.
    ├── requirements.txt         <- The requirements file for reproducing the analysis environment, e.g.
    │                               generated with `pip freeze > requirements.txt`
    │
    ├── setup.py                 <- Makes project pip installable (pip install -e .) so src can be imported
    ├── src                      <- Source code for use in this project.


--------

### Starting with JupyterLab

1. Sign in with credentials. [More details on getting started here.](https://cityoflosangeles.github.io/best-practices/getting-started-github.html) 
1. Launch a new terminal and clone repository: `git clone https://github.com/CityOfLosAngeles/REPO-NAME.git`
1. Change into directory: `cd REPO-NAME`
1. Make a new branch and start on a new task: `git checkout -b new-branch`


## Starting with Docker

1. Start with Steps 1-2 above
1. Build Docker container: `docker-compose.exe build`
1. Start Docker container `docker-compose.exe up`
1. Open Jupyter Lab notebook by typing `localhost:8888/lab/` in the browser for Python, `localhost:8888/rstudio/` or `localhost:8787/rstudio/` for RStudio.

### Setting up a Conda Environment 

1. `conda create --name my_project_name` 
1. `source activate my_project_name`
1. `conda install --file conda-requirements.txt -c conda-forge` 
1. `pip install requirements.txt`

<p><small>Project based on the <a target="_blank" href="https://drivendata.github.io/cookiecutter-data-science/">cookiecutter data science project template</a>. #cookiecutterdatascience</small></p>
