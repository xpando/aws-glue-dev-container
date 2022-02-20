#!/bin/bash

GLUE_VERSION=3.0
MAVEN_VERSION=3.8.4

mkdir -p /app/lib/python
mkdir -p /app/lib/java

echo "Downloading aws-glue-libs $GLUE_VERSION"
curl -L https://github.com/awslabs/aws-glue-libs/archive/refs/tags/v$GLUE_VERSION.tar.gz -o /tmp/glue.tgz
(cd /tmp && tar zxf glue.tgz && rm -f glue.tgz)

echo "Packaging Glue Python modules"
(cd /tmp/aws-glue-libs-$GLUE_VERSION && zip -r /app/lib/python/PyGlue.zip awsglue)

echo "Downloading maven $MAVEN_VERSION" 
(cd /tmp && curl -LO https://dlcdn.apache.org/maven/maven-3/3.8.4/binaries/apache-maven-3.8.4-bin.tar.gz)
(cd /opt && tar zxf /tmp/apache-maven-$MAVEN_VERSION-bin.tar.gz && rm -f /tmp/apache-maven-$MAVEN_VERSION-bin.tar.gz)

echo "Downloading Glue $GLUE_VERSION Java libraries"
/opt/apache-maven-$MAVEN_VERSION/bin/mvn -f /tmp/aws-glue-libs-$GLUE_VERSION/pom.xml -DoutputDirectory=/app/lib/java dependency:copy-dependencies

echo "Cleaning up"
rm -rf /tmp/aws-glue-libs-$GLUE_VERSION
rm -rf /opt/apache-maven-$MAVEN_VERSION
