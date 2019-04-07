FROM aeliant/gunicorn

RUN set -x \
  && pip install flask

COPY flask_app.py /app/app.py
COPY flask_app.conf /etc/supervisor/conf.d/flask_app.conf
