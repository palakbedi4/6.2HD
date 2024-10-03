pipeline {
    agent any

    environment {
        DOCKER_IMAGE = 'react-app-image'
        DOCKER_CONTAINER_NAME = 'react-app-container'
    }

    stages {
        stage('Checkout') {
            steps {
                echo 'Checking out the repository...'
                checkout scm
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
                echo 'Building Docker Image...'
                sh 'docker build -t $DOCKER_IMAGE .'
            }
        }

        stage('Run App in Docker') {
            steps {
                script {
                    echo 'Running app in Docker container...'
                    // Remove any existing container with the same name
                    sh 'docker rm -f $DOCKER_CONTAINER_NAME || true'
                    
                    // Run the app in Docker with memory limits
                    sh '''
                    docker run -d -p 3000:3000 --memory="1g" --name $DOCKER_CONTAINER_NAME $DOCKER_IMAGE npm start
                    '''
                }
            }
        }

        stage('Run Selenium Tests in Docker') {
            steps {
                script {
                    echo 'Running Selenium tests...'
                    // Here we run Selenium tests inside the Docker container
                    // assuming Chrome and ChromeDriver are already installed within the image
                    sh '''
                    docker exec $DOCKER_CONTAINER_NAME npm install --only=dev
                    docker exec $DOCKER_CONTAINER_NAME npm run selenium-test
                    '''
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
                // Print Docker logs if the build fails
                sh 'docker logs $DOCKER_CONTAINER_NAME'
            }
        }
        always {
            echo 'Cleaning up Docker...'
            // Clean up the container after the job
            sh 'docker rm -f $DOCKER_CONTAINER_NAME || true'
        }
    }
}
