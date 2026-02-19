# docker-greenplum




## Difference from andruche/greenplum:

* JDK 11 and curl is installed.
* The pxf DEB package is installed.
* The command pxf cluster start has been added to the entrypoint.
* PATH to PXF bin files added to /etc/environment.
* JAVA_HOME added to /etc/environment.

## Usage
```bash
docker run -it --name gp6 alexeyusman/greenplum_with_pxf:6.6.9.1
```


## Build images

```bash
# ------------------------------ 6 ------------------------------
cd 6_with_pxf
docker buildx build --platform linux/amd64  --build-arg PXF_VERSION=6.9.1 -t alexeyusman/greenplum_with_pxf:6.6.9.1 .
```

