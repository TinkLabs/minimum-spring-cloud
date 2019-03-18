# minimum-spring-cloud
including the minimum module for b2c spring-cloud

### version 

* Spring-boot: 2.1.1.RELEASE
* Spring-cloud: Greenwich.M1
* Java : 1.8

### modules

* Spring-boot-starter-web
* Spring-boot-starter-consul-config
* Spring-boot-starter-consul-discovery

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

for consul, using ttl as health check

### docker

This project contain a Dockerfile and entrypoint.

### Spring profile
* dev
* local
* staging
* uat
* product

the default profile is `dev`, config in application.yml

### Codepipe

a buildspec.yml with s3 cache enable for maven 


### Usage

You can use the `create.sh` script to create a project base on this minimum dependence.

navigate to this project directory and use the following command, and follow the tip ,input the project name, group id, artifact id ,project location and project package.

    ./create.sh  