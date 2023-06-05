FROM openjdk:8-jdk 
WORKDIR /

COPY cdap-ui-6.9.0.tar.gz /home/
RUN tar -xvzf /home/cdap-ui-6.9.0.tar.gz && \ 
    mkdir -p /opt/cdap/ui && \
    mkdir -p /etc/cdap/conf && \
    cp -r cdap-cdap-ui-6.9.0/* /opt/cdap/ui/ && \
    cp /opt/cdap/ui/VERSION /opt/cdap/
# RUN  cp /opt/cdap/ui/server_dist/index.js /opt/cdap/ui/ && \
#      cp -r /opt/cdap/ui/server_dist/graphql /opt/cdap/ui/ && \
#      cp -r /opt/cdap/ui/server_dist/server /opt/cdap/ui/

RUN apt-get update && \
  apt-get -y install libxml2-utils vim && \
  apt-get upgrade -y

COPY cdap.json /etc/cdap/conf/cdap.json
COPY cdap-site.xml /etc/cdap/conf/cdap-site.xml

RUN export PATH=$PATH:/opt/cdap/ui/bin/node

COPY startup.sh startup.sh

EXPOSE 11011

RUN groupadd -g 1000 cdap
RUN useradd -m -u 1000 -g 1000 cdap
RUN mkdir /data
RUN chown 1000:1000 /data
RUN chmod 766 /data
RUN chmod +x startup.sh
ENTRYPOINT [ "./startup.sh" ]
