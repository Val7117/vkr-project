pipeline {
    agent any
    environment {
        GITHUB_TOKEN=credentials('my-github-token')
        IMAGE_NAME='val7117/vkr-project'
        IMAGE_VERSION='0.0.1'
        COSIGN_PASSWORD=credentials('my-cosign-password')
        COSIGN_PRIVATE_KEY=credentials('my-cosign-private-key')
        COSIGN_PUBLIC_KEY=credentials('my-cosign-public-key')
    }
    stages {
        stage('Cleaning up') {
            steps {
                sh 'docker system prune -a --volumes --force'
            }
        }
        stage('Building Docker image') {
            steps {
                sh 'docker build -t $IMAGE_NAME:$IMAGE_VERSION .'
            }
        }
        stage('Login to GitHub Container Registry') {
            steps {
                sh 'echo $GITHUB_TOKEN_PSW | docker login ghcr.io -u $GITHUB_TOKEN_USR --password-stdin'
            }
        }
        stage('Tag Docker image') {
            steps {
                sh 'docker tag $IMAGE_NAME:$IMAGE_VERSION ghcr.io/$IMAGE_NAME:$IMAGE_VERSION'
            }
        }
        stage('Push Docker image') {
            steps {
                sh 'docker push ghcr.io/$IMAGE_NAME:$IMAGE_VERSION'
            }
        }
        stage('Sign Docker image') {
            steps {
                sh 'cosign sign --key $COSIGN_PRIVATE_KEY ghcr.io/$IMAGE_NAME:$IMAGE_VERSION'
            }
        }
        stage('Verify Docker image') {
            steps {
                sh 'cosign verify --key $COSIGN_PRIVATE_KEY ghcr.io/$IMAGE_NAME:$IMAGE_VERSION'
            }
        }
    }
    post {
        always {
            sh 'docker logout'
        }
    }
}