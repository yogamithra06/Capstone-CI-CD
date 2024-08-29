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
                sshagent(['ec2-ssh-key']) {
                    sh """
                    ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null ec2-user@3.83.43.244 << EOF
                    docker login -u dockeruser06 -p $DockerhubPAT
                    docker pull dockeruser06/${dockerImageTag}:${dockerImageTag}
                    docker stop container-name || true
                    docker rm container-name || true
                    docker run -d --name react-image -p 80:80 dockeruser06/${dockerImageTag}:${dockerImageTag}
                    EOF
                    """
                }
            }
        }        
    }
}
