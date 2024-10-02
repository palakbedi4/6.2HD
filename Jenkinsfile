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
                    // Set the correct PATH for npm
                    withEnv(["PATH=/usr/local/bin:$PATH"]) {
                        // Install dependencies and run Selenium tests
                        sh '''
                        npm install
                        nohup npm start &
                        node seleniumTest.js
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
