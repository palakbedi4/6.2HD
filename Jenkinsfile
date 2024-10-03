pipeline {
    agent any

    stages {
        stage('Install Node.js') {
            steps {
                echo 'Installing Node.js...'
                sh '''
                curl -sL https://deb.nodesource.com/setup_18.x | bash -
                apt-get install -y nodejs
                node -v
                npm -v
                '''
            }
        }

        stage('Install Dependencies') {
            steps {
                echo 'Installing Node.js dependencies...'
                sh 'npm install'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    // Build the Docker image using the provided Dockerfile
                    sh 'docker build -t react-app-image .'
                }
            }
        }

        stage('Test') {
            steps {
                echo 'Running Selenium tests...'
                sh 'node tests/seleniumTest.js' // Ensure that the path to your test file is correct
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
