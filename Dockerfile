FROM python:3.7.3-stretch
LABEL maintainer="Hamza ESSAYEGH <hamza.essayegh@protonmail.com>"
LABEL author="Hamza ESSAYEGH <hamza.essayegh@protonmail.com>"

# Installing gunicorn and gaffer
RUN set -x \
  && pip3 install \
    gunicorn \
    supervisor \
  && gunicorn --version \
  && supervisord --version

RUN set -x \
  && mkdir -p /etc/supervisor/conf.d

COPY supervisord.conf /etc/supervisor/supervisord.conf
CMD ["/usr/local/bin/supervisord", "-c", "/etc/supervisor/supervisord.conf"]
