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

The OpenRewrite tool has two advantages:
1. Exact type preservation
2. Format preservation - changes will look like a colleague worked on your code

### OpenRewrite Recipes
OpenRewrite offers recipes like lego building blocks for search and refactoring operations. Recipes consist of standalone operations
and can be linked together. We can change types, methods and dependencies and plugins.

The Recipes follow a Visitor pattern to match and modify elements. This is an example of a Recipe:
https://docs.openrewrite.org/concepts-explanations/recipes
```java
public class ChangeType extends Recipe {

    private final String oldFullyQualifiedTypeName;
    private final String newFullyQualifiedTypeName;

    // Recipe configuration is injected via the constructor
    @JsonCreator
    public ChangeType(
        @JsonProperty("oldFullyQualifiedTypeName") String oldFullyQualifiedTypeName, 
        @JsonProperty("newFullQualifiedTypeName") String newFullQualifiedTypeName
    ) {
        this.oldFullyQualifiedTypeName = oldFullyQualifiedTypeName;
        this.newFullQualifiedTypeName = newFullQualifiedTypeName;
    }

    @Override
    protected JavaVisitor<ExecutionContext> getVisitor() {
        // Construct an instance of a visitor that will operate over the LSTs.
        return new ChangeTypeVisitor(oldFullyQualifiedTypeName, newFullyQualifiedTypeName);
    }

    // In many cases, the visitor is implemented as a private, inner class. This
    // ensures that the visitor is only used via its managed, configured recipe. 
    private class ChangeTypeVisitor extends JavaVisitor<ExecutionContext> {
        // ...
    }

}
```
This is an example of a JUnit5Migration:
```java
package org.example.testing;

import org.openrewrite.java.ChangeType;

public class JUnit5Migration extends Recipe {

    public JUnit5Migration(boolean addJunit5Dependencies) {
        // Add nested recipes to the execution pipeline via doNext()
        doNext(new ChangeType("org.junit.Test", "org.junit.jupiter.api.Test"));
        doNext(new AssertToAssertions());
        doNext(new RemovePublicTestModifiers());

        // Recipe can be optionally configured to add the JUnit 5 dependencies
        if (addJUnitDependencies) {
            doNext(new AddJUnit5Dependencies());
        }
    }
}
```
This is a JUnit5 recipe in yaml:
```yaml
type: specs.openrewrite.org/v1beta/recipe
name: org.openrewrite.java.testing.junit5.JUnit4To5Migration
recipeList:
  - org.openrewrite.java.ChangeType:
    oldFullyQualifiedTypeName: org.junit.Test
    newFullyQualifiedTypeName: org.junit.jupiter.api.Test
  - org.openrewrite.java.testing.junit5.UpdateBeforeAfterAnnotations
  - org.openrewrite.java.testing.junit5.AssertToAssertions
  - org.openrewrite.java.testing.junit5.StaticImports
  - org.openrewrite.java.testing.junit5.ExpectedExceptionToAssertThrows
```

This video is quite interesting on using OpenRewrite with OpenAI:
https://www.youtube.com/watch?v=4NOFBgrVuEM

### Modules
Modules tie together the recipes into LegoSets for a specific purpose and offer a complete migration.

### Running Recipes
1. Apply OpenRewrite plugin
2. With Module dependency
3. Run migration recipe

```bash
./mvnw org.openrewrite.maven:rewrite-maven-plugin:4.24.0:run \
  -Drewrite.recipeArtifactCoordinates=org.openrewrite.recipe:rewrite-spring:4.21.0
  -DactiveRecipes=org.openrewrite.java.spring.boot2.SpringBoot1To2Migration
```

### Petclinic Migration
The scripts in this repo migrate PetClinic:
- SpringBoot 1.5.x -> 2.x
- Java 8 -> Java 17
- JUnit 4 -> JUnit 5

We can run the script on our computer if we have jenv installed. We may prefer SDKMan. As mentioned above,
the main edits we have to do to the POM after downloading spring-petclinic are change wro4j to 1.9 and add jaxb:

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

### Note on wrap command in script

This Bash function, named wrap, does a few things. It's likely intended to be used as a debugging or learning tool. Here's a breakdown of the steps in the function:
echo: This command is used to print something to the standard output (usually the terminal). In this case, it just prints a newline.
echo $ $(printf "%q " "$@"): This line prints the command that is going to be executed. The $@ variable in bash refers to all command line arguments passed to the function or script. The printf "%q " "$@" command will safely quote these arguments if necessary. The echo command then prints these quoted arguments, preceded by a $ character, which would represent how the command would look if you ran it in the terminal.
read -p "": This line is waiting for the user to press Enter before the command is executed.
eval $(printf "%q " "$@"): This line executes the command. The eval command in bash allows you to execute arbitrary commands. It's using printf again to ensure that arguments are safely quoted. This is especially important when using eval since it can execute any command.
read -p "\nOK\n": After the command has executed, this line prints "OK" and then waits for the user to press Enter again.
In summary, this function will:
- Print the command it's going to execute
- Wait for the user to press Enter
- Execute the command
- Print "OK" and then wait for the user to press Enter again 

- It provides a way of manually stepping through each command, so you can see what each command is doing. This can be useful when debugging a complex script, or when learning how bash scripts work.

### OpenRewrite Applications
As well as migrating versions we can also migrate from one framework to another. We can switch from Log4J to SLF4J and JUnit to AssertJ.
We can reduce technical debt with recipes. We can also enforce code style. We can also add custom recipes.

### Spring Boot Migrator
Spring Boot Migrator aims to help developers move from non Spring Boot applications to Spring Boot. It provides recipes for automated migrations.
It starts by creating an HTML report.

This link is useful for running the spring boot jar upgrade jar:
https://github.com/spring-projects-experimental/spring-boot-migrator

This is what the report looks like for our starting position on Spring 1.5:
![image](https://github.com/TomSpencerLondon/LeetCode/assets/27693622/13b55f71-1dae-4b73-a524-e606bd08c43b)

The SpringBoot migrator jar is on the same link:
https://github.com/spring-projects-experimental/spring-boot-migrator
![image](https://github.com/TomSpencerLondon/LeetCode/assets/27693622/7fbe7fd6-4852-4c6f-9544-6b09a15ae042)

We can then decide if we want to run the recipes.

### Moderne
The company behind openrewrite is Moderne:
https://www.moderne.io/

OpenRewrite has office hours with Tim Te Beek also:
![image](https://github.com/TomSpencerLondon/LeetCode/assets/27693622/2ea9cc8e-c262-470e-9eb6-359d8226969e)

### Links:
- docs.openrewrite.org
- github.com/openrewrite
- github.com/spring-projects-experimental/spring-boot-migrator
- app.moderne.io

This is Tim te Beek's blog post:
https://blog.jdriven.com/2022/03/major-migrations-made-easy-with-openrewrite/


### Spring Boot Migrator (continued)
This video is quite interesting from Fabian Krueger the Spring Boot Migrator lead:
https://www.youtube.com/watch?v=qkgdjIsNYA0

#### The Problem - Software Migration / Modernization
Examples:
- JEE to Spring Boot
- Legacy Spring (XML) to Boot
- Mulesoft to Spring Integration

Problems:
- Mainly mapping programming models
- Repetitive
- Costly


#### The Problem - Introduce Spring Modules
Examples:
- Spring Cloud Config Server
- Spring Cloud Contract
- Resilience

Problems:
- Often requires solid understanding
- Problems sometimes hard to find

#### The Problem - Upgrades
Examples:
- Every 2 - 4 weeks a minor Spring Framework release
- Every 6 month a new Java version
- Every year a new Spring Framework major release

Problems:
- Short release cycles require frequent upgrades
- Not upgrading implies security risks and technical debt
- cumbersome
- No immediate business value

#### Automation
Solution for the above problems should include automation. Mission:
```text
Spring Boot Migrator (SBM) aims to help developers upgrade or migrate to Spring Boot by providing recipes for automated migrations
```
SBM replaced JavaParser with OpenRewrite from Jonathan Schneider.

The main migration we are interested in here is:
- Spring Boot 2.7 -> 3.0 Upgrade

The spring boot migrator can take commands from a text file with:
```bash
java -jar spring-boot-migrator.jar @commands.txt
```
where commands.txt is the file where you keep the commands:
