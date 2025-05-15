# 🚀 Deploying a Web App on AWS EC2

This project demonstrates two ways to deploy a simple web application on an Amazon EC2 instance:

1. ✅ Using AWS Console  
2. ✅ Using Terraform (Infrastructure as Code)

---

## 📌 Project Goal

Host a basic web app using Apache on an EC2 instance in the **ap-south-1 (Mumbai)** region.

---

## 🧰 Tech Stack

- **AWS EC2**
- **Amazon Linux 2**
- **Terraform**
- **Shell Script**

---

## 📁 File Structure

```
├── main.tf
└── README.md
```


---

## 📗 Option 1: Deploy via AWS Console

### 🧾 Prerequisites

- AWS Account
- Key Pair (.pem file)
- Internet access to AWS Console

### 🛠️ Steps

#### 1. Launch EC2 Instance

- Navigate to the **EC2 Dashboard**
- Click **Launch Instance**
- Set name (e.g., `WebServer`)
- Choose **Amazon Linux 2 AMI (x86_64)**
- Select instance type: `t2.micro`
- Choose/Create a **key pair** (e.g., `pemFile`)
- In **Network Settings**, add inbound rules:
  - **HTTP** (Port 80) from `0.0.0.0/0`
  - **SSH** (Port 22) from `0.0.0.0/0`

#### 2. Add User Data Script

In **Advanced Details → User data**, paste:

```bash
#!/bin/bash
yum update -y
yum install -y docker git
systemctl start docker
systemctl enable docker
git clone https://github.com/Utkarsh067/Dockerise-Web-App.git /home/ec2-user/app
cd /home/ec2-user/app
docker build -t virtual-library .
docker run -d -p 80:80 virtual-library
```

#### 3. Launch & Test

+ Click Launch Instance
+ Wait until status is Running
+ Copy the Public IPv4 address
+ Open in browser: ```http://<public-ip>```

****You should see:****

![image](https://github.com/user-attachments/assets/8721597a-d0a0-4f87-8fca-e31f26413caf)


## 📘 Option 2: Deploy via Terraform

### 🧾 Prerequisites

- AWS CLI configured (`aws configure`)
- Terraform installed (`terraform -v`)
- A key pair named `pemFile` exists in your AWS EC2 Key Pairs

---

### 🗂️ Setup Instructions

1. Clone this repository:

```
   git clone https://github.com/Utkarsh067/Deploy-Web-app-on-AWS-EC2.git
   cd Deploy-Web-app-on-AWS-EC2
```

2. Verify that the main.tf file exists in the directory. If not, copy it manually.

Note: Ensure the key name in main.tf (pemFile) matches the key pair available in your AWS account.

### 📄 Configuration Summary

The Terraform configuration will:

+ Create a Security Group allowing HTTP (port 80) and SSH (port 22)
+ Launch an EC2 instance with:
  - Amazon Linux 2 AMI
  - A web page at /var/www/html/index.html using user data

### ⚙️ Deploy with Terraform

Run the following commands:
```
terraform init
terraform plan
terraform apply
```

+ Type ```yes``` to confirm when prompted.
+ After successful deployment, copy the EC2 Public IPv4 address and visit:

```http://<your-public-ip>```

****You should see:****

![image](https://github.com/user-attachments/assets/c48d4347-4bc6-49c0-a29d-0033f31b4595)


### 🧹 Cleanup

To tear down the infrastructure and avoid AWS charges:
```
terraform destroy
```
+ Type ```yes``` to confirm when prompted.
+ Or manually terminate the EC2 instance if you deployed using the console.

## 👨‍💻 Author

Utkarsh Jain

📍 DevOps & Cloud Enthusiast

🔗 [GitHub](https://github.com/Utkarsh067)
