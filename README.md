# Lightsail Django Setup

Bootstrap a Django project on AWS Lightsail in one command.

## Usage
1. Generate SSH Key on Lightsail
   ```bash
   bash scripts/generate_ssh_key.sh
   ```
   1.1. Copy the public key printed by the script
   1.2. Go to your GitHub SSH settings https://github.com/[[user]]/[[repo_name]]/settings/keys
   1.3. Click "New SSH Key"
   1.4. Name it something like Lightsail
   1.5. Paste the public key and save
2. Create a Lightsail instance (Amazon Linux 2023).
3. SSH into the instance.
4. Install Git:
   ```bash
   sudo yum install git
   ```
5. Clone this repo:
   ```bash
   git clone https://github.com/borovikv/lightsail-django-setup.git
   ```
6. Run the setup:
   ```bash
   cd lightsail-django-setup
   chmod +x ./setup.sh
   ./setup.sh <your_project_name> <your_github_username>
   ```
7. Make sure your project repo has deploy/run script and requirements.txt.
8. Add SSH key to your GitHub.