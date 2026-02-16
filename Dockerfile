FROM andruche/greenplum:6

ADD pxf-gp6-6.9.1-1-ubuntu22.04-amd64.deb /tmp/
RUN apt update && apt install -y \
    curl \
    openjdk-11-jdk \
    &&  rm -rf /var/lib/apt/lists/* \
    &&  dpkg -i /tmp/pxf-gp6-6.9.1-1-ubuntu22.04-amd64.deb \
    && rm -f /tmp/pxf-gp6-6.9.1-1-ubuntu22.04-amd64.deb \
    && echo PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin:/usr/local/pxf-gp6/bin" > /etc/environment \ 
    && echo JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64 >> /etc/environment \
    && sudo cp /usr/local/pxf-gp6/gpextable/pxf.control /usr/local/gpdb/share/postgresql/extension/pxf.control
ADD entrypoint.sh /
RUN chmod +x /entrypoint.sh
CMD ["/entrypoint.sh"]


