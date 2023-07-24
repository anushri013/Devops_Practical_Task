pipeline {
    agent any

    environment {
        registry = "531788722200.dkr.ecr.us-east-1.amazonaws.com/my-spring-boot-app"
        AWS_ACCESS_KEY_ID = credentials('AWS_ACCESS_KEY_ID')
        AWS_SECRET_ACCESS_KEY = credentials('AWS_SECRET_ACCESS_KEY')
        AWS_DEFAULT_REGION = "us-east-1"
    }
    
    stages {
        stage('Checkout') {
            steps {
                checkout([$class: 'GitSCM', branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/anushri013/Devops_Practical_Task.git']]])
            }
        }
    
           stage ("Build jar") {
            steps {
                script {
                    sh "mvn clean install"
                }
            }
        }
    
        stage ("Build image") {
            steps {
                script {
                    docker.build registry
                }
            }
        }
        
        stage ("docker push") {
         steps {
             script { 
                 
                sh "aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 531788722200.dkr.ecr.us-east-1.amazonaws.com"
                sh "docker push 531788722200.dkr.ecr.us-east-1.amazonaws.com/my-spring-boot-app:latest"
                 
             }
           }   
        }

        stage("Create an EKS Cluster") {
            steps {
                script {
                    dir('Terraform') {
                        sh "terraform init --reconfigure"
                        sh "terraform apply -auto-approve"
                    }
                }
            }
        }
        stage("Deploy to EKS") {
            steps {
                script {
                    dir('Kubernetes') {
                        sh "aws eks update-kubeconfig --name myapp-eks-cluster"
                        sh "kubectl apply -f springboot-deployment.yaml"
                        sh "kubectl apply -f springboot-service.yaml"
                    }
                }
            }
        }
    }
}
