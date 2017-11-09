#!/bin/sh

set -e

variant="$1"

if test "${variant}" = "linux"; then
    echo "building airmapd dependencies for linux x86-x64"

    CC=/usr/bin/gcc CXX=/usr/bin/g++ ./mason build   boost                    1.63.0
    CC=/usr/bin/gcc CXX=/usr/bin/g++ ./mason publish boost                    1.63.0

    CC=/usr/bin/gcc CXX=/usr/bin/g++ ./mason build   boost_libdate_time       1.63.0
    CC=/usr/bin/gcc CXX=/usr/bin/g++ ./mason publish boost_libdate_time       1.63.0

    CC=/usr/bin/gcc CXX=/usr/bin/g++ ./mason build   boost_libfilesystem      1.63.0
    CC=/usr/bin/gcc CXX=/usr/bin/g++ ./mason publish boost_libfilesystem      1.63.0

    CC=/usr/bin/gcc CXX=/usr/bin/g++ ./mason build   boost_libprogram_options 1.63.0
    CC=/usr/bin/gcc CXX=/usr/bin/g++ ./mason publish boost_libprogram_options 1.63.0

    CC=/usr/bin/gcc CXX=/usr/bin/g++ ./mason build   boost_libsystem          1.63.0
    CC=/usr/bin/gcc CXX=/usr/bin/g++ ./mason publish boost_libsystem          1.63.0

    CC=/usr/bin/gcc CXX=/usr/bin/g++ ./mason build   boost_libtest            1.63.0
    CC=/usr/bin/gcc CXX=/usr/bin/g++ ./mason publish boost_libtest            1.63.0

    CC=/usr/bin/gcc CXX=/usr/bin/g++ ./mason build   boost_libtest            1.63.0
    CC=/usr/bin/gcc CXX=/usr/bin/g++ ./mason publish boost_libtest            1.63.0

    CC=/usr/bin/gcc CXX=/usr/bin/g++ ./mason build   openssl                  1.0.1p
    CC=/usr/bin/gcc CXX=/usr/bin/g++ ./mason publish openssl                  1.0.1p

    CC=/usr/bin/gcc CXX=/usr/bin/g++ ./mason build   protobuf                 3.0.0
    CC=/usr/bin/gcc CXX=/usr/bin/g++ ./mason publish protobuf                 3.0.0
fi


if test "${variant}" = "android-arm-v7"; then
    echo "building airmapd dependencies for android-arm-v7"

    MASON_PLATFORM=android MASON_ANDROID_ABI=arm-v7 ./mason build   boost_libdate_time       1.63.0
    MASON_PLATFORM=android MASON_ANDROID_ABI=arm-v7 ./mason publish boost_libdate_time       1.63.0

    MASON_PLATFORM=android MASON_ANDROID_ABI=arm-v7 ./mason build   boost_libfilesystem      1.63.0
    MASON_PLATFORM=android MASON_ANDROID_ABI=arm-v7 ./mason publish boost_libfilesystem      1.63.0

    MASON_PLATFORM=android MASON_ANDROID_ABI=arm-v7 ./mason build   boost_libprogram_options 1.63.0
    MASON_PLATFORM=android MASON_ANDROID_ABI=arm-v7 ./mason publish boost_libprogram_options 1.63.0

    MASON_PLATFORM=android MASON_ANDROID_ABI=arm-v7 ./mason build   boost_libsystem          1.63.0
    MASON_PLATFORM=android MASON_ANDROID_ABI=arm-v7 ./mason publish boost_libsystem          1.63.0

    MASON_PLATFORM=android MASON_ANDROID_ABI=arm-v7 ./mason build   boost_libtest            1.63.0
    MASON_PLATFORM=android MASON_ANDROID_ABI=arm-v7 ./mason publish boost_libtest            1.63.0

    MASON_PLATFORM=android MASON_ANDROID_ABI=arm-v7 ./mason build   boost_libtest            1.63.0
    MASON_PLATFORM=android MASON_ANDROID_ABI=arm-v7 ./mason publish boost_libtest            1.63.0

    MASON_PLATFORM=android MASON_ANDROID_ABI=arm-v7 ./mason build   openssl                  1.0.1p
    MASON_PLATFORM=android MASON_ANDROID_ABI=arm-v7 ./mason publish openssl                  1.0.1p

    MASON_PLATFORM=android MASON_ANDROID_ABI=arm-v7 ./mason build   protobuf                 3.0.0
    MASON_PLATFORM=android MASON_ANDROID_ABI=arm-v7 ./mason publish protobuf                 3.0.0
fi

if test "${variant}" = "osx"; then
    echo "building airmapd dependencies for osx"

    MASON_PLATFORM=osx ./mason build   boost_libdate_time       1.63.0
    MASON_PLATFORM=osx ./mason publish boost_libdate_time       1.63.0

    MASON_PLATFORM=osx ./mason build   boost_libfilesystem      1.63.0
    MASON_PLATFORM=osx ./mason publish boost_libfilesystem      1.63.0

    MASON_PLATFORM=osx ./mason build   boost_libprogram_options 1.63.0
    MASON_PLATFORM=osx ./mason publish boost_libprogram_options 1.63.0

    MASON_PLATFORM=osx ./mason build   boost_libsystem          1.63.0
    MASON_PLATFORM=osx ./mason publish boost_libsystem          1.63.0

    MASON_PLATFORM=osx ./mason build   boost_libtest            1.63.0
    MASON_PLATFORM=osx ./mason publish boost_libtest            1.63.0

    MASON_PLATFORM=osx ./mason build   boost_libtest            1.63.0
    MASON_PLATFORM=osx ./mason publish boost_libtest            1.63.0

    MASON_PLATFORM=osx ./mason build   openssl                  1.0.1p
    MASON_PLATFORM=osx ./mason publish openssl                  1.0.1p

    MASON_PLATFORM=osx ./mason build   protobuf                 3.0.0
    MASON_PLATFORM=osx ./mason publish protobuf            	    3.0.0
fi


