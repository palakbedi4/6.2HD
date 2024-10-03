pipeline {
    agent any

    environment {
        DOCKER_IMAGE = 'react-app-image'
    }

        stage('Install Node.js') {
            steps {
                script {
                    // Install Node.js only if not present
                    sh '''
                    if ! [ -x "$(command -v node)" ]; then
                        echo "Node.js not found, installing..."
                        curl -sL https://deb.nodesource.com/setup_18.x | bash -
                        apt-get install -y nodejs
                    else
                        echo "Node.js is already installed"
                    fi
                    node -v
                    npm -v
                    '''
                }
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
