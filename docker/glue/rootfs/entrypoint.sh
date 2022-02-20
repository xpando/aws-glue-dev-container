#!/bin/sh
if [ -d "$HOME/bin" ]; then
  export PATH="$HOME/bin:$PATH"
fi

if [ -z "$NO_ACTIVATE_VENV" ] && [ -d "/app/venv" ]; then
  source "/app/venv/bin/activate"

  [ -f /project/requirements.txt ] && pip install -r /project/requirements.txt

  export SPARK_HOME=$(python /app/venv/bin/find_spark_home.py)
  export SPARK_CONF_DIR=/app/spark/conf
  export PYTHONPATH=/app/lib/python/PyGlue.zip:$PYTHONPATH
  export PYTHONPATH=$(ls $SPARK_HOME/python/lib/py4j-*-src.zip):$PYTHONPATH
  export PYTHONPATH=$SPARK_HOME/python/:$PYTHONPATH
fi

exec "$@"
