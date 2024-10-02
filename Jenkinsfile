pipeline {
    agent any

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

        stage('Test') {
            steps {
                script {
                    // Run tests inside the Docker container
                    withEnv(["PATH+EXTRA=/usr/local/bin"]) {
                        sh '''
                        docker run -d -p 3000:3000 --name react-app-container react-app-image npm start
                        docker exec react-app-container npm install
                        docker exec react-app-container node seleniumTest.js
                        docker stop react-app-container
                        docker rm react-app-container
                        '''
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
