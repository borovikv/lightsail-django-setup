# Lightsail Django Setup

Bootstrap a Django project on AWS Lightsail in one command.

## Usage

1. Create a Lightsail instance (Amazon Linux 2023).
2. SSH into the instance.
3. Install Git:
   ```bash
   sudo yum install git
   ```
4. Clone this repo:
   ```bash
   git clone https://github.com/borovikv/lightsail-django-setup.git
   ```
5. Run the setup:
   ```bash
   cd lightsail-django-setup
   ./setup.sh <your_project_name> <your_github_username>
   ```
6. Make sure your project repo has deploy/run script and requirements.txt.
7. Add SSH key to your GitHub.