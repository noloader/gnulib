#!/usr/bin/env bash

echo "Installing tools..."

if [ "$TRAVIS_OS_NAME" = "linux" ]
then

    # This should not fail
    sudo apt-get -y install --no-install-recommends make clang gcc autoconf automake autopoint libtool pkg-config 1>/dev/null || true
    # This may fail on older Linux distros
    sudo apt-get -y install --no-install-recommends clang-8 &>/dev/null || true

fi

if [ "$TRAVIS_OS_NAME" = "osx" ]
then

    # Homebrew will fail in unexpected ways, like returning failure when it is up to date.
    brew update || true
    # And it will fail here, too, if there is a package update available???
    brew install make clang autoconf automake autopoint libtool pkg-config 1>/dev/null || true

fi
