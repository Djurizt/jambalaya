pipeline {
    agent any
    environment {
        DOCKERHUB_CREDENTIALS = credentials('dockerhub')
        IMAGE_TAG = "V1.0.${BUILD_NUMBER}"  // Set the image tag as an environment variable
    }
    options {
        buildDiscarder(logRotator(numToKeepStr: '20'))
        disableConcurrentBuilds()
        timeout(time: 60, unit: 'MINUTES')
        timestamps()
    }
    stages {
        stage('Testing') {
            agent {
                docker { image 'maven:3.8.4-eclipse-temurin-17-alpine' }
            }
            steps {
                sh '''
                cd demo-project
                mvn test
                '''
            }
        }

        stage('SonarQube Analysis') {
            agent {
                docker { image 'sonarsource/sonar-scanner-cli:5.0.1' }
            }
            environment {
                CI = 'true'
                scannerHome = '/opt/sonar-scanner'
            }
            steps {
                withSonarQubeEnv('sonar') {
                    sh "${scannerHome}/bin/sonar-scanner"
                }
            }
        }

        stage('Login') {
            steps {
                sh 'echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin'
            }
        }

            stage('Build and Push Image') {
                steps {
                    sh """
                    cd ${WORKSPACE}/demo-project
                    docker build -t thejurist/jambalaya:${IMAGE_TAG} .
                    docker push thejurist/jambalaya:${IMAGE_TAG}
                    """
                }
            }

        stage('Update Image Tag in Helm Repo for ArgoCD') {
            steps {
                sh """
                rm -rf s7yusuff-demo-project || true
                git clone -b prod git@github.com:DEL-ORG/s7yusuff-demo-project.git
                cd ${WORKSPACE}/s7yusuff-demo-project/demo-project
                sed -i 's/tag:.*/tag: ${IMAGE_TAG}/' ./chart/values.yaml
                git config user.email "gbebejunior@gmail.com"
                git config user.name "Djurizt"
                git add ./chart/values.yaml
                git commit -m "Update image tag to ${IMAGE_TAG}"
                git push origin prod
                """
            }
        }
    }
    post {
        success {
            echo "Image built, pushed, and ArgoCD will automatically deploy the new version."
        }
        failure {
            echo "Deployment failed!"
        }
    }
}
