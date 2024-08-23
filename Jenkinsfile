pipeline {
    agent any
    stages {
        stage('Build and Push Docker Image to DOckerhub') {
            steps {
                // Grant executable permissions to the deploy script
                sh 'chmod +x deploy.sh'

                // Execute deploy script
                sh './deploy.sh'               
            }
        }
    }
}