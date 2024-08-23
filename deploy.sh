#!/bin/bash
if [[ $GIT_BRANCH == "origin/dev" ]]; then
    # Build your project
    sh 'chmod +x build.sh'
    sh './build.sh'
    docker login -u dockeruser06 -p $DOCKER_PASSWORD
    docker tag react-app dockeruser06/dev/react-app:v1
    docker push dockeruser06/dev

elif [[ $GIT_BRANCH == "origin/main" ]]; then
    sh 'chmod +x build.sh'
    sh './build.sh'
    docker login -u dockeruser06 -p $DOCKER_PASSWORD
    docker tag react-app dockeruser06/prod/react-app:v1
    docker push dockeruser06/prod
fi