FROM python:3.4
MAINTAINER Quang <quang.astronaut@gmail.com>


ENV NGINX_VERSION 1.9.5
RUN apt-key adv \
  --keyserver hkp://pgp.mit.edu:80 \
  --recv-keys 573BFD6B3D8FBC641079A6ABABF5BD827BD9BF62

RUN echo "deb http://nginx.org/packages/mainline/debian/ jessie nginx" >> /etc/apt/sources.list
RUN echo "deb-src http://nginx.org/packages/mainline/debian/ jessie nginx" >> /etc/apt/sources.list
RUN apt-get update && apt-get upgrade -y
RUN set -x; \
    apt-get update \
    && apt-get install -y --no-install-recommends \
        locales \
        ca-certificates \
        nginx sudo \
    && rm -rf /var/lib/apt/lists/*


RUN apt-get install -y libpq-dev

# RUN apt-get install -y \
#         postgresql-9.3 postgresql-contrib-9.3 \
#         postgresql-doc-9.3 postgresql-server-dev-9.3
#
# RUN /etc/init.d/postgresql start &&\
#             sudo -u postgres psql --command "CREATE USER taiga WITH SUPERUSER PASSWORD 'taiga';" &&\
#             sudo -u postgres createdb -O taiga taiga

# RUN apt-get install -y libxml2-dev libxslt-dev \
#                        python-dev python3-dev python-pip vim virtualenvwrapper supervisor nginx
# RUN pip install pew==0.1.15
# create user taiga
RUN useradd -m -d /home/taiga -p taiga -s /bin/bash taiga
RUN usermod -aG sudo taiga

# fix locale
RUN locale-gen en_US.UTF-8 && dpkg-reconfigure locales
COPY config/locale.gen /etc/locale.gen
RUN echo "LANG=en_US.UTF-8" > /etc/default/locale
RUN echo "LC_TYPE=en_US.UTF-8" > /etc/default/locale
RUN echo "LC_MESSAGES=POSIX" >> /etc/default/locale
RUN echo "LANGUAGE=en" >> /etc/default/locale

# clone backend service
RUN sudo -H -u taiga git clone -b stable --single-branch https://github.com/taigaio/taiga-back.git /home/taiga/taiga-back &&\
   cd /home/taiga/taiga-back && pip install -r requirements.txt
# add configuration files
ADD config/local.py /home/taiga/taiga-back/settings/local.py

# clone frontend
RUN sudo -H -u taiga git clone https://github.com/taigaio/taiga-front-dist.git /home/taiga/taiga-front-dist
ADD config/conf.json /home/taiga/taiga-front-dist/dist/js/conf.json

# nginx configuration
ADD config/nginx-taiga.conf /etc/nginx/conf.d/taiga.conf
RUN rm -f /etc/nginx/conf.d/default.conf
RUN ls -la /etc/nginx/conf.d/

RUN locale-gen en_US.UTF-8 && dpkg-reconfigure locales


ADD scripts/start.sh /usr/local/docker/scripts/start.sh
ADD scripts/main.sh /usr/local/docker/scripts/main.sh
# ADD scripts/init/init.sh /usr/local/docker/scripts/init/init.sh
RUN chmod 755 /usr/local/docker/scripts/start.sh
RUN mkdir /home/taiga/logs
RUN touch /home/taiga/.noready
RUN chown taiga: /home/taiga/.noready

EXPOSE 8000 8888 8080 80

ENV USER root
ENTRYPOINT ["/usr/local/docker/scripts/start.sh"]
