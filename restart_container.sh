#!/bin/bash
docker kill mock || true
docker rm mock || true
docker build -t mock_app:latest .
docker run -d -p 8002:8002 --name mock mock_app:latest
