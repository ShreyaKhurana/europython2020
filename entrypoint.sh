#!/bin/bash

CUDA_VISIBLE_DEVICES=0 python3 wsgi.py &

exec supervisord -c supervisord.conf

echo "started supervisord!"
