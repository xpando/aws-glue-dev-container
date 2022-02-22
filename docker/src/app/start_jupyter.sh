#!/bin/sh

source "/app/venv/bin/activate"
export SPARK_HOME=$(python /app/venv/bin/find_spark_home.py)
export SPARK_CONF_DIR=/app/spark/conf
export PYTHONPATH=/app/lib/python/PyGlue.zip:$PYTHONPATH
export PYTHONPATH=$(ls $SPARK_HOME/python/lib/py4j-*-src.zip):$PYTHONPATH
export PYTHONPATH=$SPARK_HOME/python/:$PYTHONPATH
export PYSPARK_DRIVER_PYTHON=jupyter
export PYSPARK_DRIVER_PYTHON_OPTS="lab --config /app/jupyter/config.py"
cd /project
pyspark
