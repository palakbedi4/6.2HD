pipeline {
    agent any

    stages {
        stage('Build Docker Image') {
            steps {
                script {
                    // Correct PATH handling
                    withEnv(["PATH+EXTRA=/usr/local/bin"]) {
                        sh 'docker build -t react-app-image .'
                    }
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
