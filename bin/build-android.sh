#!/bin/bash

. ${DRISHTISDK}/bin/build-common.sh

TOOLCHAIN=android-ndk-r10e-api-19-armeabi-v7a-neon-hid-sections

EXTRA_ARGS=""
if [ $# -ge 1 ]; then
    EXTRA_ARGS="--clear"
fi

rename_tab drishti $TOOLCHAIN

COMMAND=(
    "--verbose --fwd ANDROID=TRUE "
    "${DRISHTI_BUILD_ARGS[*]} "
    "${DRISHTI_BUILD_HIDE[*]} "
    "DRISHTI_BUILD_MIN_SIZE=${DRISHTI_BUILD_MIN_SIZE} "
    "${DRISHTI_POLLY_ARGS[*]} "
    "--strip "
    "--jobs 8 "
    "${EXTRA_ARGS} "
)

if [ ${DRISHTI_DO_TESTING} -gt 0 ];
then
    COMMAND+=( "--test" )
fi

eval polly.py --toolchain ${TOOLCHAIN} ${COMMAND[*]}

echo "Finished with status $?" 
