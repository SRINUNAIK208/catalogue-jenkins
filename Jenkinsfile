pipeline {
    agent {
        label "AGENT-1"
    }
    environment {
        appVersion = ''
        REGION = 'us-east-1'
        ACCOUNT_ID = '824333137275'
        PROJECT = 'roboshop'
        COMPONENT = 'catalogue'
    }
    options {
        timeout(time: 30, unit: 'MINUTES')
        disableConcurrentBuilds()
    }

    stages {
        stage ('Read package.json') {
            steps {
                script {
                   def packageJson = readJSON file: 'package.json'
                   def appVersion = packageJson.version
                   echo "package version: ${appVersion}"
                }

            }
        }
        stage ('install dependencies') {
            steps {
                script {
                    sh """
                       npm install
                       echo "dependencies installed"
                    """
                }
            }
        }
         stage ('Docker build') {
            steps {
                script {
                    withAWS(credentials: 'aws-credentials', region: 'us-east-1') {
                        sh """
                          aws ecr get-login-password --region ${REGION} | docker login --username AWS --password-stdin ${ACCOUNT_ID}.dkr.ecr.us-east-1.amazonaws.com
                          docker build -t ${ACCOUNT_ID}.dkr.ecr.us-east-1.amazonaws.com/${PROJECT}/${COMPONENT}:${appVersion} .
                          docker push ${ACCOUNT_ID}.dkr.ecr.us-east-1.amazonaws.com/${PROJECT}/${COMPONENT}:${appVersion}
                        """
                    }
                }
            }
        }
    

   
        stage('Build') {
            steps{
                script {
                  sh """
                     echo "hello"
                  """
                }
            }
        }
     }
}