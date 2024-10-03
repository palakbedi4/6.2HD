pipeline {
    agent any

    stages {
        stage('Install Node.js') {
            steps {
                echo 'Installing Node.js...'
                sh '''
                    if [ "$(uname)" = "Linux" ]; then
                        # For Debian-based Linux
                        if [ -f /etc/debian_version ]; then
                            curl -sL https://deb.nodesource.com/setup_18.x | bash -
                            apt-get install -y nodejs
                        # For RedHat-based Linux
                        elif [ -f /etc/redhat-release ]; then
                            curl -sL https://rpm.nodesource.com/setup_18.x | bash -
                            yum install -y nodejs
                        fi
                    elif [ "$(uname)" = "Darwin" ]; then
                        # For MacOS
                        brew install node
                    else
                        echo "Unsupported OS"
                        exit 1
                    fi

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
                    echo 'Building Docker image...'
                    sh 'docker build -t react-app-image .'
                }
            }
        }

        stage('Test') {
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
