#!/usr/bin/env bash

# Run Gradle tasks to publish a package

# Use the supplied list of Gradle tasks to run if given
# or if not use a default list of Gradle tasks
DEFAULT_TASK_LIST="clean check publish --refresh-dependencies"
TASK_LIST=${1:-$DEFAULT_TASK_LIST}

./gradlew $TASK_LIST
