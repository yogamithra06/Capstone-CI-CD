pipeline {
    agent any
    triggers{
        githubPush()
    }
    stages {
        stage('Checkout Code') {
            steps {
                git branch: 'master', credentialsId: 'Github-Token', url: 'https://github.com/yogamithra06/Capstone-CI-CD.git'
            }
        }
        stage('Build Docker Image') {
            steps {
                script {
                    sh 'docker build . -t react-app'
                }
            }
        }      
        stage('Push Docker Image') {          
            steps {
                script {
                    def branchName = github.context.ref.split('/')[-1]
                    if (branchName == "master") {
                        withCredentials([string(credentialsId: 'Dockerhub', variable: 'DockerhubPAT')]) {
                            sh 'docker login -u dockeruser06 -p $DockerhubPAT'
                            sh 'docker tag react-app dockeruser06/prod/react-app:prod'
                            sh 'docker push dockeruser06/prod/react-app:prod'
                        }
                    } else if (branchName == "dev") {
                        withCredentials([string(credentialsId: 'Dockerhub', variable: 'DockerhubPAT')]) {
                            sh 'docker login -u dockeruser06 -p $DockerhubPAT'
                            sh 'docker tag react-app dockeruser06/dev/react-app:dev'
                            sh 'docker push dockeruser06/dev/react-app:dev'
                        }
                    }
                }
            }
        }
    }
}
