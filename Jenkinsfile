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
    }
}