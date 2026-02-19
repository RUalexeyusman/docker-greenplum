# Global ARG (optional, can be overridden by --build-arg)
ARG PXF_VERSION=6.10.1

# ---- builder stage ----
FROM andruche/greenplum:6 AS builder

# Redeclare ARG to make it available in this stage
ARG PXF_VERSION

RUN apt update && \
    apt install -y openjdk-11-jdk golang-1.23 git libcurl4-openssl-dev

# Install ginkgo (optional, needed for tests?)
RUN /usr/lib/go-1.23/bin/go install github.com/onsi/ginkgo/ginkgo@v1.16.5

# Clone the specific release branch
RUN git -c http.sslVerify=false clone \
        https://git.angara.cloud/gbgreenplum/greenplum-db/pxf.git \
        -b release-${PXF_VERSION} \
        --single-branch \
        pxf

# Build PXF and create .deb package
RUN source /usr/local/gpdb/greenplum_path.sh && \
    export PATH="/usr/lib/go-1.23/bin:$PATH" && \
    export JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64 && \
    export LANG=en_US.UTF-8 && export LC_ALL=en_US.UTF-8 && \
    cd pxf && make && make deb && pwd && ls -latr build/pxf-gp*

# ---- final stage ----
FROM andruche/greenplum:6

# Redeclare ARG again
ARG PXF_VERSION

# Copy the built .deb from builder stage
COPY --from=builder /opt/pxf/build/pxf-gp6-${PXF_VERSION}-1-ubuntu18.04-amd64.deb \
     /tmp/pxf-gp6-${PXF_VERSION}-1-ubuntu18.04-amd64.deb

RUN apt update && apt install -y \
        curl \
        openjdk-11-jdk \
    && rm -rf /var/lib/apt/lists/* \
    && dpkg -i /tmp/pxf-gp6-${PXF_VERSION}-1-ubuntu18.04-amd64.deb \
    && rm -f /tmp/pxf-gp6-${PXF_VERSION}-1-ubuntu18.04-amd64.deb \
    && echo "PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin:/usr/local/pxf-gp6/bin" > /etc/environment \
    && echo "JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64" >> /etc/environment \
    && chown -R gpadmin:gpadmin /usr/local/pxf-gp6 \
    && cp /usr/local/pxf-gp6/gpextable/pxf.control /usr/local/gpdb/share/postgresql/extension/pxf.control 

ADD entrypoint.sh /
RUN chmod +x /entrypoint.sh
CMD ["/entrypoint.sh"]