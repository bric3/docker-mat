
FROM adoptopenjdk/openjdk8:alpine-slim
ARG MAT_VERSION=1.8.1
ARG MAT_BUILD_DATE=20180910

# RUN apk --no-cache add curl
RUN wget -qO- "http://eclipse.mirror.garr.it/mirrors/eclipse//mat/${MAT_VERSION}/rcp/MemoryAnalyzer-${MAT_VERSION}.${MAT_BUILD_DATE}-linux.gtk.x86_64.zip" \
    | unzip - 
RUN chmod +x /mat/MemoryAnalyzer /mat/ParseHeapDump.sh

ENV JAVA_OPTS="-Xmx1024m"
VOLUME ["/dump"]

ADD parse-dump.sh /

# docker run -e JAVA_OPTS='-Xmx3g -Xms3g' --mount type=bind,source="$(pwd)",target=/dump dockermat dump.hprof
ENTRYPOINT ["/parse-dump.sh"]
