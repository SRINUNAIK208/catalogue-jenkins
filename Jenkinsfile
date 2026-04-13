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
    parameters{
        booleanParam(name: 'deploy', defaultValue: false, description: 'Toggle this value')
    }

    stages {
        stage ('Read package.json') {
            steps {
                script {
                   def packageJson = readJSON file: 'package.json'
                   appVersion = packageJson.version
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
          stage ('UNIT TESTING') {
            steps {
                script {
                    sh """
                       echo "unit testing"
                    """
                }
            }
        }
         stage ('Docker build') {
            steps {
                script {
                    withAWS(credentials: 'aws-auth', region: 'us-east-1') {
                        sh """
                          aws ecr get-login-password --region ${REGION} | docker login --username AWS --password-stdin ${ACCOUNT_ID}.dkr.ecr.us-east-1.amazonaws.com
                          docker build -t ${ACCOUNT_ID}.dkr.ecr.us-east-1.amazonaws.com/${PROJECT}/${COMPONENT}:${appVersion} .
                          docker push ${ACCOUNT_ID}.dkr.ecr.us-east-1.amazonaws.com/${PROJECT}/${COMPONENT}:${appVersion}
                        """
                    }
                }
            }

        }
        stage("Trigger deploy"){
            when{
                expression { param.deploy }
            }
            steps{
                script{
                   build job: 'catalogue-cd',
                   parameters: [
                     string(name: 'appVersion', value: "${appVersion}")
                     string(name:'deploy_to', value: 'dev')
                   ],
                   propagate: false,
                   wait: false
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