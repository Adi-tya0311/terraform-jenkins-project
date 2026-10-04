pipeline {
    agent any

    stages {

        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Verify Files') {
            steps {
                sh 'ls -la'
            }
        }

        stage('SonarQube Analysis') {
            steps {
                script {
                    def scannerHome = tool 'sonar-scanner'

                    withSonarQubeEnv('SonarQube') {
                        sh "${scannerHome}/bin/sonar-scanner"
                    }
                }
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t devops-portfolio .'
            }
        }

        stage('Login to ECR') {
            steps {
                withCredentials([usernamePassword(
                    credentialsId: 'aws-creds',
                    usernameVariable: 'AWS_ACCESS_KEY_ID',
                    passwordVariable: 'AWS_SECRET_ACCESS_KEY'
                )]) {
                    sh '''
                        aws ecr get-login-password --region ap-south-1 |
                        docker login --username AWS --password-stdin \
                        667747482015.dkr.ecr.ap-south-1.amazonaws.com
                    '''
                }
            }
        }

        stage('Tag Image') {
            steps {
                sh '''
                    docker tag devops-portfolio:latest \
                    667747482015.dkr.ecr.ap-south-1.amazonaws.com/devops-portfolio:latest
                '''
            }
        }

        stage('Push Image') {
            steps {
                sh '''
                    docker push \
                    667747482015.dkr.ecr.ap-south-1.amazonaws.com/devops-portfolio:latest
                '''
            }
        }

        stage('Verify ECR Image') {
            steps {
                withCredentials([usernamePassword(
                    credentialsId: 'aws-creds',
                    usernameVariable: 'AWS_ACCESS_KEY_ID',
                    passwordVariable: 'AWS_SECRET_ACCESS_KEY'
                )]) {
                    sh '''
                        IMAGE_DIGEST=$(aws ecr describe-images \
                        --repository-name devops-portfolio \
                        --image-ids imageTag=latest \
                        --region ap-south-1 \
                        --query 'imageDetails[0].imageDigest' \
                        --output text)

                        echo "ECR Image Digest: $IMAGE_DIGEST"

                        if [ -z "$IMAGE_DIGEST" ] || [ "$IMAGE_DIGEST" = "None" ]; then
                            echo "ERROR: Image was not found in ECR!"
                            exit 1
                        fi

                        echo "ECR image verification successful."
                    '''
                }
            }
        }

        stage('Deploy') {
            steps {
                withCredentials([usernamePassword(
                    credentialsId: 'aws-creds',
                    usernameVariable: 'AWS_ACCESS_KEY_ID',
                    passwordVariable: 'AWS_SECRET_ACCESS_KEY'
                )]) {
                    sh '''
                        aws ecr get-login-password --region ap-south-1 |
                        docker login --username AWS --password-stdin \
                        667747482015.dkr.ecr.ap-south-1.amazonaws.com

                        docker pull \
                        667747482015.dkr.ecr.ap-south-1.amazonaws.com/devops-portfolio:latest

                        docker rm -f devops-app || true

                        docker run -d \
                        --name devops-app \
                        -p 80:80 \
                        667747482015.dkr.ecr.ap-south-1.amazonaws.com/devops-portfolio:latest
                    '''
                }
            }
        }
    }
}