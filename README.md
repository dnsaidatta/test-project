# Banking Solution Infrastructure

## Overview

This Terraform project sets up the cloud infrastructure on Azure for a banking application with the following components:
1. React Web App (Frontend)
2. Backend Service #1 (Internal API, restricted outbound access)
3. Backend Service #2 (External API, with rate limiting)
4. Azure Virtual Network and Subnets

## Prerequisites

- Azure CLI installed and authenticated.
- Terraform installed.
- Azure subscription with access to create resources.

## Setup Instructions

1. Clone the repository:

Azure Banking Infrastructure Solution
Overview
This project sets up a secure Azure infrastructure for a banking application, consisting of:

React Web Application: Hosted as a static site on Azure Storage with optional CDN integration.
Backend Service #1 (Internal API): An internal API to integrate with a bank's systems, accessible only within the Virtual Network (VNet) and restricted to outbound connections with the bank's IP range (203.0.113.0/24).
Backend Service #2 (Public API): An API accessible publicly through an Application Gateway, with rate limiting to handle requests from external users.
Azure Application Gateway: Serves as the entry point with Web Application Firewall (WAF) protection for secure traffic management.
This solution uses Terraform to define Infrastructure as Code (IaC) for deploying resources on Azure.

Prerequisites
Ensure you have the following installed before proceeding:

Terraform: Version >= 1.0.0
Azure CLI: For authenticating to Azure
Azure Subscription: Access to create and manage resources
Setup Instructions
1. Clone the Repository
Clone the repository to your local machine:

bash
Copy code
git clone https://github.com/yourusername/azure-banking-infra.git
cd azure-banking-infra
2. Initialize Terraform
Initialize Terraform to download necessary providers and set up the environment.

bash
Copy code
terraform init
3. Configure Variables
Edit the variables.tf file to configure the following variables as needed:

region: Azure region where resources will be deployed (default: East US)
project_prefix: Prefix for naming resources (default: bankingapp)
allowed_ips: Allowed IP ranges for Backend Service #1 outbound traffic (default: 203.0.113.0/24)
rate_limit: Rate limit for Backend Service #2 API (default: 10 requests per second)
Alternatively, you can override these values directly when applying the configuration:

bash
Copy code
terraform apply -var="region=West Europe" -var="project_prefix=mybankapp"
4. Plan the Deployment
Run a Terraform plan to preview the resources that will be created.

bash
Copy code
terraform plan
5. Apply the Configuration
Deploy the infrastructure to Azure by running:

bash
Copy code
terraform apply
Confirm with yes when prompted.

6. Access the Outputs
After deployment, Terraform will output essential URLs and IPs:

app_gateway_ip: Public IP of the Application Gateway
react_web_app_url: URL of the React Web Application
backend_service_1_url: Internal URL for Backend Service #1
backend_service_2_url: Public URL for Backend Service #2
Solution Approach
Key Components and Architecture
Virtual Network (VNet) with Subnets:

Set up a secure network with isolated subnets for frontend and backend services.
Frontend Subnet: Hosts the Application Gateway for public-facing services.
Internal Backend Subnet: Hosts Backend Service #1, accessible only within the VNet.
Public Backend Subnet: Hosts Backend Service #2 with controlled access.
Network Security Groups (NSGs):

Configured NSGs to enforce security rules for each subnet.
Backend Service #1 is restricted from public internet access, allowing outbound traffic only to the bank's IP range (203.0.113.0/24).
Backend Service #2 has open outbound access and rate limiting configured.
Application Gateway with WAF:

Acts as the primary entry point for external traffic, providing load balancing and SSL termination.
Web Application Firewall (WAF) provides security for the web app and Backend Service #2.
React Web Application:

Hosted as a static site on Azure Storage, making it accessible via CDN for fast delivery.
Backend Services:

Backend Service #1: Configured with private access only, restricted to the VNet, and outbound connectivity limited to the bank's IP range.
Backend Service #2: Publicly accessible via the Application Gateway, with rate limiting applied.
Key Approach Decisions
Network Segmentation and Isolation:

Separate subnets and security groups ensure that each component has appropriate access controls.
Backend Service #1 is isolated from the public internet to handle sensitive operations securely.
Modular and Scalable Design:

Each component (VNet, NSGs, Application Gateway, Backend Services) is modularized in Terraform, allowing easy customization and reusability.
Outbound Restrictions for Backend Service #1:

To secure Backend Service #1, we used an NSG to restrict outbound access only to the specific IP range (203.0.113.0/24), ensuring that sensitive data cannot be transmitted to unauthorized addresses.
Rate Limiting on Backend Service #2:

Applied rate limiting on Backend Service #2 to prevent abuse and maintain API stability.
Potential Improvements
If further time and resources are available, consider the following improvements:

CI/CD Pipeline:

Set up a CI/CD pipeline (e.g., using Azure DevOps or GitHub Actions) to automate the deployment process.
Include automated testing, linting, and validation steps for infrastructure code.
Enhanced Security with Azure Key Vault:

Store sensitive information, such as database connection strings and API keys, in Azure Key Vault.
Integrate Key Vault with the App Service for secure access to these secrets.
Monitoring and Logging:

Use Azure Monitor and Application Insights to collect logs and metrics for proactive monitoring of the application’s performance and security.
Set up alerts for unusual activity, such as failed access attempts or traffic spikes.
Scaling for Backend Services:

Implement autoscaling rules for the backend services based on metrics like CPU usage and request rates to ensure high availability.
Database Backup and Recovery:

Enable automated backups for the Cosmos DB databases and establish a recovery plan to handle data loss scenarios.
Enhanced API Gateway Rules:

Consider adding more fine-grained routing and throttling rules to handle varying traffic patterns for Backend Service #2.
Use Azure API Management (APIM) for more comprehensive API security and management.
Cleanup
To remove the deployed resources and avoid incurring charges, run:

bash
Copy code
terraform destroy
Confirm with yes to proceed with deletion.

Conclusion
This Terraform solution provides a secure, modular, and scalable infrastructure for a banking application on Azure. By isolating the backend services and applying stringent security controls, this setup meets the requirements for handling sensitive data and public APIs. Further improvements can enhance automation, security, and performance, making it adaptable to future needs