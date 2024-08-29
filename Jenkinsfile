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
        stage('Deploy to EC2') {
            steps {
                script{
                    sh "docker stop react-image || true"
                    sh "docker rm react-image || true"
                   def dockerCmd = "docker run -d --name react-image -p 80:80 -d dockeruser06/${dockerImageTag}:${dockerImageTag}"                
                   sshagent(['Deployment-server']) {                    
                    sh "ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -o \"BatchMode=yes\" ec2-user@3.83.43.244 ${dockerCmd}"
                    }
                }
            }
        }        
    }
}
