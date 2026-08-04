<div align="center">

# 🧑‍💼 EmployeeHub — Employee Management Portal

**A secure Java Spring Boot employee registration & login portal, deployed on AWS using a classic 3-Tier Architecture.**

[![Java](https://img.shields.io/badge/Java-11-orange?logo=openjdk)](https://www.oracle.com/java/)
[![Spring Boot](https://img.shields.io/badge/Spring%20Boot-2.7.18-6DB33F?logo=springboot)](https://spring.io/projects/spring-boot)
[![Maven](https://img.shields.io/badge/Build-Maven-C71A36?logo=apachemaven)](https://maven.apache.org/)
[![AWS](https://img.shields.io/badge/Cloud-AWS-FF9900?logo=amazonaws)](https://aws.amazon.com/)
[![Tomcat](https://img.shields.io/badge/Server-Apache%20Tomcat%209-F8DC75?logo=apachetomcat)](https://tomcat.apache.org/)
[![MySQL](https://img.shields.io/badge/Database-Amazon%20RDS%20MySQL-4479A1?logo=mysql)](https://aws.amazon.com/rds/mysql/)
[![License](https://img.shields.io/badge/License-MIT-green.svg)](#-license)

</div>

---

## 📖 Table of Contents

- [Overview](#-overview)
- [Technology Stack](#-technology-stack)
- [Application Features](#-application-features)
- [Application Workflow](#-application-workflow)
- [AWS Architecture](#-aws-architecture)
- [AWS Deployment Guide](#-aws-deployment-guide)
- [Database](#-database)
- [Database Configuration](#-database-configuration)
- [Project Structure](#-project-structure)
- [Build & Run Locally](#-build--run-locally)
- [Screenshots](#-screenshots)
- [Security](#-security)
- [Troubleshooting](#-troubleshooting)
- [Future Enhancements](#-future-enhancements)
- [Learning Outcomes](#-learning-outcomes)
- [Author](#-author)
- [Support](#-support)

---

## 🧭 Overview

**EmployeeHub** is a Spring Boot (Spring MVC + JSP) web application that lets employees **register an account, log in, view their dashboard, view/edit their profile, and change their password**, with all data persisted in an **Amazon RDS MySQL** `Employee` table.

The app is packaged as a traditional **WAR** file (`spring-boot-starter-tomcat` is `provided`) so it can be deployed to an external **Apache Tomcat 9** server running on an **EC2** instance, sitting behind an **Application Load Balancer** — a classic AWS 3-tier setup (Web / App / Database tiers).

Package root: `com.dpt.demo` · Artifact: `dptweb` (Maven `groupId: com.devopsrealtime`)

---

## 🛠 Technology Stack

### Frontend
| Technology | Purpose |
|---|---|
| **JSP** (JSTL `core`/`fmt`) | Server-rendered views resolved via `spring.mvc.view.prefix=/pages/` and `.jsp` suffix |
| **Bootstrap 5** | Responsive layout, forms, navbar, cards (loaded via CDN in `header.jsp`) |
| **Font Awesome 6** | Iconography across nav, buttons, and status pages |
| **HTML5 / CSS3** | `static/css/style.css` — custom design tokens (teal/navy theme, ID-badge motifs) |
| **JavaScript** | `static/js/main.js` — client-side form validation, password visibility toggle, password-strength meter |

### Backend
| Technology | Purpose |
|---|---|
| **Java 11** | Language / runtime version pinned in `pom.xml` |
| **Spring Boot 2.7.18** | Application framework (`spring-boot-starter-parent`) |
| **Spring MVC** | `@Controller` classes handling routing and `ModelAndView` |
| **Spring JDBC (JdbcTemplate)** | Database access via `spring-boot-starter-jdbc`, backed by a HikariCP pool |
| **spring-security-crypto** | `BCryptPasswordEncoder` bean only — password hashing, without pulling in the full Spring Security filter chain |
| **Tomcat Embedded Jasper** | JSP compilation support (`tomcat-embed-jasper`) |
| **JSTL 1.2** | `<c:choose>/<c:if>` conditional nav, `<fmt:formatDate>` for registration dates |

### Database
| Technology | Purpose |
|---|---|
| **Amazon RDS (MySQL 8)** | Managed relational database hosting the `UserDB` schema / `Employee` table |
| **mysql-connector-j 8.4.0** | JDBC driver |

### Cloud / Infrastructure
Amazon EC2 · Amazon VPC · Public Subnets · Private Subnets · Internet Gateway · NAT Gateway · Route Tables · Security Groups · Application Load Balancer · Target Groups

### Build & Versioning
Maven (WAR packaging) · Git · GitHub

---

## ✨ Application Features

| Feature | How it works |
|---|---|
| 🏠 **Home Page** | `HomeController` maps `/` and `/home` to `home.jsp` — a public landing page with hero section and feature highlights. No authentication or DB access required. |
| 📝 **User Registration** | `RegisterController` (`GET`/`POST /register`) collects first name, last name, email, username, password, and confirm-password. All validation (required fields, email regex, username format, password length ≥ 6, password match, duplicate username/email checks) lives in `EmployeeService.register()`. On success, the password is hashed with **BCrypt** before `EmployeeDao.insert()` writes the row, and the user is redirected to `/confirm`. |
| 🔑 **Login Authentication** | `AuthController` (`GET`/`POST /login`) calls `EmployeeService.authenticate()`. It looks up the employee by username and verifies the password. If the stored value is a BCrypt hash (`$2a$`/`$2b$`/`$2y$` prefix) it's checked with `BCryptPasswordEncoder.matches()`; otherwise it falls back to a legacy plain-text comparison and **transparently re-hashes and upgrades** the record on a successful match — a backwards-compatible migration path for pre-existing plaintext rows. |
| 🧭 **Employee Dashboard** | `DashboardController` maps `/dashboard` → `user.jsp`, pulling the logged-in `Employee` out of the `HttpSession` and rendering employee details plus quick-access tiles (Dashboard, Profile, Edit Profile, Change Password, Logout). |
| 👤 **Employee Profile** | `ProfileController` (`GET /profile`) renders `profile.jsp` with the current employee's first name, last name, username, email, and registration date. |
| ✏️ **Edit Profile** | `ProfileController` (`GET`/`POST /profile/edit`) lets the employee update first name, last name, and email (username is immutable — disabled in `editProfile.jsp`). Validation and duplicate-email checks run through `EmployeeService.updateProfile()`, and the session's cached `Employee` object is refreshed after a successful save. |
| 🔒 **Change Password** | `ProfileController` (`GET`/`POST /profile/change-password`) verifies the current password (BCrypt or legacy plaintext), enforces a 6-character minimum and confirmation match on the new password, then hashes and persists it via `EmployeeService.changePassword()`. |
| 🚪 **Logout** | `AuthController` (`GET`/`POST /logout`) invalidates the `HttpSession` and redirects to `/login`. |
| 🛡 **Session Management** | A single session attribute, `loggedInEmployee` (see `SessionKeys`), holds the authenticated `Employee` (password stripped via `Employee.withoutPassword()`). `AuthController.login()` invalidates any pre-existing session and issues a **fresh session on every login** to prevent session fixation. An optional **"Remember me"** HttpOnly cookie (`epRememberUsername`, 30-day max age) pre-fills the username field on the login form. |
| 🚧 **Route Protection** | `AuthInterceptor` (registered in `WebMvcConfig`) guards `/dashboard`, `/profile`, and `/profile/**`. Unauthenticated requests are redirected to `/login` instead of throwing an error or leaking employee data. |
| 🗄 **Database Integration** | `EmployeeDao` uses Spring's `JdbcTemplate` exclusively — every query is a `PreparedStatement`, eliminating SQL-injection risk that existed in the original raw `DriverManager` implementation. Connections are pooled via **HikariCP**, auto-configured from `spring.datasource.*`. |
| ⚠️ **Error Handling** | `GlobalExceptionHandler` (`@ControllerAdvice`) catches any unhandled exception (e.g. a temporarily unreachable RDS instance), logs it server-side, and renders a friendly `error.jsp` page — never a raw stack trace or SQL detail. `server.error.include-message=never` and `include-stacktrace=never` reinforce this at the container level. A dedicated `fail.jsp` view also exists for a generic "login failed" state. |

---

## 🔄 Application Workflow

```
        ┌────────────┐
        │    Home    │  (/, /home)
        └─────┬──────┘
              │
       ┌──────┴──────┐
       ▼             ▼
 ┌───────────┐  ┌───────────┐
 │ Register  │  │   Login   │
 │ (/register)│  │ (/login)  │
 └─────┬─────┘  └─────┬─────┘
       │              │
       ▼              ▼
 ┌───────────┐  ┌────────────────┐
 │  Confirm  │  │ Authentication │  (EmployeeService.authenticate)
 │ (/confirm)│  └───────┬────────┘
 └─────┬─────┘          │
       │                ▼
       │        ┌───────────────┐
       └───────▶│   Dashboard   │  (/dashboard) — session created
                └───────┬───────┘
                        │
        ┌───────────────┼───────────────────┐
        ▼               ▼                   ▼
 ┌─────────────┐ ┌───────────────┐  ┌──────────────────┐
 │   Profile   │ │ Edit Profile  │  │ Change Password   │
 │ (/profile)  │ │(/profile/edit)│  │(/profile/change-  │
 └──────┬──────┘ └───────────────┘  │     password)     │
        │                            └──────────────────┘
        ▼
 ┌─────────────┐
 │   Logout    │  (/logout) — session invalidated
 └─────────────┘
```

**Step-by-step:**

1. **Home** – Visitor lands on `/` or `/home`; can navigate to Register or Login.
2. **Register** – New employee submits the registration form; `EmployeeService` validates input and uniqueness, hashes the password with BCrypt, and inserts a row into `Employee`.
3. **Confirm** – On success, the user is redirected to `/confirm`, a static confirmation page pointing them to Login.
4. **Login** – Employee submits username/password to `/login`.
5. **Authentication** – `EmployeeService.authenticate()` verifies the credentials (BCrypt or legacy-plaintext fallback with auto-upgrade).
6. **Dashboard** – On success, a fresh `HttpSession` is created holding the authenticated employee, and the browser is redirected to `/dashboard`, guarded by `AuthInterceptor`.
7. **Profile** – Employee can view their stored details at `/profile`.
8. **Edit Profile** – Employee updates first name, last name, and/or email at `/profile/edit`; the session copy is refreshed on save.
9. **Change Password** – Employee changes their password at `/profile/change-password`, after re-verifying their current password.
10. **Logout** – `/logout` invalidates the session and returns the employee to `/login`.

---

## ☁️ AWS Architecture

> Architecture diagrams below are reused from the project's original design documentation.

### High-Level AWS Architecture
![AWS Architecture](https://imgur.com/b9iHwVc.png)

### 3-Tier Architecture Breakdown
![3-Tier Architecture](https://imgur.com/3XF0tlJ.png)

| Layer / Component | Role in EmployeeHub |
|---|---|
| **Internet** | Entry point for all end-user HTTP(S) traffic. |
| **Application Load Balancer (ALB)** | Sits in the **public subnets**, receives internet traffic, and distributes it across healthy EC2 targets registered in a **Target Group**, using an HTTP health check. |
| **Public Subnets** | Host internet-facing resources — the ALB (and optionally a NAT Gateway) — routed to the internet via the **Internet Gateway**. |
| **Private Subnets** | Host the **EC2 instances running Apache Tomcat** (application tier) and the **Amazon RDS MySQL** instance (database tier), neither of which is directly reachable from the internet. |
| **Apache Tomcat 9** | Runs on EC2 in the private subnet; hosts the deployed `dptweb.war` (this Spring Boot application) as a standard servlet container. |
| **Spring Boot Application (dptweb.war)** | The compiled EmployeeHub app — Spring MVC controllers, JDBC data access, and JSP views — running inside Tomcat. |
| **Amazon RDS MySQL** | Managed MySQL instance hosting the `UserDB` database and `Employee` table; reached by the app exclusively through JDBC/HikariCP over the private subnet. |
| **VPC** | The isolated network boundary containing all public/private subnets, route tables, and security groups for this deployment. |
| **Internet Gateway** | Attached to the VPC; allows resources in public subnets (the ALB) to communicate with the internet. |
| **NAT Gateway** | Deployed in a public subnet; lets EC2 instances in private subnets initiate outbound traffic (e.g., OS/package updates, pulling from the Maven/Artifactory repository) without being directly exposed inbound. |
| **Route Tables** | Direct public-subnet traffic to the Internet Gateway and private-subnet outbound traffic to the NAT Gateway. |
| **Security Groups** | Firewall rules at the instance/ALB level — e.g., ALB SG allows inbound `80`/`443` from the internet; EC2 SG allows inbound `8080` only from the ALB SG; RDS SG allows inbound `3306` only from the EC2 SG. |

---

## 🚀 AWS Deployment Guide

<details>
<summary><strong>Click to expand the full step-by-step deployment guide</strong></summary>

### Step 1 — Create a VPC
Create a VPC (e.g. `10.0.0.0/16`) via the AWS Console or CLI:
```bash
aws ec2 create-vpc --cidr-block 10.0.0.0/16
```

### Step 2 — Create Public Subnets
Create at least two public subnets across different Availability Zones (for ALB high availability):
```bash
aws ec2 create-subnet --vpc-id <VPC_ID> --cidr-block 10.0.1.0/24 --availability-zone us-east-1a
aws ec2 create-subnet --vpc-id <VPC_ID> --cidr-block 10.0.2.0/24 --availability-zone us-east-1b
```

### Step 3 — Create Private Subnets
Create private subnets for the EC2 (app tier) and RDS (db tier):
```bash
aws ec2 create-subnet --vpc-id <VPC_ID> --cidr-block 10.0.3.0/24 --availability-zone us-east-1a
aws ec2 create-subnet --vpc-id <VPC_ID> --cidr-block 10.0.4.0/24 --availability-zone us-east-1b
```

### Step 4 — Create an Internet Gateway
```bash
aws ec2 create-internet-gateway
aws ec2 attach-internet-gateway --vpc-id <VPC_ID> --internet-gateway-id <IGW_ID>
```

### Step 5 — Create a NAT Gateway
Allocate an Elastic IP and launch the NAT Gateway in a public subnet:
```bash
aws ec2 allocate-address --domain vpc
aws ec2 create-nat-gateway --subnet-id <PUBLIC_SUBNET_ID> --allocation-id <EIP_ALLOC_ID>
```

### Step 6 — Create Route Tables
- **Public route table** → `0.0.0.0/0` → Internet Gateway, associated with public subnets.
- **Private route table** → `0.0.0.0/0` → NAT Gateway, associated with private subnets.

### Step 7 — Configure Security Groups
| Security Group | Inbound Rule | Source |
|---|---|---|
| `alb-sg` | `80`/`443` | `0.0.0.0/0` |
| `ec2-sg` | `8080` | `alb-sg` |
| `rds-sg` | `3306` | `ec2-sg` |

### Step 8 — Launch EC2 Instances
Launch EC2 instance(s) (Amazon Linux 2/2023) in the private app subnet, attached to `ec2-sg`.

### Step 9 — Install Java 11
```bash
sudo yum update -y
sudo yum install java-11-amazon-corretto -y
java -version
```

### Step 10 — Install Apache Tomcat 9
```bash
cd /opt
sudo wget https://downloads.apache.org/tomcat/tomcat-9/v9.0.90/bin/apache-tomcat-9.0.90.tar.gz
sudo tar -xvzf apache-tomcat-9.0.90.tar.gz
sudo mv apache-tomcat-9.0.90 tomcat9
sudo chmod +x /opt/tomcat9/bin/*.sh
```

### Step 11 — Install Maven
```bash
sudo yum install maven -y
mvn -version
```

### Step 12 — Clone the Repository
```bash
git clone https://github.com/<your-username>/Java-Login-App.git
cd Java-Login-App
```

### Step 13 — Build the WAR File
```bash
mvn clean package
# Produces target/dptweb-1.0.war
```

### Step 14 — Create the Amazon RDS Instance
Create a MySQL 8.x RDS instance in the private DB subnet(s), attached to `rds-sg`, **not** publicly accessible.

### Step 15 — Configure the Database
Connect to the RDS endpoint and create the schema/table:
```sql
CREATE DATABASE UserDB;
USE UserDB;

CREATE TABLE Employee (
  id int unsigned auto_increment not null,
  first_name varchar(250),
  last_name varchar(250),
  email varchar(250),
  username varchar(250),
  password varchar(250),
  regdate timestamp,
  primary key (id)
);
```

### Step 16 — Deploy the WAR to Tomcat
```bash
sudo cp target/dptweb-1.0.war /opt/tomcat9/webapps/
sudo /opt/tomcat9/bin/startup.sh
```
Set the required environment variables (see [Database Configuration](#-database-configuration)) before starting Tomcat, e.g. in `/opt/tomcat9/bin/setenv.sh`:
```bash
export DB_URL="jdbc:mysql://<rds-endpoint>:3306/UserDB"
export DB_USERNAME="<your-db-username>"
export DB_PASSWORD="<your-db-password>"
```

### Step 17 — Create a Target Group
Create a Target Group (protocol `HTTP`, port `8080`) and register the EC2 instance(s).

### Step 18 — Configure the Health Check
Point the Target Group health check at `/` or `/home` (HTTP `200` expected).

### Step 19 — Create the Application Load Balancer
Create an internet-facing ALB in the public subnets, attached to `alb-sg`, with a listener on port `80`/`443` forwarding to the Target Group.

### Step 20 — Verify Deployment
```bash
curl -I http://<ALB-DNS-NAME>/dptweb-1.0/home
```
Confirm a `200 OK` and check Target Group health status in the AWS Console.

### Step 21 — Access the Application
Open the ALB DNS name (or a custom domain pointed at it via Route 53) in a browser:
```
http://<ALB-DNS-NAME>/dptweb-1.0/
```

</details>

---

## 🗃 Database

**Database Name:** `UserDB`
**Table:** `Employee`

| Column | Type | Notes |
|---|---|---|
| `id` | `int unsigned, auto_increment` | Primary key |
| `first_name` | `varchar(250)` | |
| `last_name` | `varchar(250)` | |
| `email` | `varchar(250)` | Unique per application logic (checked in `EmployeeService`) |
| `username` | `varchar(250)` | Unique per application logic; login identifier |
| `password` | `varchar(250)` | Stores a **BCrypt hash**; legacy plaintext rows are auto-upgraded to BCrypt on next successful login |
| `regdate` | `timestamp` | Set via `CURDATE()` at insert time |

This is a **single-table** schema — there are no foreign-key relationships in the current implementation.

### Application-to-Database Flow

```
Browser
   │  HTTP request
   ▼
Controller (AuthController / RegisterController / ProfileController / DashboardController)
   │  delegates business logic + validation
   ▼
EmployeeService
   │  calls
   ▼
EmployeeDao (Spring JdbcTemplate — PreparedStatements only)
   │  JDBC (HikariCP connection pool)
   ▼
Amazon RDS (MySQL)
   │
   ▼
Employee Table
```

Every SQL statement in `EmployeeDao` is a parameterized `PreparedStatement` executed through `JdbcTemplate`, so user input (username, email, password, etc.) can never be interpreted as SQL — eliminating SQL-injection risk.

---

## ⚙️ Database Configuration

Connection settings are defined in `src/main/resources/application.properties` and resolved from **environment variables**, with local fallback defaults so the app can still start without extra setup:

```properties
spring.datasource.url=${DB_URL:jdbc:mysql://<rds-endpoint>:3306/UserDB}
spring.datasource.username=${DB_USERNAME:<username>}
spring.datasource.password=${DB_PASSWORD:<password>}
spring.datasource.driver-class-name=com.mysql.cj.jdbc.Driver
```

| Variable | Description |
|---|---|
| `DB_URL` | Full JDBC URL of your Amazon RDS MySQL instance, e.g. `jdbc:mysql://<your-rds-endpoint>:3306/UserDB` |
| `DB_USERNAME` | RDS master or application database username |
| `DB_PASSWORD` | RDS database password |

> ⚠️ **Do not commit real credentials to source control.** Set these as environment variables on your EC2 instance (e.g. in a Tomcat `setenv.sh`, a systemd unit, or an Elastic Beanstalk configuration), or better yet, resolve them at runtime from **AWS Secrets Manager** or **SSM Parameter Store**. If this repository's history ever contained real values, rotate the RDS password immediately and scrub it from git history.

Connection pool (HikariCP) is tuned conservatively for a small EC2 instance behind an ALB:

```properties
spring.datasource.hikari.maximum-pool-size=10
spring.datasource.hikari.minimum-idle=2
spring.datasource.hikari.connection-timeout=10000
spring.datasource.hikari.initialization-fail-timeout=-1
```

---

## 📁 Project Structure

```
Java-Login-App/
├── pom.xml                                  # Maven build (WAR packaging, Spring Boot 2.7.18, Java 11)
├── settings.xml                             # Maven repository settings (⚠️ should not contain real creds)
├── mvnw / mvnw.cmd                          # Maven wrapper
└── src/
    ├── main/
    │   ├── java/com/dpt/demo/
    │   │   ├── MyWebAppApplication.java      # @SpringBootApplication entry point
    │   │   ├── ServletInitializer.java       # WAR deployment entry point (extends SpringBootServletInitializer)
    │   │   ├── config/
    │   │   │   ├── AppConfig.java            # BCryptPasswordEncoder bean
    │   │   │   ├── WebMvcConfig.java         # Registers AuthInterceptor on protected routes
    │   │   │   └── GlobalExceptionHandler.java  # @ControllerAdvice → friendly error.jsp
    │   │   ├── controller/
    │   │   │   ├── HomeController.java       # "/", "/home"
    │   │   │   ├── AuthController.java       # "/login", "/logout"
    │   │   │   ├── RegisterController.java   # "/register"
    │   │   │   ├── DashboardController.java  # "/dashboard", "/confirm"
    │   │   │   └── ProfileController.java    # "/profile", "/profile/edit", "/profile/change-password"
    │   │   ├── dao/
    │   │   │   └── EmployeeDao.java          # JdbcTemplate-based data access
    │   │   ├── model/
    │   │   │   └── Employee.java             # Domain model mapped 1:1 to the Employee table
    │   │   ├── service/
    │   │   │   ├── EmployeeService.java      # Validation, BCrypt hashing, auth, profile/password logic
    │   │   │   ├── RegistrationException.java
    │   │   │   └── InvalidPasswordException.java
    │   │   └── web/
    │   │       ├── AuthInterceptor.java      # Session guard for protected routes
    │   │       └── SessionKeys.java          # Central HttpSession attribute-name constants
    │   ├── resources/
    │   │   ├── application.properties        # View resolver + datasource + session/error config
    │   │   └── static/
    │   │       ├── css/style.css              # Custom theme (536 lines)
    │   │       └── js/main.js                 # Client-side validation, password toggle/strength
    │   └── webapp/pages/
    │       ├── common/
    │       │   ├── header.jsp                 # Shared <head>, navbar (session-aware)
    │       │   └── footer.jsp                 # Shared footer + scripts
    │       ├── home.jsp                       # Public landing page
    │       ├── login.jsp                      # Login form
    │       ├── register.jsp                   # Registration form
    │       ├── confirm.jsp                    # Post-registration confirmation
    │       ├── user.jsp                       # Employee dashboard
    │       ├── profile.jsp                    # View profile
    │       ├── editProfile.jsp                # Edit profile form
    │       ├── changePassword.jsp             # Change password form
    │       ├── error.jsp                      # Generic error page (GlobalExceptionHandler)
    │       └── fail.jsp                       # Generic login-failed page
    └── test/
        └── java/com/dpt/demo/
            └── MyWebAppApplicationTests.java  # Spring context-load smoke test
```

---

## 🏗 Build & Run Locally

```bash
# 1. Clone the repository
git clone https://github.com/<your-username>/Java-Login-App.git
cd Java-Login-App

# 2. Set database environment variables
export DB_URL="jdbc:mysql://<your-mysql-host>:3306/UserDB"
export DB_USERNAME="<your-username>"
export DB_PASSWORD="<your-password>"

# 3. Build the WAR
mvn clean package

# 4. Deploy to Tomcat (or run embedded for local testing)
cp target/dptweb-1.0.war $CATALINA_HOME/webapps/
$CATALINA_HOME/bin/startup.sh
```

**Application URL:**
```
http://localhost:8080/dptweb-1.0/
```
*(On AWS, replace `localhost:8080` with your ALB's DNS name, per the [deployment guide](#-aws-deployment-guide).)*

---

## 📸 Screenshots

> Add your own screenshots to an `images/` folder at the project root using the file names below.

| Home | Login | Register |
|---|---|---|
| ![Home](images/home.png) | ![Login](images/login.png) | ![Register](images/register.png) |

| Dashboard | Profile |
|---|---|
| ![Dashboard](images/dashboard.png) | ![Profile](images/profile.png) |

### AWS Infrastructure

| AWS Architecture | ALB | EC2 |
|---|---|---|
| ![AWS Architecture](images/aws-architecture.png) | ![ALB](images/alb.png) | ![EC2](images/ec2.png) |

| RDS | Target Group |
|---|---|
| ![RDS](images/rds.png) | ![Target Group](images/target-group.png) |

---

## 🔐 Security

| Area | Implementation |
|---|---|
| **Session Management** | A single `HttpOnly` session cookie tracks `loggedInEmployee`. A **fresh session** is issued on every successful login (old session invalidated first) to prevent session fixation. Sessions expire after `30m` of inactivity (`server.servlet.session.timeout=30m`). |
| **Authentication** | Passwords are hashed with **BCrypt** (`spring-security-crypto`) before storage. Legacy plaintext rows are detected by hash-prefix check and transparently upgraded on next successful login. |
| **Route Protection** | `AuthInterceptor` blocks unauthenticated access to `/dashboard`, `/profile`, and `/profile/**`, redirecting to `/login`. |
| **SQL Injection Prevention** | All queries go through `JdbcTemplate` with parameterized `PreparedStatement`s — no string-concatenated SQL. |
| **Environment Variables** | Database credentials (`DB_URL`, `DB_USERNAME`, `DB_PASSWORD`) are externalized from `application.properties` via `${VAR:default}` placeholders, intended to be set as real environment variables (or resolved from AWS Secrets Manager/SSM) in production rather than committed to source control. |
| **Error Handling** | `GlobalExceptionHandler` + `server.error.include-message=never` / `include-stacktrace=never` ensure no SQL, stack traces, or connection details are ever returned to the browser. |
| **Security Groups (AWS)** | Layered SGs restrict traffic: internet → ALB (80/443) → EC2 (8080) → RDS (3306), with no tier exposed further than necessary. |
| **ALB Security** | The ALB is the only internet-facing component; EC2 instances live in private subnets and are unreachable directly from the internet. |
| **RDS Security** | RDS is deployed in private subnets, not publicly accessible, and only reachable from the EC2 security group on port `3306`. |

---

## 🧯 Troubleshooting

<details>
<summary><strong>Tomcat won't start / app doesn't deploy</strong></summary>

- Confirm Java 11 is installed and `JAVA_HOME` is set correctly.
- Check `$CATALINA_HOME/logs/catalina.out` for the actual startup error.
- Ensure the WAR filename matches the context path you're hitting.
</details>

<details>
<summary><strong>ALB shows targets as "unhealthy"</strong></summary>

- Verify the health check path (`/` or `/home`) returns `200 OK` directly on the EC2 instance (`curl localhost:8080/...`).
- Confirm the EC2 security group allows inbound `8080` from the ALB security group.
- Check that Tomcat is actually running and the WAR deployed without errors.
</details>

<details>
<summary><strong>Health checks failing intermittently</strong></summary>

- Increase the health check timeout/interval and unhealthy threshold in the Target Group.
- Confirm the app isn't blocking on a slow/unreachable RDS connection during startup (the app is configured with `initialization-fail-timeout=-1` so it should retry lazily rather than crash).
</details>

<details>
<summary><strong>RDS connection failures</strong></summary>

- Confirm `DB_URL`, `DB_USERNAME`, and `DB_PASSWORD` are correctly set as environment variables on the EC2 instance.
- Verify the RDS security group allows inbound `3306` from the EC2 security group.
- Confirm the RDS instance and EC2 instance are in the same VPC (or properly peered).
</details>

<details>
<summary><strong>MySQL driver / ClassNotFoundException</strong></summary>

- Confirm `mysql-connector-j` is present in `pom.xml` and the WAR was rebuilt after any dependency change (`mvn clean package`).
- Double-check `spring.datasource.driver-class-name=com.mysql.cj.jdbc.Driver` matches the connector version in use.
</details>

<details>
<summary><strong>Maven build failures</strong></summary>

- Run `mvn -version` to confirm Maven and Java versions match `pom.xml` (`java.version=11`).
- If using a private/Artifactory repository via `settings.xml`, confirm the repository is reachable and credentials are valid — but **never commit real repository credentials**.
</details>

<details>
<summary><strong>WAR deployment issues</strong></summary>

- Confirm the WAR was copied into `$CATALINA_HOME/webapps/` and Tomcat has read/write permissions on that directory.
- Watch `catalina.out` during startup for JSP compilation errors (Jasper).
</details>

<details>
<summary><strong>HTTP 500 errors</strong></summary>

- These are caught by `GlobalExceptionHandler` and rendered as a friendly `error.jsp`, but the real cause is logged server-side — check the application logs on the EC2 instance.
</details>

<details>
<summary><strong>HTTP 404 errors</strong></summary>

- Confirm you're hitting the correct context path (`/dptweb-1.0/...` unless the WAR was renamed or deployed as `ROOT.war`).
- Verify the controller mapping exists for the path you're requesting.
</details>

---

## 🔮 Future Enhancements

- 🐳 **Docker** — containerize the Spring Boot app for consistent local/CI/prod parity
- ☸️ **Kubernetes (Amazon EKS)** — container orchestration for scaling and self-healing
- 🌍 **Terraform** — infrastructure as code for the VPC/ALB/EC2/RDS stack described above
- 🔧 **Jenkins** — self-hosted CI/CD pipeline
- ⚙️ **GitHub Actions** — cloud-native CI/CD (build, test, deploy on push)
- 🚀 **AWS CodePipeline** — native AWS CI/CD integration
- 📊 **CloudWatch** — centralized logging and alarms
- 📈 **Prometheus** — metrics collection
- 📉 **Grafana** — metrics visualization and dashboards

---

## 🎓 Learning Outcomes

This project demonstrates practical, hands-on experience across several disciplines:

- **Java & Spring Boot:** Layered application design (Controller → Service → DAO), Spring MVC routing, `HandlerInterceptor`-based route guarding, `@ControllerAdvice` global exception handling, and JDBC data access with `JdbcTemplate`.
- **Application Security:** Password hashing with BCrypt, safe session lifecycle management (fixation prevention), parameterized queries to prevent SQL injection, and externalizing secrets from source control.
- **AWS Cloud Architecture:** Designing and reasoning about a 3-tier VPC (public/private subnets, IGW, NAT Gateway, route tables), securing tiers with layered Security Groups, and fronting compute with an Application Load Balancer and Target Group health checks.
- **DevOps Practices:** Building deployable WAR artifacts with Maven, deploying to externally managed Tomcat on EC2, and configuring environment-based database credentials suitable for automation and secrets managers.

---

## 👤 Author

**Your Name**
Java Full-Stack Developer · AWS & DevOps Enthusiast

[![GitHub](https://img.shields.io/badge/GitHub-100000?style=for-the-badge&logo=github&logoColor=white)](https://github.com/<your-username>)
[![LinkedIn](https://img.shields.io/badge/LinkedIn-0077B5?style=for-the-badge&logo=linkedin&logoColor=white)](https://linkedin.com/in/<your-linkedin>)

---

## ⭐ Support

If this project helped you learn Spring Boot, AWS 3-tier architecture, or DevOps deployment concepts:

- ⭐ **Star** this repository
- 🍴 **Fork** it and build on it
- 🐛 Open an issue if you spot a bug or have a suggestion

---

## 📄 License

This project is available under the [MIT License](LICENSE).
