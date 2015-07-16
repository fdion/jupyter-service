#!/usr/bin/env bash
set -eu

FILES_DIR=$1

# Abort if python2.7 already installed
if [ -e /usr/local/bin/python2.7 ]; then
    echo "Python2.7 already installed in /usr/local/bin. Exiting."
    exit 0
fi
# The above assumes 3.4 was also installed

export PATH=$PATH:/usr/local/bin

# Python 2.7 altinstall
tar -xzvf $FILES_DIR/Python-2.7.9.tgz
echo Installing Python-2.7.9..
cd Python-2.7.9
make altinstall
python2.7 $FILES_DIR/ez_setup.py
easy_install pip

# Deploy prepackaged Python 2.7 libs
for filename in $FILES_DIR/libs/py27/*.tgz
do
    tar -xzvf $filename -C /usr/local/lib/python2.7/site-packages/
done

cd ..
# Python 3.4 altinstall
tar -xzvf $FILES_DIR/Python-3.4.3.tgz
echo Installing Python-3.4.3..
cd Python-3.4.3
./configure
make altinstall
easy_install-3.4 pip

# Deploy prepackaged Python 3.4 libs
for filename in $FILES_DIR/libs/py34/*.tgz
do
    tar -xzvf $filename -C /usr/local/lib/python3.4/site-packages/
done

# Deploy bin files to /usr/local/bin
cd /usr/local/bin
cp $FILES_DIR/bin/* .
chmod +x *
