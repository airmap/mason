#!/usr/bin/env bash

MASON_NAME=Qt
MASON_VERSION=system
MASON_SYSTEM_PACKAGE=true

. ${MASON_DIR:-~/.mason}/mason.sh

QT_LIBS=(${2:-QtCore})

# Qt5 libs are called Qt5*, so we have to use the correct name to pkg-config
QT_VERSION_MAJOR=$(qmake -query QT_VERSION | cut -d. -f1)
if [ ${QT_VERSION_MAJOR} -gt 4 ] ; then
    QT_LIBS=${QT_LIBS[@]/#Qt/Qt${QT_VERSION_MAJOR}}
fi

for LIB in ${QT_LIBS} ; do
    if ! `pkg-config ${LIB} --exists` ; then
        mason_error "Can't find ${LIB}"
        exit 1
    fi
done

function mason_system_version {
    pkg-config QtCore --modversion
}

function mason_build {
    :
}

# pkg-config on OS X returns "-framework\ QtCore", which results in invalid arguments.
function cleanup_args {
    python -c "import sys, re; print re.sub(r'(-framework)\\\\', r'\\1', ' '.join(sys.argv[1:]))" "$@"
}

function mason_cflags {
    echo ${MASON_CFLAGS} $(cleanup_args `pkg-config ${QT_LIBS[@]} --cflags`)
}

function mason_ldflags {
    echo ${MASON_LDFLAGS} $(cleanup_args `pkg-config ${QT_LIBS[@]} --libs`)
}

mason_run "$@"
