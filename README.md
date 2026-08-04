# 🚀 EmployeeHub - Employee Management Portal on AWS 3-Tier Architecture

![AWS Architecture](https://imgur.com/b9iHwVc.png)

EmployeeHub is a Java Spring Boot web application deployed on AWS using a 3-Tier Architecture. The project demonstrates how to build, deploy, and manage a cloud-based employee management system using Amazon EC2, Apache Tomcat, Amazon RDS MySQL, and an Application Load Balancer.

---

## 📌 Project Overview

EmployeeHub is a responsive employee management portal that allows users to:

- Register a new account
- Login securely
- View employee profile
- Edit profile
- Change password
- Manage employee information
- Store employee data in Amazon RDS MySQL

The application is deployed on AWS following a 3-tier architecture.

---

# 🏗️ Architecture

![3-Tier Architecture](https://imgur.com/3XF0tlJ.png)

## Architecture Flow

```
                 Internet
                     │
                     ▼
        Application Load Balancer
                     │
                     ▼
          Apache Tomcat on EC2
                     │
                     ▼
      Spring Boot EmployeeHub App
                     │
                     ▼
            Amazon RDS MySQL
```

---

# ✨ Features

- User Registration
- User Login
- Employee Dashboard
- Profile Management
- Edit Profile
- Change Password
- Session Management
- Responsive Bootstrap UI
- JDBC Database Connectivity
- Amazon RDS Integration
- AWS EC2 Deployment
- Apache Tomcat Deployment

---

# 🛠 Technology Stack

## Frontend

- HTML5
- CSS3
- Bootstrap 5
- JavaScript
- JSP

## Backend

- Java 11
- Spring Boot 2.7
- Spring MVC
- JDBC
- Apache Tomcat 9

## Database

- Amazon RDS MySQL

## Cloud Services

- Amazon EC2
- Amazon RDS
- Amazon VPC
- Public & Private Subnets
- Internet Gateway
- NAT Gateway
- Application Load Balancer (ALB)
- Security Groups

## Build Tool

- Maven

## Version Control

- Git
- GitHub

---

# ☁️ AWS Architecture Components

## Presentation Tier

- Application Load Balancer
- Browser Access

## Application Tier

- Amazon EC2
- Apache Tomcat
- Spring Boot Application

## Database Tier

- Amazon RDS MySQL

---

# 📂 Project Structure

```
EmployeeHub
│
├── src
│   ├── main
│   │   ├── java
│   │   ├── resources
│   │   └── webapp
│   │        └── pages
│   │
│   ├── pom.xml
│   └── README.md
│
└── target
```

---

# 🗄 Database

## Database Name

```
UserDB
```

## Table

```
Employee
```

## Table Structure

| Column | Type |
|---------|------|
| id | INT |
| first_name | VARCHAR |
| last_name | VARCHAR |
| email | VARCHAR |
| username | VARCHAR |
| password | VARCHAR |
| regdate | DATE |

---

# ⚙️ Database Configuration

For security reasons, database credentials are **not stored in the repository**.

Configure the following environment variables before running the application:

```bash
DB_URL=jdbc:mysql://<RDS-ENDPOINT>:3306/<DATABASE_NAME>
DB_USERNAME=<YOUR_DB_USERNAME>
DB_PASSWORD=<YOUR_DB_PASSWORD>
```

The application reads these values from `application.properties`.

---

# 🚀 Build Project

Clone the repository

```bash
git clone https://github.com/jala-shivaprasad/Deploy-Java-Application-on-AWS-3-Tier-Architecture.git
```

Go to project directory

```bash
cd EmployeeHub
```

Build

```bash
mvn clean package
```

---

# 🚀 Deploy to Apache Tomcat

Copy WAR

```bash
sudo cp target/dptweb-1.0.war /opt/tomcat/webapps/
```

Restart Tomcat

```bash
sudo /opt/tomcat/bin/shutdown.sh
sudo /opt/tomcat/bin/startup.sh
```

Application URL

```
http://<ALB-DNS>/dptweb-1.0/
```

---

# 📸 Screenshots

Include screenshots of:

- Login Page
- Registration Page
- Dashboard
- Profile Page
- AWS Architecture
- Amazon EC2
- Amazon RDS
- Application Load Balancer
- Target Group (Healthy)

---

# 🔒 Security

- Session Authentication
- AWS Security Groups
- Private Amazon RDS
- JDBC Database Connectivity
- Environment Variable Based Database Configuration

---

# 📈 Future Improvements

- Docker
- Kubernetes (Amazon EKS)
- Jenkins CI/CD Pipeline
- Terraform
- GitHub Actions
- AWS CodePipeline
- Prometheus
- Grafana
- AWS CloudWatch Monitoring

---

# 🎯 Learning Outcomes

Through this project, I gained hands-on experience with:

- AWS Networking
- Amazon EC2
- Apache Tomcat Deployment
- Spring Boot WAR Deployment
- Amazon RDS MySQL
- Application Load Balancer
- VPC Design
- Security Groups
- Maven Build Automation
- Git & GitHub
- Java Web Application Deployment

---

# 👨‍💻 Author

**JALA SHIVA PRASAD**

GitHub

https://github.com/jala-shivaprasad

LinkedIn

(Add your LinkedIn Profile URL)

---

# ⭐ Support

If you found this project helpful,

⭐ Star the repository

🍴 Fork the repository

📢 Share it with others
