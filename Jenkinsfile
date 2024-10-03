pipeline {
    agent any

    environment {
        DOCKER_IMAGE = 'react-app-image'
    }

    stages {
        stage('Build Docker Image') {
            steps {
                script {
                    // Build the Docker image using the provided Dockerfile
                    sh 'docker build -t $DOCKER_IMAGE .'
                }
            }
        }

        stage('Run Tests') {
            steps {
                script {
                    // Start the app in a container
                    sh 'docker run -d -p 3000:3000 --name react-app-container $DOCKER_IMAGE'

                    // Install additional dependencies inside the container
                    sh 'docker exec react-app-container npm install'

                    // Run Selenium tests inside the container
                    sh 'docker exec react-app-container node tests/seleniumTest.js'
                }
            }
        }
    }

    post {
        success {
            echo 'Build and tests ran successfully!'
        }
        failure {
            echo 'Build or tests failed!'
            script {
                // Clean up the container if the build or tests fail
                sh 'docker stop react-app-container || true'
                sh 'docker rm react-app-container || true'
            }
        }
    }
}
