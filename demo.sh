#!/bin/bash

# Quick run through start to finish without prompt/clear
#function read { echo "read"; }
#function clear { echo "clear"; }

function wrap {
	echo
	echo $ $(printf "%q " "$@")
	read -p ""
	eval $(printf "%q " "$@")
	read -p "
	OK
"
}

echo '# First we clone the petclinic repository'
wrap git clone git@github.com:spring-projects/spring-petclinic.git

clear
echo '# Next we start a new branch from the 1.5.x tag of the Spring PetClinic project'
wrap cd spring-petclinic
git reset --hard
git clean -f
git checkout main
! git branch -D openrewrite-migration-demo
git switch -c openrewrite-migration-demo 1.5.x
git log -n 1
echo '
# You can see the last commit was in 2017'
read -p ""

echo '
# Next we ensure we are running Java 8 for now.'
wrap jenv global 1.8

echo '# Then we upgrade the Maven wrapper for compatibility, and to add some color.'
wrap ./mvnw wrapper:wrapper -Dmaven=3.8.7


echo '# And we commit the results to have a clean slate.'
wrap git commit -a -m 'Spring Boot 1.5 on Java 8'

clear

echo '# Next we add the OpenRewrite plugin to our pom.xml.
# This works much the same as the Apache Maven wrapper,
# in that you can use the plugin to install the plugin.
'
wrap ./mvnw org.openrewrite.maven:rewrite-maven-plugin:4.36.0:init

echo '# We can see the plugin added to our pom.xml file.
'
wrap git --no-pager diff pom.xml

clear
echo '# We will migrate the Spring PetClinic to Spring Boot 2.
# These recipes are in the added Rewrite Spring Module.
'
#       <dependency>
#          <groupId>javax.xml.bind</groupId>
#          <artifactId>jaxb-api</artifactId>
#          <version>2.2.12</version>
#      </dependency>

wrap ./mvnw org.openrewrite.maven:rewrite-maven-plugin:4.36.0:run \
       -Drewrite.recipeArtifactCoordinates=org.openrewrite.recipe:rewrite-spring:4.29.0 \
       -DactiveRecipes=org.openrewrite.java.spring.boot2.SpringBoot1To2Migration

wrap echo "# Notice how each file lists the changes made by recipes."

clear
echo '# Our application has now been upgraded to 2.x.
# In our application code we can see quite some revelant changes.
'
echo '# - Hibernate validator has been replaced with Javax.'
wrap git --no-pager diff src/main/java/org/springframework/samples/petclinic/model/Person.java

echo '# - Unnecessary @AutoWired annotations have been removed.'
wrap git --no-pager diff src/main/java/org/springframework/samples/petclinic/vet/VetController.java

echo '# - and web parameter arguments have also been removed.'
wrap git --no-pager diff src/main/java/org/springframework/samples/petclinic/owner/PetController.java

wrap echo '# These types of changes will make your application FEEL more recent'


clear
echo '# Our application.properties have also been updated.
# - Database initialization properties have been moved.
# - Actuator properties have also undergone changes.'
wrap git --no-pager diff src/main/resources/


clear
echo '# Our pom.xml file now contains updated plugins and dependencies'
wrap git --no-pager diff pom.xml


echo '# Our tests have also been migrated to JUnit 5,
# with similar changes to what we have seen before.
'
#clear
#echo '# Our tests have also been migrated to JUnit 5.
# - Our imports have been converted as you would expect.
# - Notice how Mockito now uses the extension.
# - Our test life cycle annotations have been converted.
# - Visibility modifiers are only removed where applicable.
# - Expected exceptions have been converted into assertThrows.'
#wrap git --no-pager diff src/test/java/org/springframework/samples/petclinic/owner/PetTypeFormatterTests.java


echo '# Satisfied with our changes, we commit the results.'
wrap git commit -a -m "Spring Boot 2.7 on Java 8"

clear
echo '# Next we will upgrade to Java 17 using a different module.
# The Migrate Java module contains recipes to adopt new language features.'

wrap ./mvnw -U org.openrewrite.maven:rewrite-maven-plugin:4.45.0:run \
  -Drewrite.recipeArtifactCoordinates=\
org.openrewrite.recipe:rewrite-migrate-java:1.21.1 \
  -DactiveRecipes=\
org.openrewrite.java.migrate.JavaVersion17

echo '# - The compiler source and target versions are updated.'
wrap git --no-pager diff pom.xml

echo '# Individually, these might be simple changes.
# But by automating these changes, we can run them at scale,
# to upgrade our entire application landscape in minutes.
# Now we have to change two test expectations
# For this we have to run ./mvnw verify separately to find the errors'