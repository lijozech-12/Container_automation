pipeline{
    agent any
    tools{
        jdk 'jdk17'
        nodejs 'node16'
    }
    environment {
        SCANNER_HOME=tool 'sonar-scanner'
    }
    stages {
        stage('clean workspace'){
            steps{
                cleanWs()
            }
        }

        stage('Checkout from Git'){
            steps{
                git branch: 'main', url: 'https://github.com/lijozech-12/Jenkins-k8s-sample-website.git'
            }
        }


        stage('Install Dependencies') {
            steps {
                sh "npm install"
            }
        }
        stage("Docker Build & Push"){
            steps{
                script{
                   withDockerRegistry(credentialsId: 'docker', toolName: 'docker'){
                       sh "docker build -t website ."
                       sh "docker tag website lijozech12/jenkins-k8s-testproject:latest "
                       sh "docker push lijozech12/jenkins-k8s-testproject:latest "
                    }
                }
            }
        }

        stage("deploy_docker"){
            steps{
                sh "docker run -d --name uber -p 3000:3000 lijozech12/jenkins-k8s-testproject:latest"
            }
        }
    }
}