# CLO835 Assignment 1 – Terraform Infrastructure Setup

This repository contains Terraform code to provision an AWS EC2 instance with Docker pre-installed using a user data script. The EC2 instance is used to deploy containerized applications pulled from Amazon ECR.

---

## File Structure

- **main.tf** – Declares AWS provider, VPC, security group, EC2 instance, and ECR repositories.
- **outputs.tf** – Displays EC2 instance public IP.
- **variables.tf** – Declares variable types for credentials and keypair.
- **.gitignore** – Prevents sensitive or redundant files from being committed.
- **mysecrets.tfvars** – Contains your temporary AWS credentials and key name (excluded from git).

---

## 🔐 Sample `mysecrets.tfvars`

```hcl
aws_access_key     = "<your_access_key>"
aws_secret_key     = "<your_secret_key>"
aws_session_token  = "<your_session_token>"
key_name           = "assignment1-keypair"
```

> **Never commit this file to GitHub.**

---

## Terraform Deployment Steps

1. **Clone this repository:**
   ```sh
   git clone https://github.com/Sandeep1111able/clo835-assignment1-terraform.git
   cd clo835-assignment1-terraform
   ```
2. **Generating & Importing Key Pair:**

### For Linux/macOS:

```sh
ssh-keygen -t rsa -b 2048 -f assignment1-keypair
chmod 400 assignment1-keypair
```

### For Windows PowerShell:

```powershell
ssh-keygen -t rsa -b 2048 -f assignment1-keypair
icacls assignment1-keypair /inheritance:r /grant:r "$($env:USERNAME):(R)"
```

### Import to AWS:

```sh
aws ec2 import-key-pair --key-name assignment1-keypair --public-key-material fileb://assignment1-keypair.pub
```

---

3. **Place your credentials in `mysecrets.tfvars`** (never commit this).
4. **Initialize Terraform:**
   ```sh
   terraform init
   ```
5. **Apply the configuration:**
   ```sh
   terraform apply -var-file="mysecrets.tfvars"
   ```
6. After deployment, Terraform will display the EC2 public IP.

---

## Docker Pre-installed

The EC2 instance uses a `user_data` script to:

- Install Docker
- Start Docker service
- Enable Docker to auto-start on boot

---

## Notes

- Make sure your AWS credentials are valid and use a temporary session token if on a student account.
- Ensure port 22 (SSH) and any app ports (e.g., 8081–8083) are allowed in your security group.
- Clean up your resources using:
  ```sh
  terraform destroy -var-file="mysecrets.tfvars"
  ```

---

## 👨‍💻 Author

**Sandeep Subedi** – CLO835 Assignment 1
