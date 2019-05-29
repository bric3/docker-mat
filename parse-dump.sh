#!/bin/sh

heapdump_volume=/dump
heapdump=${1}
reports="org.eclipse.mat.api:suspects org.eclipse.mat.api:overview org.eclipse.mat.api:top_components"
# https://wiki.eclipse.org/MemoryAnalyzer/FAQ


[[ -f "${heapdump_volume}/${heapdump}" ]] && printf "Analyzing %s\n" ${heapdump} || { printf "'${heapdump}' does not exists\n"; exit 1; }


java $JAVA_OPS \
    -jar mat/plugins/org.eclipse.equinox.launcher_*.jar \
    -consolelog \
    -application org.eclipse.mat.api.parse \
    ${heapdump_volume}/${heapdump} \
    ${reports}
