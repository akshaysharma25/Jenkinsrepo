pipeline {
    agent any
    tools {
        maven "MAVEN3.6.3"
        jdk "JDK11"
    }

     environment {
        NEXUS_VERSION = "nexus3"
        NEXUS_PROTOCOL = "http"
        NEXUS_URL = "172.31.39.240:8081"
        NEXUS_REPOSITORY = "vprofile-repo"
        NEXUS_CREDENTIAL_ID = "nexus"
    }
    stages{
        stage('Fetch code') {
          steps{
              git branch: 'test', url: 'https://github.com/akshaysharma25/Jenkinsrepo'
          }  
        }

        stage('Build') {
            steps {
                sh 'mvn clean install -DskipTests'
            }
            post {
                success {
                    echo "Now Archiving."
                    archiveArtifacts artifacts: '**/*.war'
                }
            }
        }
        stage('Test'){
            steps {
                sh 'mvn test'
            }

        }

        stage('Checkstyle Analysis'){
            steps {
                sh 'mvn checkstyle:checkstyle'
            }
        }

        stage('Sonar Analysis') {
            environment {
                scannerHome = tool 'sonar4.7'
            }
            steps {
               withSonarQubeEnv('sonar') {
                   sh '''${scannerHome}/bin/sonar-scanner -Dsonar.projectKey=vprofile \
                   -Dsonar.projectName=vprofile \
                   -Dsonar.projectVersion=1.0 \
                   -Dsonar.sources=src/ \
                   -Dsonar.java.binaries=target/test-classes/com/visualpathit/account/controllerTest/ \
                   -Dsonar.junit.reportsPath=target/surefire-reports/ \
                   -Dsonar.jacoco.reportsPath=target/jacoco.exec \
                   -Dsonar.java.checkstyle.reportPaths=target/checkstyle-result.xml'''
              }
            }
        }

        stage("UploadArtifact"){
            steps{
                nexusArtifactUploader(
                  nexusVersion: "$NEXUS_VERSION",
                  protocol: 'http',
                  nexusUrl: "$NEXUS_URL",
                  groupId: 'QA',
                  version: "${env.BUILD_ID}",
                  repository: "$NEXUS_REPOSITORY",
                  credentialsId: "$NEXUS_CREDENTIAL_ID",
                  artifacts: [
                    [artifactId: 'vproapp',
                     classifier: '',
                     file: 'target/vprofile-v2.war',
                     type: 'war']
    ]
 )
            }
        }



    }
    
}
