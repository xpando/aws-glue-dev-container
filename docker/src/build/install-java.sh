#!/bin/bash

# No version 8 corretto that includes a JDK in the yum repos so download and install ourselves

CORRETTO_VERSION=8.322.06.2

echo "Installing Amazon Corretto JDK $CORRETTO_VERSION"

mkdir -p /opt/java
cd /opt/java
curl -LO https://corretto.aws/downloads/resources/$CORRETTO_VERSION/amazon-corretto-$CORRETTO_VERSION-linux-x64.tar.gz
tar zxf amazon-corretto-$CORRETTO_VERSION-linux-x64.tar.gz
rm -f amazon-corretto-$CORRETTO_VERSION-linux-x64.tar.gz

JAVA_HOME=/opt/java/amazon-corretto-$CORRETTO_VERSION-linux-x64
java_bins=(java javac)

for java_bin in ${java_bins[@]}; do
    echo "Setting $java_bin..."
    update-alternatives --install /usr/bin/$java_bin $java_bin $JAVA_HOME/bin/$java_bin 1
    update-alternatives --set $java_bin $JAVA_HOME/bin/$java_bin
done

echo "Done."