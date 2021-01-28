# Gradle Publish Package Action

## Overview

This action can be used in a Github workflow of a Gradle project
to publish a package to Github Packages.

## Usage

Use this action within a Github workflow, e.g. `.github/workflows/publish.yml`

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
      - uses: university-of-york/esg-action-gradle-publish-package
        with:
          gradle-tasks: wrapper clean check publish
        env:
          GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
```

Your project will need to be a Gradle project, with the `gradlew` script in the
root folder (make sure it is executable), and with `build.gradle`
[configured for publishing to Github Packages](https://docs.github.com/en/actions/guides/publishing-java-packages-with-gradle#publishing-packages-to-github-packages). 

Example:

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