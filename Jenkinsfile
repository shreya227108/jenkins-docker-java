pipeline {
    agent any

    environment {
        DOCKER_HUB_REPO = 'shreya227108/java-app'   // replace with your actual Docker Hub repo
        DOCKER_HUB_CREDENTIALS = 'dockerhub-credentials' // Jenkins credentials ID for Docker Hub
    }

    stages {
        stage('Checkout Code') {
            steps {
                echo 'Cloning GitHub repository...'
                checkout scm
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    echo 'Building Docker image...'
                    sh 'docker build -t $DOCKER_HUB_REPO .'
                }
            }
        }

        stage('Login to Docker Hub') {
            steps {
                script {
                    echo 'Logging into Docker Hub...'
                    withCredentials([usernamePassword(credentialsId: "$DOCKER_HUB_CREDENTIALS", usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD')]) {
                        sh 'echo $PASSWORD | docker login -u $USERNAME --password-stdin'
                    }
                }
            }
        }

        stage('Push Docker Image') {
            steps {
                script {
                    echo 'Pushing image to Docker Hub...'
                    sh 'docker push $DOCKER_HUB_REPO'
                }
            }
        }

        stage('Clean Up') {
            steps {
                script {
                    echo 'Cleaning up local Docker images...'
                    sh 'docker rmi $DOCKER_HUB_REPO || true'
                }
            }
        }
    }

    post {
        success {
            echo 'Build and push successful!'
        }
        failure {
            echo 'Build failed!'
        }
    }
}
