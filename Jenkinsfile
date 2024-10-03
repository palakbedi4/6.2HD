pipeline {
    agent any

    stages {
        stage('Build Docker Image') {
            steps {
                script {
                    // Build Docker image
                    sh 'docker build -t react-app-image .'
                }
            }
        }

        stage('Run Tests') {
            steps {
                script {
                    // Run container, install dependencies and execute tests
                    sh '''
                    docker rm -f react-app-container || true
                    docker run -d --shm-size=1g -p 3000:3000 --name react-app-container react-app-image npm start
                    docker exec react-app-container npm install
                    docker exec react-app-container node /app/seleniumTest.js
                    '''
                }
            }
        }
    }

    post {
        always {
            script {
                // Clean up the Docker container after the test
                sh 'docker stop react-app-container || true'
                sh 'docker rm react-app-container || true'
            }
        }
        success {
            echo 'Tests ran successfully!'
        }
        failure {
            echo 'Build or tests failed!'
        }
    }
}
