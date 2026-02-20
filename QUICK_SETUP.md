# 🚀 Quick EC2 Setup Guide Using Scripts

This guide helps you deploy your Next.js + Express + PostgreSQL application using automated setup scripts.

---

## 📋 Prerequisites

1. AWS EC2 instance (Ubuntu 22.04 LTS)
2. Security Group with ports: **22, 80, 443** open
3. SSH key (.pem file) downloaded
4. GitHub repository with your code

---

## 🎯 Deployment Steps

### Step 1: Connect to Your EC2 Server

```bash
# Windows (PowerShell)
ssh -i "your-key.pem" ubuntu@YOUR_EC2_PUBLIC_IP
```

---

### Step 2: Clone Your Repository

```bash
cd ~
git clone https://github.com/YOUR_USERNAME/REPO.git
cd EC2_Test
```

---

### Step 3: Run Server Setup Script

This installs Node.js, PostgreSQL, Nginx, and other essential tools.

```bash
chmod +x server.sh
./server.sh
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
chmod +x backend.sh
./backend.sh
```

Test the Server

```bash
npm run start
```

**4.3. Start Backend with PM2**

```bash
npm install -g pm2
pm2 start dist/src/server.js --name backend
pm2 save
pm2 startup
```

Verify backend is running:

```bash
pm2 status
curl http://localhost:5000/health
```

---

### Step 5: Setup Frontend

**5.1. Install Dependencies**

```bash
cd ~/REPO/frontend
npm install
```

**5.2. Create Frontend Environment File**

```bash
nano .env
```

Add:

```env
NEXT_PUBLIC_API_URL=http://YOUR_EC2_IP
```

**5.3. Build and Start Frontend**

```bash
npm run build
pm2 start npm --name "frontend" -- start
pm2 save
```

Verify frontend is running:

```bash
pm2 status
curl http://localhost:3000
```

---

### Step 6: Configure Nginx

Run the Nginx setup script:

```bash
cd ~/EC2_Test
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
