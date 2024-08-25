pipeline {
    agent any
        stage('Checkout Code') {
            steps {
                git branch: 'master',
                credentialsId: 'Github-Token',
                url: 'https://github.com/yogamithra06/Capstone-CI-CD.git'
            }
        }
        stage('Build Docker Image') {
            steps {
               sh 'docker build . -t react-app'                
            }
        }                
}
