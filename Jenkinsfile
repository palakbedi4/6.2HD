pipeline {
    agent any

    stages {
        stage('Build Docker Image') {
            steps {
                script {
                    withEnv(["PATH+EXTRA=/usr/local/bin"]) {
                        sh 'docker build -t react-app-image .'
                    }
                }
            }
        }
    }
    stage('Test') {
            steps {
                script {
                    // Install dependencies and run Selenium tests
                    sh '''
                    # Install dependencies
                    npm install

                    # Start the app in the background (modify to fit your app's start command)
                    nohup npm start &

                    # Run the Selenium test
                    node seleniumTest.js
                    '''
                }
            }
        }


    post {
        success {
            echo 'Docker image built successfully!'
        }
        failure {
            echo 'Docker image build failed!'
        }
    }
}
