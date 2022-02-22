#!/bin/sh

[ -f /project/requirements.txt ] && pip install -r /project/requirements.txt

exec "$@"