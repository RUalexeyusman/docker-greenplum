# docker-greenplum

## Difference from andruche/greenplum:

JDK 11 and curl is installed.
The pxf DEB package (version 6.9.1) is installed.
The command pxf cluster start has been added to the entrypoint.
PATH to PXF bin files added to /etc/environment.
JAVA_HOME added to /etc/environment.

## Usage
```bash
docker run -it --name gp6 alexeyusman/greenplum_with_pxf:6
```

## Build images



```bash
# ------------------------------ 6 ------------------------------
docker build -t greenplum_with_pxf .

```

