pipeline {
    agent {
        docker {
            image 'node:18' // Node.js Docker image with npm pre-installed
        }
    }

    stages {
        stage('Install Dependencies') {
            steps {
                echo 'Installing Node.js dependencies...'
                sh 'npm install'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    echo 'Building Docker image...'
                    sh 'docker build -t react-app-image .'
                }
            }
        }

        stage('Test') {
            steps {
                echo 'Running Selenium tests...'
                sh 'node tests/seleniumTest.js' // Ensure this path is correct
            }
        }
    }

    post {
        success {
            echo 'Build and tests ran successfully!'
        }
        failure {
            echo 'Build or tests failed!'
        }
    }
}
