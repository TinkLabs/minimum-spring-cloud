#!/usr/bin/env bash

set -e


echo Pls,input the project name: projectName=
read projectName

echo Pls,input the groupId: groupId=
read groupId

echo Pls,input the artifactId: artifactId=
read artifactId

echo Pls,input the location of project: location=
read location

echo Pls,input the package of proejct: package=
read package

if [[ -z "$projectName" ]]; then
	echo error projectName
	exit 1
fi

if [[ -z "$groupId" ]]; then
    echo error group id
    exit 1
fi


if [[ -z "$artifactId" ]]; then
    echo error artifact id
    exit 1
fi

if [[ -z "$location" ]]; then
    echo error location
    exit 1
fi

if [[ -z "$package" ]]; then
    echo error package
    exit 1
fi
echo will create project  ${projectName} at ${location} with groupId ${groupId}, artifactId ${artifactId} and pacakge ${package}

projectDir=${location}/${projectName}

s="."
r="/"
fpackage=${package//$s/$r}


mkdir -p ${projectDir}

p=${projectDir}/src/main/java/${fpackage}

echo ${p}

mkdir -p ${p} && mkdir -p ${projectDir}/src/main/resources && mkdir -p ${projectDir}/src/test/java

cp src/main/java/com/handy/transaction/platform/Application.java ${p}/

echo "package $package;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
public class Application {

	public static void main(String[] args) {
		SpringApplication.run(Application.class, args);
	}

}
" > ${p}/Application.java


cp buildspec.yml ${projectDir}/
cp Dockerfile ${projectDir}/
cp entrypoint.sh ${projectDir}/
cp mvnw ${projectDir}/
cp mvnw.cmd ${projectDir}/
cp -R src/main/resources/* ${projectDir}/src/main/resources

touch ${projectDir}/pom.xml

pom=${projectDir}/pom.xml

echo "<?xml version=\"1.0\" encoding=\"UTF-8\"?>
<project xmlns=\"http://maven.apache.org/POM/4.0.0\" xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\"
		 xsi:schemaLocation=\"http://maven.apache.org/POM/4.0.0 http://maven.apache.org/xsd/maven-4.0.0.xsd\">
	<modelVersion>4.0.0</modelVersion>
	<parent>
		<groupId>org.springframework.boot</groupId>
		<artifactId>spring-boot-starter-parent</artifactId>
		<version>2.1.1.RELEASE</version>
		<relativePath/> <!-- lookup parent from repository -->
	</parent>" >> ${pom}

echo "	<groupId>$package</groupId>" >> ${pom}
echo "	<artifactId>$artifactId</artifactId>" >> ${pom}
echo "	<version>0.0.1-SNAPSHOT</version>" >> ${pom}
echo "	<name>$projectName</name>" >> ${pom}

echo "	<properties>
		<java.version>1.8</java.version>
		<spring-cloud.version>Greenwich.M1</spring-cloud.version>
		<docker.image.prefix>b2c</docker.image.prefix>
	</properties>

	<dependencies>
		<dependency>
			<groupId>org.springframework.boot</groupId>
			<artifactId>spring-boot-starter-web</artifactId>
		</dependency>
		<dependency>
			<groupId>org.springframework.cloud</groupId>
			<artifactId>spring-cloud-starter-consul-config</artifactId>
		</dependency>
		<dependency>
			<groupId>org.springframework.cloud</groupId>
			<artifactId>spring-cloud-starter-consul-discovery</artifactId>
		</dependency>
		<dependency>
			<groupId>org.springframework.boot</groupId>
			<artifactId>spring-boot-starter-test</artifactId>
			<scope>test</scope>
		</dependency>
	</dependencies>

	<dependencyManagement>
		<dependencies>
			<dependency>
				<groupId>org.springframework.cloud</groupId>
				<artifactId>spring-cloud-dependencies</artifactId>
				<version>\${spring-cloud.version}</version>
				<type>pom</type>
				<scope>import</scope>
			</dependency>
		</dependencies>
	</dependencyManagement>


	<build>
		<plugins>
			<plugin>
				<groupId>org.springframework.boot</groupId>
				<artifactId>spring-boot-maven-plugin</artifactId>
			</plugin>
			<plugin>
				<groupId>com.spotify</groupId>
				<artifactId>dockerfile-maven-plugin</artifactId>
				<version>1.4.9</version>
				<configuration>
					<repository>\${docker.image.prefix}/\${project.artifactId}</repository>
				</configuration>
			</plugin>
		</plugins>
	</build>

	<repositories>
		<repository>
			<id>spring-milestones</id>
			<name>Spring Milestones</name>
			<url>https://repo.spring.io/milestone</url>
			<snapshots>
				<enabled>false</enabled>
			</snapshots>
		</repository>
	</repositories>
</project>" >> ${pom}


echo "Done"