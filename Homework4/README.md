# How to Use

1. Clone the repository:
   ```bash
   git clone <repository_url>
   cd Homework4

2. Initialize Terraform: terraform init

3. Create a file_name.tfvars file with your configurations. You must provide all the required variables. You can use one of the provided file_name.tfvars files as a template. For example:
region = "us-east-1"
key_name = "my-key"
instance_count = 1
availability_zone = "us-east-1a"
instance_type = "t2.micro"
ami_id = "ami-0c55b159cbfafe1f0" # Example AMI ID, replace with a valid one

4. To deploy in a specific region, use the -var-file flag: 
terraform apply -var-file=file_name.tfvars

5. After deployment, you can destroy the resources:
terraform destroy -var-file=us-east-1.tfvars




