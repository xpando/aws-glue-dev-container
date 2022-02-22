#!/bin/bash

MAVEN_VERSION=3.8.4
GLUE_VERSION=3.0
DELTA_LAKE_VERSION=1.0.1

mkdir -p /app/lib/python /app/lib/java

# Need maven to download Glue dependencies
echo "Downloading maven $MAVEN_VERSION" 
(cd /tmp && curl -LO https://dlcdn.apache.org/maven/maven-3/$MAVEN_VERSION/binaries/apache-maven-$MAVEN_VERSION-bin.tar.gz)
(cd /opt && tar zxf /tmp/apache-maven-$MAVEN_VERSION-bin.tar.gz && rm -f /tmp/apache-maven-$MAVEN_VERSION-bin.tar.gz)

echo "Downloading aws-glue-libs $GLUE_VERSION from github"
curl -L https://github.com/awslabs/aws-glue-libs/archive/refs/tags/v$GLUE_VERSION.tar.gz -o /tmp/glue.tgz
(cd /tmp && tar zxf glue.tgz && rm -f glue.tgz)

echo "Packaging Glue Python modules"
(cd /tmp/aws-glue-libs-$GLUE_VERSION && zip -r /app/lib/python/PyGlue.zip awsglue)

echo "Downloading Glue $GLUE_VERSION Java libraries"
/opt/apache-maven-$MAVEN_VERSION/bin/mvn -f /tmp/aws-glue-libs-$GLUE_VERSION/pom.xml -DoutputDirectory=/app/lib/java dependency:copy-dependencies

echo "Downloading Delta Lake $DELTA_LAKE_VERSION Java libraries"
curl -L https://repo1.maven.org/maven2/io/delta/delta-core_2.12/$DELTA_LAKE_VERSION/delta-core_2.12-$DELTA_LAKE_VERSION.jar \
         -o /app/lib/java/delta-core_2.12-$DELTA_LAKE_VERSION.jar

echo "Cleaning up"
rm -rf /root/.m2
rm -rf /opt/apache-maven-$MAVEN_VERSION
rm -rf /tmp/aws-glue-libs-$GLUE_VERSION

# Remove jars distributed with aws-glue-libs that conflict with Spark 3.1.1 dependencies
rm -f /app/lib/java/antlr*
rm -f /app/lib/java/netty-3.10.5.Final.jar
rm -f /app/lib/java/netty-codec*
rm -f /app/lib/java/netty-common*
rm -f /app/lib/java/netty-handler*
rm -f /app/lib/java/netty-nio*
rm -f /app/lib/java/netty-resolver*
rm -f /app/lib/java/netty-transport*
