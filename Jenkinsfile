pipeline {
  agent any
  environment {
    EVENT_STORE = [ 'master': 'pull_request', 'dev': 'push' ]
    GITHUB_TOKEN = credentials('github-token')
  }    
    stages {
        stage('Checkout Code') {
            steps {
                git(git branch: 'master', credentialsId: 'Github-Token', url: 'https://github.com/yogamithra06/Capstone-CI-CD.git')                
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
                   for (branch in env.EVENT_STORE) {
                    def event = env.EVENT_STORE[branch]                  
                    if (event == 'pull_request' && branch == 'master') {
                        withCredentials([string(credentialsId: 'Dockerhub', variable: 'DockerhubPAT')]) {
                            sh 'docker login -u dockeruser06 -p $DockerhubPAT'
                            sh 'docker tag react-app dockeruser06/prod/react-app:prod'
                            sh 'docker push dockeruser06/prod/react-app:prod'
                        }
                    } 
                    else if (event == 'push' && branch == 'dev') {
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
}
