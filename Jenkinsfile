pipeline {
    agent any
    
    environment {
        // Define a variable for the Docker image name
        IMAGE_NAME = 'myapp/task'
    }
    
    stages {
        stage('Build') {
            steps {
                script {
                    // Build the Docker image
                    echo 'Building Docker image...'
                    
                    sh 'docker build -t $IMAGE_NAME .'

                }
            }
        }
    }
    
    post {
        always {
            echo 'Cleaning up the workspace...'
            cleanWs()
        }
    }
}
