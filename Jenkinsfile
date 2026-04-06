pipeline {
    agent {
        label "AGENT-1"
    }
    environment {
        appVersion = ''
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