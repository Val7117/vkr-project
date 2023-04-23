pipeline {
    agent any
    environment {
        NAME='val7117/vkr-project'
        VERSION='0.0.1'
        IMAGE_NAME="${NAME}:${VERSION}-${BUILD_NUMBER}"
        GHCR_IMAGE_NAME="ghcr.io/${IMAGE_NAME}"
        GITHUB_TOKEN=credentials('my-github-token')
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
                sh "docker build -t ${IMAGE_NAME} ."
            }
        }
        stage('Scan') {
            steps {
                sh "grype ${IMAGE_NAME} --scope AllLayers --fail-on=critical"
            }
        }
        stage('Login to GitHub Container Registry') {
            steps {
                sh "echo ${GITHUB_TOKEN_PSW} | docker login ghcr.io -u ${GITHUB_TOKEN_USR} --password-stdin"
            }
        }
        stage('Tag Docker image') {
            steps {
                sh "docker tag ${IMAGE_NAME} ${GHCR_IMAGE_NAME}"
            }
        }
        stage('Push Docker image') {
            steps {
                sh "docker push ${GHCR_IMAGE_NAME}"
            }
        }
        stage('Sign Docker image') {
            steps {
                sh "cosign sign --yes --key ${COSIGN_PRIVATE_KEY} ${GHCR_IMAGE_NAME}"
            }
            post {
                success {
                    build job: 'verify-push-to-private', parameters: [string(name: 'GHCR_IMAGE_NAME', value: "${GHCR_IMAGE_NAME}")]
                }
            }
        }
    }
    post {
        always {
            sh 'docker logout'
        }
    }
}