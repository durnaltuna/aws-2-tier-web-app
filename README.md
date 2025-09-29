Project Title
Automated Two-Tier Web Application Deployment on AWS with Terraform

Project Description
This project demonstrates a fundamental DevOps workflow for deploying a two-tier web application on Amazon Web Services (AWS). The entire infrastructure is defined as code using Terraform, which provisions a Virtual Private Cloud (VPC), public and private subnets, an EC2 web server, and a managed PostgreSQL database (RDS) in a secure, isolated environment.

The application itself is a simple Python Flask web server that serves a basic web page and includes an endpoint to test the database connection. The deployment process is fully automated via a shell script that copies the application code, installs dependencies, and manages the application's lifecycle on the EC2 instance, all from a local machine.

This project showcases the following skills:

Infrastructure as Code (IaC): Using Terraform to manage and provision cloud resources.

Cloud Computing: Working with core AWS services (EC2, RDS, VPC, Security Groups).

DevOps Automation: Automating application deployment with a single script.

Networking: Configuring subnets and security groups to enable secure communication between tiers.

Architecture
The project's architecture follows a standard two-tier model:

Web Tier: An EC2 instance running a Flask application is located in a public subnet. It is accessible from the internet through a public IP address.

Database Tier: An RDS PostgreSQL database is located in a private subnet, with no public IP. It is only accessible to the EC2 instance, providing enhanced security.

Prerequisites
To run this project, you will need:

AWS Account with valid credentials configured for your machine.

Terraform installed locally.

Python 3 and pip installed.

Git installed to clone the repository.

Deployment
Follow these steps to deploy the application.

1. Clone the Repository
Clone this project to your local machine using Git:

Bash

git clone https://github.com/YourUsername/your-repo-name.git
cd your-repo-name
2. Provision the Infrastructure
Initialize Terraform and apply the configuration to create the AWS resources.

Bash

terraform init
terraform apply
This will provision the VPC, subnets, EC2 instance, RDS database, and security groups. Type yes when prompted.

3. Deploy the Application
Run the automated deployment script to copy the application code and launch the web server on the EC2 instance.

Bash

chmod +x deploy_app.sh
./deploy_app.sh
Usage
Once the deployment is complete, your application will be live.

View the Website: Navigate to the public IP address of your EC2 instance in a web browser. You can get the IP address from the Terraform output.

Check Database Connection: Go to http://[EC2_PUBLIC_IP]:8080/database_check to confirm that the application can connect to the database.

Screenshots
[Insert your screenshot here showing the website with the greeting]

[Insert your screenshot here showing the database check page]

Clean Up
To avoid unexpected charges, remember to destroy all the provisioned resources when you are finished.

Bash

terraform destroy
Type yes when prompted.
