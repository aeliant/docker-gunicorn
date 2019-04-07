# Docker Gunicorn
[![Build Status](https://travis-ci.org/aeliant/docker-gunicorn.svg?branch=master)](https://travis-ci.org/aeliant/docker-gunicorn)

A docker image with Gunicorn ready for python web application, with `supervisor`
as the monitoring tool.

This image is based on the `python:3.7.3-stretch` official python image.

## Supported tags
*  `0.0.1`, `latest`

## How to run this docker image
1.  First pull the image:
```bash
$ docker pull aeliant/gunicorn
```

2.  Create a configuration file for supervisor (`flask_app.conf`). The following
example is for a flask application:

```supervisor
[program:gunicorn]
command = /usr/local/bin/gunicorn -b :8080 app:app
directory = /app
user = nobody
autostart = true
autorestart = true
redirect_stderr = true
```

This configuration file will tell `supervisor` to run gunicorn with the `app.py`
inside the `/app` directory, using the flask variable `app`. Here is the flask
application example (`flask_app.py`):

```python
from flask import Flask, jsonify
app = Flask(__name__)

@app.route('/test')
def hello():
  return jsonify({'message': 'hello'})
```

3.  Run the following command to run your application:
```bash
$ docker run -d \
  --name gunicorn-application \
  --publish 8080:8080 \
  --volume $(pwd)/flask_app.conf:/etc/supervisor/conf.d/flask_app.conf \
  --volume $(pwd)/flask_app.py:/app/app.py \
  aeliant/gunicorn
```

This command will create a docker container named `gunicorn-application`, with
the published port `8080`. You can now access your web application through:

```bash
$ curl http://localhost:8080/test
{"message": "hello"}
```

## Multiple web application inside the same container
If you want to run multiple web python application, you just have to create as
many `supervisor` configuration file as you want in the `/etc/supervisor/conf.d`
directory.

```bash
$ docker run -d \
  --name gunicorn-application \

  --publish 8080:8080 \ # web application 1
  --publish 8081:8081 \ # web application 2

  --volume $(pwd)/flask_app_1.conf:/etc/supervisor/conf.d/flask_app_1.conf \
  --volume $(pwd)/flask_app_1.py:/app/app_1.py \

  --volume $(pwd)/flask_app_2.conf:/etc/supervisor/conf.d/flask_app_2.conf \
  --volume $(pwd)/flask_app_2.py:/app/app_2.py \
  aeliant/gunicorn
```
## Using docker-compose
Here is a sample of a docker-compose file to use with this image:
```yaml
version: "2.0"
services:
  web_application:
    image: aeliant/gunicorn
    container_name: gunicorn-container-name
    ports:
    - 0.0.0.0:8080:8080
    - 0.0.0.0:8081:8081
    volumes:
    - ./flask_app_1.conf:/etc/supervisor/conf.d/flask_app_1.conf
    - ./flask_app_2.conf:/etc/supervisor/conf.d/flask_app_2.conf

    - ./flask_app_1.py:/app/app_1.py
    - ./flask_app_2.py:/app/app_2.py
```
