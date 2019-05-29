#!/bin/sh

heapdump_volume=/dump
heapdump=${1}
reports="org.eclipse.mat.api:suspects org.eclipse.mat.api:overview org.eclipse.mat.api:top_components"
# https://wiki.eclipse.org/MemoryAnalyzer/FAQ

function usage() {
    printf '%s\n' \
        "Eclipse MAT in Docker" \
        "Parses Java heap dumps in the command line. Reports will be generated" \
        "in the same folder as the heap dump file." \
        "" \
        "Examples :"
        "  docker run --mount type=bind,source=\"\$(pwd)\",target=/dump docker-mat heapdump.hprof" \
        "  docker run -e JAVA_OPTS='-Xmx4g -Xms4g' --mount type=bind,source=\"\$(pwd)\",target=/dump docker-mat heapdump.hprof" \
        ""
}

[[ -z "${heapdump}" ]] && { usage; exit 1; }
[[ -f "${heapdump_volume}/${heapdump}" ]] && printf "Analyzing %s\n" ${heapdump} || { printf "'${heapdump}' does not exists\n"; exit 1; }


java $JAVA_OPS \
    -jar mat/plugins/org.eclipse.equinox.launcher_*.jar \
    -consolelog \
    -application org.eclipse.mat.api.parse \
    ${heapdump_volume}/${heapdump} \
    ${reports}
