pipeline {
    agent any
    triggers{
        githubPush()
    }
    stages {
        stage('Checkout Code') {
            steps {
                git branch: "${GIT_BRANCH}", credentialsId: 'Github-Token', url: 'https://github.com/yogamithra06/Capstone-CI-CD.git'
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
                    def branchName = env.GIT_BRANCH.split('/')[-1]
                    def dockerImageTag = branchName == "master" ? "prod" : "dev"
                    withCredentials([string(credentialsId: 'Dockerhub', variable: 'DockerhubPAT')]) {
                     sh "docker login -u dockeruser06 -p $DockerhubPAT"
                     sh "docker tag react-app dockeruser06/${dockerImageTag}:${dockerImageTag}"
                     sh "docker push dockeruser06/${dockerImageTag}:${dockerImageTag}"
                    }
                }
            }
        }
    }
}
