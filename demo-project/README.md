# HANDS ON PROJECT

## Please documents each steps of this project. 
use */carles* on the browser to see the app.

#### Store all your code to github and configure the s3 backend to store your terraform state file

# Instructions for Students: Create a cluster and create EC2 with Terraform and Set up Jenkins and SonarQube for CI/CD
In this project, you will:

Provision an EC2 instance using Terraform.
Set up Jenkins and SonarQube on the EC2 instances.
Create a CI/CD pipeline with Jenkins to integrate Argo CD, SonarQube, and Slack notifications.

## Project Overview

Terraform: Will provision an EC2 instances to host Jenkins and SonarQube.

Jenkins: Will be used as a CI server to build, test, and deploy your Spring Boot application. (use jenkins agent)

SonarQube: Will be used for continuous inspection of code quality.

Argo CD: Will handle the continuous deployment of your application into a Kubernetes cluster.

Slack: Will provide notifications on pipeline success/failure.
Steps to Achieve This Project:

# 1. Prerequisites

## Ensure you have the following ready before starting:

- AWS Account: You will need an active AWS account with credentials.
- Terraform: Installed on your local machine.
- SSH Keypair: To access the EC2 instance.
- Docker: Installed on the EC2 instance to build and run containers.

# 2. Step-by-Step Instructions for Terraform

# What You Need:

- Terraform installed on your local machine.
- AWS credentials configured (AWS_ACCESS_KEY_ID and AWS_SECRET_ACCESS_KEY).

# Steps:

# Install Terraform:

Ensure Terraform is installed on your local machine. Run terraform --version to check.
If not installed, follow Terraform’s installation instructions.

# Initialize Your Terraform Project:

Create a new directory for your Terraform project (e.g., terraform-jenkins).
Inside that directory, create a configuration file (main.tf).
Configure the AWS provider and define the EC2 instance.

# Configure AWS and EC2 Setup:

Specify the AWS region and instance type (e.g., t2.medium) for hosting Jenkins and SonarQube.
Use an Ubuntu AMI that supports Jenkins and SonarQube.
Make sure to configure security groups to allow traffic on:
Port 22 (SSH access),
Port 8080 (Jenkins),
Port 9000 (SonarQube).
Run Terraform Commands:

Initialize: Run terraform init to initialize the project.
Plan: Run terraform plan to see what changes will be made.
Apply: Run terraform apply to provision the EC2 instance.
# SSH into EC2:

# Once the instance is running, use the SSH keypair to connect:

bash
Copy code

    ssh -i <your-keypair>.pem ubuntu@<ec2-public-ip>
# 3. Step-by-Step Setup of Jenkins and SonarQube on EC2

# What You Need:

Jenkins: For building the CI pipeline.
SonarQube: For code quality analysis.

# Steps:
# Install Jenkins:

# After SSHing into the EC2 instance, install Jenkins:

bash
Copy code

    sudo apt update
   
    sudo apt install -y openjdk-17-jdk

    sudo apt install -y jenkins

    sudo systemctl start jenkins

Access Jenkins at 

    http://<ec2-public-ip>:8080.

# Install SonarQube:

Install SonarQube on the same EC2 instance or another server (based on your performance needs):
Follow SonarQube installation instructions to install it on Ubuntu.
Access SonarQube at

    http://<ec2-public-ip>:9000.

# Configure Jenkins:

Install the Maven, SonarQube Scanner, Docker, and Slack Notification plugins.
Connect Jenkins to SonarQube by adding SonarQube in Jenkins under Manage Jenkins > Configure System > SonarQube Servers.
# 4. CI/CD Pipeline Setup with Jenkins, SonarQube, and Argo CD

# What You Need:

Jenkins: Configured and connected to your GitHub/Bitbucket repository.
SonarQube: Configured for code analysis.
Argo CD: Deployed in a Kubernetes cluster.
Slack: Webhook URL to send notifications.

# Steps:

# Configure Git Integration:

Ensure that Jenkins can pull your Spring Boot project from GitHub.

# Set up Jenkins Pipeline:

In Jenkins, create a Pipeline Job and configure it with a Jenkinsfile that:
Pulls code from Git.
Runs Maven to build the code and package it.
Performs SonarQube analysis to check for code quality.
Builds and pushes the Docker image to your container registry.
Deploys the application to you Kubernetes cluster using Argo CD.
Add SonarQube Quality Gate:

If desired, set up a SonarQube Quality Gate that will fail the build if code quality doesn’t meet the required standards.

# Configure Argo CD:

Ensure Argo CD is properly deployed in your Kubernetes cluster and is syncing your Spring Boot application from your Git repository.
Use Jenkins to trigger an Argo CD sync after building and pushing the Docker image to docker hub.

# Set up Slack Notifications:

In Jenkins, configure the Slack Notification Plugin.
Add your Slack webhook URL to send notifications to a Slack channel on build success or failure.
#5. Review and Clean-up

# What You Need:

Review the CI/CD Pipeline: Ensure all components (Jenkins, SonarQube, Argo CD, Slack) are working together.
Clean Up: Once your pipeline is running, terminate any unnecessary resources.
Requirements for the Project:
Terraform: To provision infrastructure on AWS.
AWS Account: For EC2 provisioning.
Jenkins: For CI automation.
SonarQube: For code quality inspection.
Docker: For building and packaging the Spring Boot application.
Maven: As the build tool for the Spring Boot application.
Argo CD: For continuous deployment in Kubernetes.
Slack: For notifications on build status

# Create Amazon EKS cluster using eksctl | How to create Amazon EKS cluster using EKSCTL | Create EKS Cluster in command line
What is Amazon EKS

Amazon EKS is a fully managed container orchestration service. EKS allows you to quickly deploy a production ready Kubernetes cluster in AWS, deploy and manage containerized applications more easily with a fully managed Kubernetes service. 

EKS takes care of Master node/control plane. We need to manage worker nodes.

## Pre-requisites:

You can use Windows, Macbook or any Ubuntu or Red Hat EC2 instance to setup the below tools.


## Install AWS CLI – Command line tools for working with AWS services, including Amazon EKS.

    curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" 

    sudo apt install unzip

    sudo unzip awscliv2.zip  

    sudo ./aws/install

    aws --version

## Install eksctl – A command line tool for working with EKS clusters that automates many individual tasks.

     curl --silent --location "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /tmp

- Move the extracted binary to /usr/local/bin. 

      sudo mv /tmp/eksctl /usr/local/bin

      eksctl version

## install kubectl – A command line tool for working with Kubernetes clusters. 

Update package manager

       sudo apt-get update

Install

       sudo apt-get install -y kubectl

Verify if kubectl got installed

      kubectl version --client

# Create AWS Access Keys

Once you install all of the above, you need to have AWS credentials configured in your environment. The aws configure command is the fastest way to set up your AWS CLI installation for general use. 
Make sure you do not have any IAM role attached to the EC2 instance. You can remove IAM role by going into AWS console and Detach the IAM role.

    aws configure 

the AWS CLI prompts you for four pieces of information: access key, secret access key, AWS Region, and output format.

# Create EKS Cluster using eksctl

     eksctl create cluster --name demo-eks --region us-east-2 --nodegroup-name my-nodes --node-type t3.small --managed --nodes 2 

the above command should create a EKS cluster in AWS, it might take 15 to 20 mins. The eksctl tool uses CloudFormation under the hood, creating one stack for the EKS master control plane and another stack for the worker nodes. 

    eksctl get cluster --name demo-eks --region us-east-2 

### This should confirm that EKS cluster is up and running.

# Connect to EKS cluster

    kubectl get nodes

    kubectl get ns
# Install prometheus and Grafana to monitor your cluster using helm.

    https://github.com/Angecalais97/prometheus-Grafana-Zero-to-Hero.git

### delete the cluster 

    eksctl delete cluster --name demo-eks --region us-east-2 
# s7yusuff-jenkins
