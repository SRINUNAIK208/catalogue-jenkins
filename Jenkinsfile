@Library('jenkins-shared-libraries')_

def configMap = [
    project : "roboshop",
    component : "catalogue"
]
//simplepipeline.call(configMap)  
if( ! env.BRANCH_NAME.equalsIgnoreCase('main')){
   nodeEkspipeline.call(configMap)
}
else {
   echo "proces with PROD process"
}
