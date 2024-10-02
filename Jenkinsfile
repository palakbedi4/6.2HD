pipeline {
    agent any
/*
    stages {
        stage('Build Docker Image') {
            steps {
                script {
                    // Build Docker image
                    withEnv(["PATH+EXTRA=/usr/local/bin"]) {
                        sh 'docker build -t react-app-image .'
                    }
                }
            }
        }
*/
        stage('Test') {
            steps {
                script {
                    sh 'node seleniumTest.js'
                    }
                }
            }
        }
    }

    post {
        success {
            echo 'Docker image built and tests ran successfully!'
        }
        failure {
            echo 'Build or tests failed!'
        }
    }
}
