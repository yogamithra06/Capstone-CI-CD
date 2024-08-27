pipeline {
    agent any

    stages {
        stage('Checkout Code') {
            steps {
               git branch: 'dev', credentialsId: 'Github-Token', url: 'https://github.com/yogamithra06/Capstone-CI-CD.git'
            }
        }
        stage('Build Docker Image') {
            steps {
                sh 'docker build . -t react-app'
            }
        }
        stage('Push to Docker Hub') {
            steps {
               withCredentials([string(credentialsId: 'Dockerhub', variable: 'DockerhubPAT')]) 
                {
                 sh 'docker login -u dockeruser06 -p $DockerhubPAT'
                 sh 'docker tag react-app dockeruser06/dev/react-app:dev'
                 sh 'docker push dockeruser06/dev/react-app:dev'
                }
            }
        }
    }
}
