pipeline {
    agent any
 
    tools {
        maven 'Maven3'
        jdk   'Java21'
    }
 
    environment {
        APP_NAME   = 'myapp'
        TOMCAT_DIR = '/var/lib/tomcat9/webapps'
    }
 
    stages {
 
        stage('Clone Code from GitHub') {
            steps {
                git branch: 'main', url: 'https://github.com/Arhamm17/Jenkins-Dashboard.git'
            }
        }
 
        stage('Build WAR') {
            steps {
                sh 'mvn clean package -DskipTests'
            }
        }
 
        stage('Deploy to Tomcat') {
            steps {
                sh '''
                    # Remove old version
                    rm -rf ${TOMCAT_DIR}/${APP_NAME}
                    rm -f  ${TOMCAT_DIR}/${APP_NAME}.war
 
                    # Copy new WAR
                    cp target/*.war ${TOMCAT_DIR}/${APP_NAME}.war
 
                    echo "Deployed build #${BUILD_NUMBER} at $(date)"
                '''
            }
        }
 
    }
 
    post {
        success {
            echo "Build ${BUILD_NUMBER} deployed successfully!"
        }
        failure {
            echo "Build ${BUILD_NUMBER} failed — check the logs above"
        }
    }
}
