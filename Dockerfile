
FROM adoptopenjdk/openjdk8:alpine
ARG MAT_VERSION=1.8.1
ARG MAT_BUILD_DATE=20180910

RUN wget -qO- "http://eclipse.mirror.garr.it/mirrors/eclipse//mat/${MAT_VERSION}/rcp/MemoryAnalyzer-${MAT_VERSION}.${MAT_BUILD_DATE}-linux.gtk.x86_64.zip" \
    | unzip - 
RUN chmod +x /mat/MemoryAnalyzer /mat/ParseHeapDump.sh
RUN apk add --no-cache ttf-dejavu

ENV JAVA_OPTS="-Xmx1024m"
VOLUME ["/dump"]

ADD parse-dump.sh /

ENTRYPOINT ["/parse-dump.sh"]
