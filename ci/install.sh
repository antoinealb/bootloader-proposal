#!/usr/bin/env bash

# Make the script fail if any command in it fail
set -e

python3.5 -m venv env --without-pip
source env/bin/activate
python --version
wget https://bootstrap.pypa.io/get-pip.py
python get-pip.py
pip install cvra-packager~=1.0.0

case $BUILD_TYPE in
    tests)
        # Install cpputest
        pushd ..
        wget "https://github.com/cpputest/cpputest/releases/download/v3.8/cpputest-3.8.tar.gz" -O cpputest.tar.gz
        tar -xzf cpputest.tar.gz
        cd cpputest-3.8/
        ./configure --prefix=$HOME/cpputest
        make
        make install
        popd
        ;;

    client-tests)
        pushd client
        python setup.py install
        popd
        ;;

    *)
        echo "Unknown build type $BUILD_TYPE"
        exit 1
        ;;
esac
