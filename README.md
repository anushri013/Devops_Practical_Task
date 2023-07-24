# Infrastructure Provisioning with Terraform

This repository contains the necessary configuration to provision infrastructure on AWS using Terraform and deploy a Dockerized Spring Boot application to an Amazon Elastic Kubernetes Service (EKS) cluster.

# Prerequisites

Before you begin, ensure you have the following:

1. An AWS account with appropriate permissions to create resources like EKS cluster, VPC, subnets, etc.
2. Terraform installed on your local development environment. If you haven't installed it yet, download it from the official website: [Terraform Downloads](https://www.terraform.io/downloads.html). Make sure the `terraform` binary is accessible in your command-line environment by adding it to your system's PATH variable.
3. AWS credentials set up on your local machine using the AWS CLI or an IAM role associated with your EC2 instance (if you're running Terraform on an EC2 instance).

# Getting Started

Follow the steps below to set up the infrastructure using Terraform and deploy the Spring Boot application to the EKS cluster:

1. Create a new GitHub repository:

   - Go to GitHub and create a new repository. You can name it something like "DevOps-Practical-Task"

2. Clone the repository:

   - Clone the newly created repository to your local development environment using Git:

   - git clone https://github.com/your-username/DevOps-Practical-Task.git
     cd DevOps-Practical-Task
     
3. Install Terraform:

4. Set up AWS credentials or IAM role:

   - Ensure you have an AWS account and necessary permissions to create resources (EKS cluster, VPC, subnets, etc.).
   - set up AWS credentials on your local machine using the AWS CLI or configure an IAM role with the required permissions and associate it with your EC2 instance (if you're running Terraform on an EC2 instance).

5. Create a Terraform configuration file:

   - Create a file in the root directory of your cloned repository.
   - In that files defined the Terraform resources needed to set up an EKS cluster, VPC, subnets, security groups, and EKS nodes. 

6. Terraform Initialization and Deployment:

   - Run the following commands to initialize Terraform and apply the configuration to create the EKS cluster:

     terraform init
     terraform apply
     
7. Retrieve EKS Cluster Details:

   - After Terraform has successfully created the EKS cluster, it will display the output containing the EKS cluster details.
   - Make sure to capture and save these details for later use.

8. Store Sensitive Information Securely:

   - Store sensitive information such as AWS access keys and secrets as environment variables.
     
9. Set up Environment Variables:

   - For Terraform configuration and later parts of the pipeline, set up environment variables for necessary information like AWS credentials, EKS cluster endpoint, etc.

   export AWS_ACCESS_KEY_ID="your_access_key"
   export AWS_SECRET_ACCESS_KEY="your_secret_key"
   export AWS_DEFAULT_REGION="us-east-1" 
   
# Dockerization of the Sample Spring Boot Application

This section covers the steps to Dockerize a sample Spring Boot application and prepare it for deployment to the EKS cluster.

# Prerequisites

Before you begin, ensure you have the following:

 1.Docker installed on your local development environment.

# Steps to Dockerize the Spring Boot Application

Follow these steps to Dockerize your Spring Boot application:

1. Create a Dockerfile:

   - In the root directory of your Spring Boot application, create a file named `Dockerfile`.

2. Write Dockerfile Instructions:

   - Inside the `Dockerfile`, define the necessary instructions to containerize your Spring Boot application.

3. *Build the Docker Image:*

   - docker build -t my-spring-boot-app .
     
4. Test the Docker Image Locally:

   - docker run -p 8080:8080 my-spring-boot-app
     
5. Push the Docker Image:

   - To use this Docker image in your Kubernetes deployment, need to push it to a container registry like Amazon ECR.
   - First, tag the Docker image with the appropriate repository information:

     docker tag my-spring-boot-app:latest your-container-registry/my-spring-boot-app:latest
     
7. Push the Docker Image to the Container Registry:

   -  docker push your-container-registry/my-spring-boot-app:latest

   - This will make your Docker image available in the specified container registry.


# Kubernetes Deployment

This section covers the steps to deploy your Dockerized Spring Boot application to the EKS cluster using Kubernetes.

# Prerequisites

Before you begin, ensure you have the following:

1. An EKS cluster provisioned using Terraform 
2. A Dockerized Spring Boot application image pushed to a container registry 

# Steps to Deploy the Spring Boot Application to EKS

Follow these steps to deploy your Spring Boot application to the EKS cluster using Kubernetes:

1. Create Kubernetes Deployment Files:

   - In the root directory of your Spring Boot application, create a folder named `kubernetes` to store the   Kubernetes deployment files.
   - Within the `kubernetes` folder, create a file named `deployment.yaml` to define the deployment configuration.

2. Define Kubernetes Deployment Configuration:

   - Inside `deployment.yaml`, define the Kubernetes deployment configuration to deploy your Dockerized Spring Boot application to the EKS cluster. 

3. Deploy the Application to the EKS Cluster:

   - Apply the Kubernetes deployment configuration to your EKS cluster using the `kubectl apply` command:

       kubectl apply -f springboot-deployment.yaml
   
   - This will deploy your Spring Boot application to the EKS cluster.

4. Verify the Deployment:

   - Check the status of the deployment using the following command:

       kubectl get deployments
   
   -  Ensure that the deployment is created, and the desired number of replicas are available.

5. Check the Pods:

   - Verify that the pods for your Spring Boot application are running correctly:

     kubectl get pods
     
   - Ensure that the pods have the `Running` status.

6. Test the Application:

   - To access your Spring Boot application running in the EKS cluster, create a Kubernetes service that exposes the deployment. 

   - Apply the service configuration:

     kubectl apply -f springboot-service.yaml
     
   - Depending on your EKS cluster setup, this will create an external load balancer and expose your Spring Boot application to the internet. Obtain the external IP or DNS of the load balancer to access your application in a browser.

# Continuous Integration and Deployment (CI/CD) with GitHub Actions

This section covers the steps to set up a CI/CD pipeline for your Spring Boot application using GitHub Actions.

# Prerequisites

Before you begin, ensure you have the following:
1. Java installed on your local development environment.

2. Jenkins installed on your local development environment.
   
3. A GitHub repository containing the Terraform configuration, Dockerized Spring Boot application, and Kubernetes deployment files.

4. The EKS cluster provisioned and the Spring Boot application deployed to it, as explained in the previous sections.

5. Amazon ECR repository to store the Docker image of the Spring Boot application.

# Steps to Set up CI/CD with GitHub Actions

Follow these steps to set up the CI/CD pipeline for your Spring Boot application using GitHub Actions:

1. Define GitHub Secrets:

   - In your GitHub repository ,add the secrets to securely store sensitive information:
   - Make sure not to include any sensitive information directly in your workflow file.

2. CI/CD Workflow Explanation:

   - The workflow is triggered on every push to the `main` branch.
   - It starts by checking out the code from the repository.
   - Then, it builds the Docker image for your Spring Boot application, tags it with the commit SHA, and pushes it to your container registry.
   - Next, it configures `kubectl` using the provided secrets to authenticate with your EKS cluster.
   - Finally, it deploys the updated Docker image to your EKS cluster using the Kubernetes deployment files defined in the previous section.

5. Test the CI/CD Workflow:

   - Push any changes to your repository's `main` branch to trigger the CI/CD workflow.
   - Ensure that the workflow runs successfully and deploys the updated Docker image to your EKS cluster.

