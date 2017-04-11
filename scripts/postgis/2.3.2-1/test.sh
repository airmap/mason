#!/usr/bin/env bash

set -ue
set -o pipefail

: '
Assumes gdal and postgis have been linked

'

if [[ ${PGDATA:-unset} != "unset" ]] || [[ ${PGHOST:-unset} != "unset" ]] || [[ ${PGTEMP_DIR:-unset} != "unset" ]]; then
    echo "ERROR: this script deletes \${PGDATA}, \${PGHOST}, and \${PGTEMP_DIR}."
    echo "So it will not run if you have these set in your environment"
    exit 1
fi

export PATH=$(./mason prefix postgis 2.3.2-1)/bin:$PATH

# must be absolute
export GDAL_DATA=$(./mason prefix gdal 2.1.3)/share/gdal


# make sure we can init, start, create db, and stop
export PGDATA=./local-postgres
# PGHOST must start with / so therefore must be absolute path
export PGHOST=$(pwd)/local-unix-socket
export PGTEMP_DIR=$(pwd)/local-tmp
export PGPORT=1111

# cleanup
function cleanup() {
    if [[ -d ${PGDATA} ]]; then rm -r ${PGDATA}; fi
    if [[ -d ${PGTEMP_DIR} ]]; then rm -r ${PGTEMP_DIR}; fi
    if [[ -d ${PGHOST} ]]; then rm -r ${PGHOST}; fi
    rm -f postgres.log
    rm -f seattle_washington_water_coast*
    rm -f seattle_washington.water.coast*
}

function setup() {
    mkdir ${PGTEMP_DIR}
    mkdir ${PGHOST}
}

function finish {
  pg_ctl -w stop
  cleanup
}

trap finish EXIT

cleanup
setup

initdb

postgres -k $PGHOST > postgres.log &
sleep 2
cat postgres.log
createdb template_postgis
psql -l
psql template_postgis -c "CREATE TABLESPACE temp_disk LOCATION '${PGTEMP_DIR}';"
psql template_postgis -c "SET temp_tablespaces TO 'temp_disk';"
psql template_postgis -c "CREATE EXTENSION postgis;"
psql template_postgis -c "CREATE EXTENSION postgis_sfcgal;"
psql template_postgis -c "SELECT PostGIS_Full_Version();"
curl -OL "https://s3.amazonaws.com/metro-extracts.mapzen.com/seattle_washington.water.coastline.zip"
unzip -o seattle_washington.water.coastline.zip
createdb test-osm -T template_postgis
shp2pgsql -s 4326 seattle_washington_water_coast.shp coast | psql test-osm
psql test-osm -c "SELECT ST_StraightSkeleton(ST_GeomFromText('MULTIPOLYGON(((-71.1031880899493 42.3152774590236,-71.1031627617667 42.3152960829043,-71.102923838298 42.3149156848307,-71.1023097974109 42.3151969047397,-71.1019285062273 42.3147384934248,-71.102505233663 42.3144722937587,-71.10277487471 42.3141658254797,-71.103113945163 42.3142739188902,-71.10324876416 42.31402489987,-71.1033002961013 42.3140393340215,-71.1033488797549 42.3139495090772,-71.103396240451 42.3138632439557,-71.1041521907712 42.3141153348029,-71.1041411411543 42.3141545014533,-71.1041287795912 42.3142114839058,-71.1041188134329 42.3142693656241,-71.1041112482575 42.3143272556118,-71.1041072845732 42.3143851580048,-71.1041057218871 42.3144430686681,-71.1041065602059 42.3145009876017,-71.1041097995362 42.3145589148055,-71.1041166403905 42.3146168544148,-71.1041258822717 42.3146748022936,-71.1041375307579 42.3147318674446,-71.1041492906949 42.3147711126569,-71.1041598612795 42.314808571739,-71.1042515013869 42.3151287620809,-71.1041173835118 42.3150739481917,-71.1040809891419 42.3151344119048,-71.1040438678912 42.3151191367447,-71.1040194562988 42.3151832057859,-71.1038734225584 42.3151140942995,-71.1038446938243 42.3151006300338,-71.1038315271889 42.315094347535,-71.1037393329282 42.315054824985,-71.1035447555574 42.3152608696313,-71.1033436658644 42.3151648370544,-71.1032580383161 42.3152269126061,-71.103223066939 42.3152517403219,-71.1031880899493 42.3152774590236)),((-71.1043632495873 42.315113108546,-71.1043583974082 42.3151211109857,-71.1043443253471 42.3150676015829,-71.1043850704575 42.3150793250568,-71.1043632495873 42.315113108546)))',4326)) from coast limit 1;" > out.txt