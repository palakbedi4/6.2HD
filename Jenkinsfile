pipeline {
    agent any

    stages {
        stage('Build Docker Image') {
            steps {
                script {
                    // Build the Docker image using the Dockerfile in the project
                    sh 'docker build -t react-app-image .'
                }
            }
        }
    }

    post {
        success {
            echo 'Docker image built successfully!'
        }
        failure {
            echo 'Docker image build failed!'
        }
    }
}
