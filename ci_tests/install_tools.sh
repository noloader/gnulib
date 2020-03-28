#!/usr/bin/env bash

echo "Installing tools..."

if [ "$TRAVIS_OS_NAME" = "linux" ]
then

    sudo apt-get -y install --no-install-recommends make clang gcc install autoconf automake autopoint libtool pkg-config 1>/dev/null || true

    # This may fail on older Linux distros
    sudo apt-get -y install --no-install-recommends clang-8 &>/dev/null || true

fi

if [ "$TRAVIS_OS_NAME" = "osx" ]
then

    brew update  || true
    brew install make clang gcc install autoconf automake autopoint libtool pkg-config 1>/dev/null || true

fi
