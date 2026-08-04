# EmployeeHub – Employee Management Portal on AWS 3-Tier Architecture

![AWS Architecture](https://imgur.com/b9iHwVc.png)

## 📌 Project Overview

EmployeeHub is a Java Spring Boot web application deployed on AWS using a 3-Tier Architecture. The application allows employees to register, log in, manage their profiles, and securely store data in Amazon RDS MySQL.

This project demonstrates cloud deployment, networking, application hosting, and database integration using AWS services.

---

## 🏗️ Architecture

![3-Tier Architecture](https://imgur.com/3XF0tlJ.png)

### Architecture Flow

```
Users
      │
      ▼
Application Load Balancer
      │
      ▼
Apache Tomcat on EC2
      │
      ▼
Spring Boot Application
      │
      ▼
Amazon RDS MySQL
```

---

# 🚀 Features

- User Registration
- User Login Authentication
- Employee Dashboard
- Employee Profile
- Edit Profile
- Change Password
- Session Management
- Responsive UI
- MySQL Database Integration
- AWS Cloud Deployment

---

# 🛠️ Technology Stack

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
- Apache Tomcat

## Database

- Amazon RDS MySQL

## Cloud

- AWS EC2
- Amazon VPC
- Public & Private Subnets
- Internet Gateway
- NAT Gateway
- Application Load Balancer
- Security Groups

## Build Tool

- Maven

## Version Control

- Git
- GitHub

---

# ☁️ AWS Services Used

- Amazon EC2
- Amazon RDS
- Application Load Balancer
- Amazon VPC
- Security Groups
- Internet Gateway
- NAT Gateway

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
│
├── pom.xml
└── README.md
```

---

# ⚙️ Deployment Steps

## Clone Repository

```bash
git clone https://github.com/jala-shivaprasad/Deploy-Java-Application-on-AWS-3-Tier-Architecture.git
```

---

## Build Project

```bash
mvn clean package
```

---

## Deploy WAR

```bash
sudo cp target/dptweb-1.0.war /opt/tomcat/webapps/
```

Restart Tomcat

```bash
sudo /opt/tomcat/bin/shutdown.sh
sudo /opt/tomcat/bin/startup.sh
```

---

# 🗄 Database

Database: **Amazon RDS MySQL**

Database Name

```
UserDB
```

Table

```
Employee
```

Columns

```
id
first_name
last_name
email
username
password
regdate
```

---

# 🔐 Security

- AWS Security Groups
- Private RDS
- Session Authentication
- JDBC Database Connectivity

---

# 📷 Screenshots

Add screenshots of:

- Login Page
- Registration Page
- Dashboard
- Profile Page
- AWS Architecture
- ALB
- EC2
- Amazon RDS

---

# 📈 Future Enhancements

- Docker
- Kubernetes (Amazon EKS)
- Jenkins CI/CD
- Terraform
- AWS CodePipeline
- Monitoring with Prometheus & Grafana
- CloudWatch Logging

---

# 👨‍💻 Author

**JALA SHIVA PRASAD**

GitHub

https://github.com/jala-shivaprasad

LinkedIn

(Add your LinkedIn profile URL)

---

# ⭐ If you found this project helpful

Please consider giving this repository a ⭐ on GitHub.
