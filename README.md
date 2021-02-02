# Gradle Publish Package Action

## Overview

This action can be used in a Github workflow of a Gradle project
to publish a package (e.g. to Github Packages).

It will run the Gradle tasks in a Java 11 environment.

## Usage

Your project will need to be a Gradle project, with the `gradlew` script in the
root folder. Make sure `gradlew` is executable.

Use this action within a Github workflow. For example:

**`.github/workflows/publish.yml`**

```
name: Publish package to GitHub Packages

on:
  push:
    branches:
      - main

jobs:
  publish:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      - uses: university-of-york/esg-action-gradle-publish-package@1.0.0
        env:
          GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
```

By default, this action will run the tasks 

```clean check publish --refresh-dependencies```

Optionally, you can specify an alternative list of Gradle tasks to run:

```
      - uses: university-of-york/esg-action-gradle-publish-package@1.0.0
        with:
          tasks: clean build publish
```

This action assumes that `build.gradle` has been configured to publish a package
[(e.g. to Github Packages)](https://docs.github.com/en/actions/guides/publishing-java-packages-with-gradle#publishing-packages-to-github-packages)

```
publishing {
    repositories {
        maven {
            name = "Github"
            url = uri("https://maven.pkg.github.com/university-of-york/<package name>")
            credentials {
                username = System.getenv("GITHUB_ACTOR")
                password = System.getenv("GITHUB_TOKEN")
            }
        }
    }
    publications {
        maven(MavenPublication) {
            from components.java
            artifact sourcesJar
        }
    }
}
```