pipeline {
    agent any

    environment {
        DOCKER_IMAGE = 'react-app-image'
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
                echo 'Building Docker Image...'
                sh 'docker build -t $DOCKER_IMAGE .'
            }
        }

        stage('Run Node Tests') {
            steps {
                echo 'Running Selenium tests...'
                sh 'node tests/seleniumTest.js'
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
