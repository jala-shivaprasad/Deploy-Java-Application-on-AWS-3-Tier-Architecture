# 🚀 EmployeeHub – Employee Management Portal on AWS 3-Tier Architecture

![AWS Architecture](https://imgur.com/b9iHwVc.png)

EmployeeHub is a Java Spring Boot web application deployed on AWS using a secure 3-Tier Architecture. The application demonstrates end-to-end deployment of a Java web application using Amazon EC2, Apache Tomcat, Amazon RDS MySQL, and an Application Load Balancer (ALB).

The project showcases cloud infrastructure, networking, application deployment, database integration, and modern UI implementation.

---

# 📑 Table of Contents

1. Project Overview
2. Architecture
3. AWS Services Used
4. Prerequisites
5. Infrastructure Setup
6. Application Setup
7. Database Configuration
8. Build & Deployment
9. Screenshots
10. Project Structure
11. Technologies Used
12. Troubleshooting
13. Future Enhancements
14. Learning Outcomes
15. Author

---

# 📌 Project Overview

EmployeeHub is a cloud-based employee management portal where users can:

- Register
- Login
- View Dashboard
- View Profile
- Edit Profile
- Change Password

The application uses Amazon RDS MySQL as the backend database and is deployed on Apache Tomcat running on Amazon EC2 instances behind an Application Load Balancer.

---

# 🏗 Architecture

![3-Tier Architecture](https://imgur.com/3XF0tlJ.png)

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

# ☁ AWS Services Used

- Amazon EC2
- Amazon VPC
- Public & Private Subnets
- Internet Gateway
- NAT Gateway
- Route Tables
- Security Groups
- Application Load Balancer
- Target Groups
- Amazon RDS MySQL
- Apache Tomcat
- Maven
- Git & GitHub

---

# 🚀 Infrastructure Setup

## Step 1 – Create VPC

- Create a custom VPC
- Configure CIDR block
- Enable DNS Hostnames
- Enable DNS Resolution

## Step 2 – Create Public & Private Subnets

- Public Subnet (AZ-1)
- Public Subnet (AZ-2)
- Private Subnet (AZ-1)
- Private Subnet (AZ-2)

## Step 3 – Create Internet Gateway

- Create Internet Gateway
- Attach to VPC

## Step 4 – Create NAT Gateway

- Allocate Elastic IP
- Create NAT Gateway in Public Subnet
- Update Private Route Table

## Step 5 – Configure Route Tables

Public Route Table

| Destination | Target |
|-------------|--------|
| 0.0.0.0/0 | Internet Gateway |

Private Route Table

| Destination | Target |
|-------------|--------|
| 0.0.0.0/0 | NAT Gateway |

## Step 6 – Configure Security Groups

### ALB Security Group

- HTTP (80)
- HTTPS (443)

### EC2 Security Group

- SSH (22)
- HTTP (80)
- Tomcat (8080)

### RDS Security Group

- MySQL (3306)
- Source: EC2 Security Group

## Step 7 – Launch EC2

Install:

- Java 11
- Apache Tomcat 9
- Maven
- Git

## Step 8 – Create Amazon RDS

Engine:

- MySQL

Database:

```
UserDB
```

Table:

```
Employee
```

---

# 🗄 Database Configuration

For security reasons, database credentials are **not included** in this repository.

Configure these environment variables before running the application:

```bash
DB_URL=jdbc:mysql://<RDS-ENDPOINT>:3306/UserDB
DB_USERNAME=<YOUR_DB_USERNAME>
DB_PASSWORD=<YOUR_DB_PASSWORD>
```

---

# 🛠 Build the Project

```bash
git clone https://github.com/jala-shivaprasad/Deploy-Java-Application-on-AWS-3-Tier-Architecture.git

cd EmployeeHub

mvn clean package
```

---

# 🚀 Deploy to Apache Tomcat

```bash
sudo cp target/dptweb-1.0.war /opt/tomcat/webapps/

sudo /opt/tomcat/bin/shutdown.sh

sudo /opt/tomcat/bin/startup.sh
```

---

# ⚖ Configure Target Group

- Target Type: Instance
- Protocol: HTTP
- Port: 8080
- Health Check Path:

```
/dptweb-1.0/
```

Register backend EC2 instances.

---

# 🌐 Configure Application Load Balancer

- Internet-facing
- Listener: HTTP (80)
- Forward requests to Target Group

Verify:

```
http://<ALB-DNS>/dptweb-1.0/
```

---

# 📂 Project Structure

```text
EmployeeHub
├── src
│   ├── main
│   │   ├── java
│   │   ├── resources
│   │   └── webapp
├── pom.xml
├── README.md
└── target
```

---

# 🛠 Technology Stack

### Frontend
- HTML5
- CSS3
- Bootstrap 5
- JavaScript
- JSP

### Backend
- Java 11
- Spring Boot
- Spring MVC
- JDBC
- Apache Tomcat

### Database
- Amazon RDS MySQL

### Cloud
- AWS EC2
- VPC
- ALB
- RDS
- Security Groups
- NAT Gateway

### Build
- Maven

### Version Control
- Git
- GitHub

---

# 📸 Screenshots

Add screenshots for:

- Login Page
- Registration Page
- Dashboard
- Profile
- AWS Architecture
- EC2
- RDS
- ALB
- Target Group

---

# 🔮 Future Enhancements

- Docker
- Kubernetes (Amazon EKS)
- Jenkins CI/CD
- Terraform
- GitHub Actions
- Prometheus
- Grafana
- CloudWatch Monitoring

---

# 📚 Learning Outcomes

- AWS Networking
- VPC Design
- EC2 Deployment
- Apache Tomcat
- Spring Boot WAR Deployment
- Amazon RDS
- Application Load Balancer
- Maven
- Git & GitHub
- Java Web Application Deployment

---

# 👨‍💻 Author

**JALA SHIVA PRASAD**

- GitHub: https://github.com/jala-shivaprasad
- LinkedIn: *(Add your LinkedIn profile URL)*

---

# ⭐ Support

If you found this project helpful:

- ⭐ Star the repository
- 🍴 Fork the repository
- 📢 Share it with others
