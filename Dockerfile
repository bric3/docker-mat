
FROM adoptopenjdk/openjdk8:alpine-slim


# RUN apk --no-cache add curl
RUN wget -qO- "http://eclipse.mirror.garr.it/mirrors/eclipse//mat/1.8.1/rcp/MemoryAnalyzer-1.8.1.20180910-linux.gtk.x86_64.zip" \
    | unzip - 
RUN chmod +x /mat/MemoryAnalyzer /mat/ParseHeapDump.sh

ENV JAVA_OPTS="-Xmx1024m"
VOLUME ["/dump"]

COPY parse-dump.sh .

# docker run -e JAVA_OPTS='-Xmx3g -Xms3g' --mount type=bind,source="$(pwd)",target=/dump dockermat dump.hprof
ENTRYPOINT ["/parse-dump.sh"]
