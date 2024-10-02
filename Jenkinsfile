pipeline {
    agent any

    stages {
        stage('Build and Install Dependencies') {
            steps {
                echo 'Building Docker image and installing dependencies...'
                script {
                    // Build Docker image and install dependencies within Docker
                    sh '''
                    docker build -t react-app-image .
                    docker run --name react-app-container -d react-app-image npm install
                    '''
                }
            }
        }

        stage('Run Tests') {
            steps {
                script {
                    // Run Selenium tests inside the container
                    sh '''
                    docker exec react-app-container node seleniumTest.js
                    '''
                }
            }
        }
    }

    post {
        always {
            script {
                // Clean up container after the tests
                sh '''
                docker stop react-app-container
                docker rm react-app-container
                '''
            }
        }
        success {
            echo 'Docker image built and tests ran successfully!'
        }
        failure {
            echo 'Build or tests failed!'
        }
    }
}
