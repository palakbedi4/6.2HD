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

        stage('Run Selenium Tests') {
            steps {
                script {
                    echo 'Running Selenium tests...'
                    // Install necessary dependencies for Selenium (like Chrome, ChromeDriver)
                    sh '''
                    apt-get update
                    apt-get install -y wget curl unzip xvfb
                    wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | apt-key add -
                    sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list'
                    apt-get update
                    apt-get install -y google-chrome-stable
                    CHROME_VERSION=$(google-chrome --version | grep -oP '\\d+\\.\\d+\\.\\d+')
                    wget -O /tmp/chromedriver.zip "https://chromedriver.storage.googleapis.com/$CHROME_VERSION/chromedriver_linux64.zip"
                    unzip /tmp/chromedriver.zip -d /usr/local/bin/
                    rm /tmp/chromedriver.zip
                    ln -sf /usr/local/bin/chromedriver /usr/bin/chromedriver
                    '''

                    // Start the Selenium tests inside the Docker container
                    sh '''
                    docker exec $DOCKER_CONTAINER_NAME xvfb-run -a node tests/seleniumTest.js
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
