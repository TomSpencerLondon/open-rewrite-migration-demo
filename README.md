### Open Rewrite: Migrations Made easier

We can run our open rewrite migration from Spring 1.5 to 2.7 by using the scripts:
- demo.sh
- demo-part2.sh

In order to run the scripts we should have jenv installed. Alternatively, you could edit the script to use
sdkman if you prefer.

The main edits we have to do to the POM after downloading spring-petclinic are change wro4j to 1.9 and add jaxb:

```xml
<?xml version="1.0" encoding="UTF-8"?>
<project xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xmlns="http://maven.apache.org/POM/4.0.0"
         xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/maven-v4_0_0.xsd">
    <modelVersion>4.0.0</modelVersion>
    <groupId>org.springframework.samples</groupId>
    <artifactId>spring-petclinic</artifactId>
    <version>1.5.1</version>

    <parent>
        <groupId>org.springframework.boot</groupId>
        <artifactId>spring-boot-starter-parent</artifactId>
        <version>2.6.14</version>
    </parent>
    <name>petclinic</name>

    <properties>

        <!-- Generic properties -->
        <java.version>17</java.version>
        <project.build.sourceEncoding>UTF-8</project.build.sourceEncoding>
        <project.reporting.outputEncoding>UTF-8</project.reporting.outputEncoding>

        <!-- Web dependencies -->
        <webjars-bootstrap.version>3.3.6</webjars-bootstrap.version>
        <webjars-jquery-ui.version>1.11.4</webjars-jquery-ui.version>
        <webjars-jquery.version>2.2.4</webjars-jquery.version>
        <wro4j.version>1.9.0</wro4j.version>

        <cobertura.version>2.7</cobertura.version>

    </properties>
    <dependencies>
        <!-- https://mvnrepository.com/artifact/javax.xml.bind/jaxb-api -->
        <dependency>
            <groupId>javax.xml.bind</groupId>
            <artifactId>jaxb-api</artifactId>
            <version>2.3.1</version>
        </dependency>

       <dependency>
          <groupId>javax.xml.bind</groupId>
          <artifactId>jaxb-api</artifactId>
          <version>2.2.12</version>
      </dependency>
    </dependencies>
</project>
```

### About 