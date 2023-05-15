# We update our JDK to now use Java 17'

function wrap {
	echo
	echo $ $(printf "%q " "$@")
	read -p ""
	eval $(printf "%q " "$@")
	read -p "
	OK
"
}

wrap jenv global 17

wrap cd spring-petclinic

echo '# We delete the cobertura maven plugin as it is not incompatible
'
wrap ./mvnw -U org.openrewrite.maven:rewrite-maven-plugin:4.45.0:run \
 -Drewrite.recipeArtifactCoordinates=org.openrewrite.recipe:rewrite-migrate-java:1.21.1 \
  -Drewrite.activeRecipes=org.openrewrite.java.migrate.cobertura.RemoveCoberturaMavenPlugin

echo '# We run ./mvnw verify
# This is to check the tests'

wrap ./mvnw verify

clear
echo '# We run ./mvnw spring-boot:run
# This is to run the application'

wrap ./mvnw spring-boot:run

echo '
# And with a final commit, we complete the migration.'
wrap git commit -a -m "Spring Boot 2.7 on Java 17"
