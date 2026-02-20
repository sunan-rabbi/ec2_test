# 🚀 Quick EC2 Setup Guide Using Scripts

This guide helps you deploy your Next.js + Express + PostgreSQL application using automated setup scripts.

---

## 📋 Prerequisites

1. AWS EC2 instance (Ubuntu 22.04 LTS)
2. Security Group with ports: **22, 80, 443** open
3. SSH key (.pem file) downloaded
4. GitHub repository with your code

**Installed Versions:**

- Node.js: v20.20.0
- npm: v11.10.1

---

## 🎯 Deployment Steps

### Step 1: Connect to Your EC2 Server

```bash
# Windows (PowerShell)
ssh -i "your-key.pem" ubuntu@YOUR_EC2_PUBLIC_IP
```

---

### Step 2: Setup GitHub Access

```bash
git clone https://YOUR_TOKEN@github.com/YOUR_USERNAME/REPO.git
cd REPO
```

---

### Step 3: Run Server Setup Script

This installs Node.js, PostgreSQL, Nginx, and other essential tools.

```bash
chmod +x basic.sh
./basic.sh
```

**After the script completes, create PostgreSQL user and database:**

```bash
# Create user (you'll be prompted for password)
sudo -u postgres createuser --interactive --pwprompt

# Create database (replace with your values)
sudo -u postgres createdb -O <your_username> <database_name>
```

**Example:**

```bash
sudo -u postgres createdb -O myuser mydb
```

---

### Step 4: Setup Backend

**4.1. Create Backend Environment File**

```bash
cd ~/REPO/backend
cp .env.example .env
nano .env
```

Update with your values:

```env
NODE_ENV=production
PORT=5000
DATABASE_URL="postgresql://<username>:<password>@localhost:5432/<database_name>?schema=public"
NEEDCORS=1
ALLOWORIGINS=http://localhost:3000,http://YOUR_EC2_IP:3000,http://YOUR_EC2_IP
COOKIE_SECRET="your_secure_random_string"
```

**4.2. Run Backend Setup Script**

```bash
chmod +x server.sh
./server.sh
```

Test the Server

```bash
npm run start
```

**4.3. Start Backend with PM2**

```bash
chmod +x pm2.sh
./pm2.sh
```

After running the script, copy and execute the PM2 startup command shown, then run:

```bash
pm2 save
pm2 status
curl http://localhost:5000/health
```

---

### Step 5: Setup Frontend

```bash
cd ~/REPO/frontend
chmod +x client.sh
./client.sh
```

This script will:

- Install dependencies (npm install)
- Create .env file from .env.example
- Build the Next.js application
- Start frontend with PM2

Verify frontend is running:

```bash
pm2 status
curl http://localhost:3000
```

---

### Step 6: Configure Nginx

Run the Nginx setup script:

```bash
cd ~/REPO
chmod +x nginx.sh
sudo ./nginx.sh
```

When prompted, enter your EC2 public IP or domain name.

## ✅ Verification

Your application should now be accessible at:

```
http://YOUR_EC2_PUBLIC_IP
```

---
