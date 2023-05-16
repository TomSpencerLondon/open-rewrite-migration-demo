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

### About Open Rewrite
This video is quite good for running the migrations:
https://www.youtube.com/watch?v=d8xU24x7Jqo
Tim te Beeks birthday is on 26 or 27 May.

### Major migrations over the past decade
- 2011 Java 7:
```text
try (Resource closeable = new Resource() { ... }
List<String> diamonds = new ArrayList<>();
java.nio.file.Path
```
- 2014 Java 8:
```text
(Integer x, Integer y) -> { return x + y; }
LocalDate releaseDate = LocalDate.of(2014, 3, 18);
```
- 2014 Spring Boot 1.0:
```text
Jar not war
Opinionated
Non functionals
No XML
```
- 2015 Building Microservices, Sam Newman:
```text
Decomposition
Communication & failures
NoSQL
Kubernetes 1.0
```
- 2017 Junit 5:
```text
@BeforeEach...
@Rule -> Extension
@RunWith -> @ExtendWith
assertThrows(Exception.class, () -> validate(invalidArgument))
```
- 2018 Java 11:
```text
List.of()
var
HttpClient
```
~~java.xml.ws~~
~~java.xml.bind~~

- 2018 Spring Boot 2.0:
~~Java 7~~
```text
Configuration Property Binding
WebFlux
Micrometer.io
Spring Data, Security, Cloud, Messaging, ...
```
- 2019 Github + Gitlab:
```text
Github buys Dependabot
WhiteSource buys Renovate
Increased awareness
```
- 2021 Java 17:
```text
Text blocks
record Point (int x, int y) {}
if (object instance of Integer i) { }
return switch(...) { ... }
--add-exports jdk.compiler/com.sun.tools.javac.api=ALL-UNNAMED
```
- 2022 vulnerabilities:
```text
Log4Shell
Spring4Shell
```
- 2022 Spring Boot 3.0:
```text
Java 17 baseline
Jakarta EE 9
Kotlin 1.6
Groovy 4.0
Gradle 7.3
```
This talk by Juergen Hoeller on Spring Framework 6:
https://www.youtube.com/watch?v=ikQ06uwro1M

He also did a talk on the history of Spring in 15 mins (actually 24 mins):
https://www.youtube.com/watch?v=qNDMvyUfkpA

All these developments show that change is the only constant. It is exciting when new versions come out but some of the work can be repetitive.

### OpenRewrite
This is quite useful for a list of OpenRewrite recipes:
https://docs.openrewrite.org/recipes/java

OpenRewrite promises to make migrations easy. You can upgrade Java, Frameworks and also migrate between frameworks.
It was started at Netflix for internal logging framework -> SLF4J. This required transformation. They turned source code into
an Abstract Syntax tree parser and minipulation. This produces minimal changes.

The same developers worked on Spinnaker. Spinnaker is an open-source, multi-cloud continuous delivery platform that combines a powerful and flexible pipeline management system with integrations to the major cloud providers.
They used the same parse to move from Spring Boot 1.x -> 2.x, JUnit 4 -> JUnit 5. The project is now open sourced on the Apache License 2.0.
This is the company behind OpenRewrite:
https://www.moderne.io/

The tool has recipes for:
- Java
- XML
- Groovy
- YAML
- Maven
- Gradle
- JUnit5
- AssertJ
- Spring
- Micronaut
- Quarkus
- Terraform
- Kubernetes

### Abstract Syntax Tree
There are other parsers like the Java parser. An Abstract Syntax Tree is a tree data structure that best represents the syntactic structure of source code.
It helps understand type attribution and format preservation.

This video is quite useful for understanding Abstract Syntax Trees:
https://www.youtube.com/watch?v=tM_S-pa4xDk

![image](https://github.com/TomSpencerLondon/LeetCode/assets/27693622/c853cf55-3564-4951-9f53-2fad4c716344)

This is a representation of the Abstract Syntax Tree above in JSON:
```json
{
  "type": "BinaryExpression",
  "left": {
    "type": "NumericLiteral",
    "value": 2
  },
  "operator": "+",
  "right": {
    "type": "BinaryExpression",
    "left": {
      "type": "NumericLiteral",
      "value": 4
    },
    "operator": "*",
    "right": {
      "type": "NumericLiteral",
      "value": 10
    }
  }
}
```

This site is useful for looking at ASTs in practice:
https://astexplorer.net/

You can put source code in there and then see the node selected in the Tree.

This link from openrewrite is quite informative on how to create your own OpenRewrite recipes:
https://docs.openrewrite.org/authoring-recipes

