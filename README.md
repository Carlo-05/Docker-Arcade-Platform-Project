# **Docker-Arcade-Platform-Project**
-	This project provisions a full AWS infrastructure using Infrastructure as Code (IaC) with Terraform and automate deployments through Github Actions. It also demonstrate how to use docker for multi-container management and automated deployment in AWS.
-   Containerized web based arcade system that host multiple static games with isolated docker containers and serves them through an NGINX reverse proxy.
    -  **Environment used:**
       -  dev (Development)
    -  **AWS services used:**
       -  IAM
       -  S3
       -  VPC
       -  EC2
       -  SSM Parameters Store
    -  **.github/workflows(Github Actions)**
       -  **master.yml** - manually manages the main branch pipeline and integrates all stages like infra.yml and docker.yml using workflow_dispatch. This feature allows users to run a workflow on demand directly from the GitHub Actions dashboard.
       -  **infra.yml** - terraform provisions AWS infrastructure securely using AWS using OIDC authentication.
       -  **docker.yml** - execute docker compose to containerized images from Docker Hub repository.
       -  **destroy.yml** - use workflow_dispatch to decommission the aws infrastructure built by infra.yml safely.
#### *Note: Some services may incur costs beyond AWS Free Tier account limits. Please keep this in mind.*
## **Purpose:**
-	To demonstrate:
	- building images using Docker Buildx native builder and uploading it to Docker Hub repository.
    - to define and orchestrate multiple containers (games + NGINX) in a single configuration file called docker-compose.
    - create OpenID Connect (OIDC) which is a secure identity protocol that lets external systems (like GitHub Actions) authenticate with AWS without storing long-lived access keys. Instead, AWS trusts tokens issued by the OIDC provider to grant temporary IAM role credentials.
    - The use of GitHub Actions as a CI/CD platform for infrastructure provisioning.
    - Best practices in IaC with environment separation, modular Terraform, and secure secret handling.

## **Environment Features:**
-	**Dev**

    -	A lightweight, containerized arcade system deployed on AWS EC2.
### _Note:_
-	### AMI id is account specific. Update the AMI values in Github Actions Environment Variables for both the dev and prod environments to prevent deployment issue. For this project, I used ubuntu and linux 2 — ensure that you used the OS mentioned.

## **Architecture diagram**

- **Project overview**
  
    <div align="left">
    <img src="https://github.com/Carlo-05/Docker-Arcade-Platform-Project/blob/main/documents/pictures/Architect-001.png?raw=true" alt="Project overview"style="width: 15%; height: auto;">
    </div>


- **Dev:**

    <div align="left">
    <img src="https://github.com/Carlo-05/Docker-Arcade-Platform-Project/blob/main/documents/pictures/Architect-002.png?raw=true" alt="DEV"style="width: 40%; height: auto;">
    </div>
 
- **Container Diagram:**

    <div align="left">
    <img src="https://github.com/Carlo-05/Docker-Arcade-Platform-Project/blob/main/documents/pictures/Architect-003.png?raw=true" alt="PROD"style="width: 40%; height: auto;">
    </div>
 
## **Actual Project Presentation:**
-   Platform:
    <div align="left">
    <img src="https://github.com/Carlo-05/Docker-Arcade-Platform-Project/blob/main/documents/pictures/Final_001.png?raw=true" alt="Execute"style="width: 60%; height: auto;">
    </div> 

-   Games:
    <div align="left">
    <img src="https://github.com/Carlo-05/Docker-Arcade-Platform-Project/blob/main/documents/pictures/Final_006.png?raw=true" alt="Execute"style="width: 60%; height: auto;">
    </div> 



## **Technologies used**

**Docker**
-	Used for application containerization, ensuring isolation between the services.
-   Inter-container communication is handled via Docker’s internal network, allowing services like Nginx (proxy) to route traffic to game containers.
-   Use of Docker Buildx to enable advanced image-building capabilities beyond the standard Docker build workflow.

**GitHub**
-	Used for version control, collaboration, and project hosting.
-	To allow users to clone and explore the project.

**GitHub Actions**
-	A CI/CD and automation tool built into GitHub.
-	Automates workflows triggered by events in your repository.

**Terraform**
-	an open-source "Infrastructure as Code" (IaC) tool, is used to automate the provisioning and management of cloud and on-premises infrastructure by defining infrastructure as code, enabling consistent and repeatable deployments.
-	Terraform documentation used in building this project: 
    https://registry.terraform.io/providers/hashicorp/aws/latest/docs

**AWS**
-	cloud computing service provider which is offered by Amazon
-	cloud services used in this project are VPC, EC2, RDS, Auto Scaling Group (ASG), S3, IAM, and Application Load Balancer (ALB).
-	AWS Command Line Interface (CLI) documentation used in building this project: https://docs.aws.amazon.com/cli/

**Visual Studio Code**
-	is a powerful integrated development environment (IDE) created by Microsoft. It offers features like code editing, debugging, version control integration, and rich extensions, making it a versatile tool for developers of all levels.

**Linux OS**
-	Project development using Terraform on Linux environment.

**AI Assistance**
-	Used as a learning and development aid for troubleshooting and following best practices in Terraform and AWS infrastructure design.
-	Github Copilot, ChatGPT.

## **Other Files**
**OIDC(Folder)**
-   Terraform configuration directory that sets up OpenID Connect, a secure identity protocol that lets external systems (like GitHub Actions) authenticate with AWS without storing long-lived access keys.
  
**docker-deploy.sh**
-   This script runs in EC2 module.
-	This script dynamically detects whether the OS of the instance is Linux 2 or Ubuntu. It installs necessary system update and Docker application.
-	Download docker-compose.yml and nginx.conf.

**docker-compose.yml**
-   It is used for running multi-container Docker applications using a single YAML file.
  
**nginx.conf**
-   Defines the routing rules of the containers.

## **Modules Explanation**
**Module** – is a self-contained Terraform module, with well-organized configuration files to 
    manage infrastructure as code.

**EC2**
-	Creates EC2 instance.
-	Download and install necessary dependencies via user data.
	
**SG**
-	Centralize security group module, where all of the resource’s security group are stored.

**VPC**
-	Project's virtual network infrastructure. Please see picture of dev for reference.

## **How to use:**

- [1. Prerequisites.](https://github.com/Carlo-05/Docker-Arcade-Platform-Project/blob/08549c702d4db4e288ecc17c9ee94fd5f87d6bb0/documents/MD/1.%20Prerequisites_Docker.md)
- [2. First step.](https://github.com/Carlo-05/Docker-Arcade-Platform-Project/blob/08549c702d4db4e288ecc17c9ee94fd5f87d6bb0/documents/MD/2.%20First%20step_Docker.md)
- [3. Create OpenID Connect (OIDC) and configure secrets and variables.](https://github.com/Carlo-05/Docker-Arcade-Platform-Project/blob/08549c702d4db4e288ecc17c9ee94fd5f87d6bb0/documents/MD/3.%20How%20to_OIDC_and_Variables_Docker.md)
- [4. Github Actions, Terraform configuration execution and project testing.](https://github.com/Carlo-05/Docker-Arcade-Platform-Project/blob/08549c702d4db4e288ecc17c9ee94fd5f87d6bb0/documents/MD/4.%20Execute_Docker.md)

## **Credits:**
-   This project showcases containerization and service orchestration using several open-source games. All game assets and source code are credited to their original authors:
    -   Flappy
        -   Source: [floppybird](https://github.com/nebez/floppybird)
        -   Created by: [Nebez Briefkani](https://github.com/nebez)
    -   Dino
        -   Source: [dino](https://github.com/wayou/t-rex-runner)
        -   Created by: [牛さん](https://github.com/wayou)
    -   Tetris
        -   Source: [tetris](https://github.com/jakesgordon/javascript-tetris)
        -   Created by: [Jake Gordon](https://github.com/jakesgordon)
    -   Mario
        -   Source: [mario](https://github.com/reruns/mario)
        -   Created by: [Garrett Johnson ](https://github.com/reruns)
    
-   All rights belong to the original creators. This project is intended solely for educational and non-commercial demonstration of Docker, Nginx, Github Actions, IaC(Terraform), and AWS.
