#!/bin/sh

set -e

variant=${1}

if [ "${variant}" -eq "linux" ]; then
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

    CC=/usr/bin/gcc CXX=/usr/bin/g++ ./mason build   protobuf                 3.3.0
    CC=/usr/bin/gcc CXX=/usr/bin/g++ ./mason publish protobuf            	  3.3.0
fi


if [ "${variant}" -eq "android-arm-v7" ]; then
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

    MASON_PLATFORM=android MASON_ANDROID_ABI=arm-v7 ./mason build   protobuf                 3.3.0
    MASON_PLATFORM=android MASON_ANDROID_ABI=arm-v7 ./mason publish protobuf            	 3.3.0
fi


