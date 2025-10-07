# InsightPoll: A Cloud-Native, CI/CD-Driven Polling Application on Kubernetes

This project is a comprehensive, end-to-end implementation of a modern DevOps lifecycle, demonstrating a full suite of cloud-native tools and practices. The goal is to build, deploy, and manage a scalable microservices-based polling application on AWS, fully automated with a GitLab CI/CD pipeline.

## 🚀 Core Features

- **Infrastructure as Code (IaC):** The entire AWS infrastructure is defined and managed using Terraform.
- **Containerization & Orchestration:** The main application is containerized with Docker and deployed on a managed Kubernetes cluster (Amazon EKS) using Helm charts.
- **CI/CD Automation:** Every `git push` to the `master` branch automatically triggers a GitLab CI pipeline that tests, builds, and deploys the application to the EKS cluster.
- **Serverless Microservice:** A high-traffic voting endpoint is handled by a serverless stack (API Gateway, Lambda, DynamoDB) for maximum scalability and cost-efficiency.
- **Observability:**
  - **Monitoring:** The EKS cluster and application metrics are scraped by Prometheus and visualized in Grafana dashboards.
  - **Logging:** All container logs are collected by Fluent Bit and centralized in Amazon CloudWatch Logs for analysis.
- **Security:** A foundational security layer is implemented using AWS WAF on the frontend distribution.

## 🏛️ Architecture Diagram

The following diagram illustrates the complete architecture of the system, from code commit to a live, monitored application.

![Architecture Diagram](./architecture.png)

## 🛠️ Technology Stack

| Domain                  | Technologies Used                                                                 |
| ----------------------- | --------------------------------------------------------------------------------- |
| **Cloud Provider** | AWS (Amazon Web Services)                                                         |
| **Infrastructure as Code** | Terraform                                                                       |
| **Containerization** | Docker                                                                            |
| **Orchestration** | Kubernetes (Amazon EKS), Helm                                                     |
| **CI/CD** | GitLab CI                                                                         |
| **Application Backend** | Python (Flask), Node.js (for future services)                                     |
| **Databases** | Amazon RDS (PostgreSQL), Amazon DynamoDB (NoSQL)                                  |
| **Serverless** | AWS Lambda, Amazon API Gateway                                                    |
| **Observability** | Prometheus, Grafana, Amazon CloudWatch, Fluent Bit                                |
| **Networking & CDN** | Amazon VPC, CloudFront                                                            |
| **Security** | AWS WAF, AWS IAM, AWS Secrets Manager                                             |
