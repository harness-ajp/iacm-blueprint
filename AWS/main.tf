# main.tf

# -----------------------------------------------------------------------------
# TERRAFORM AND PROVIDER CONFIGURATION
# -----------------------------------------------------------------------------

terraform {
  # This block specifies the required providers and their versions.
  # OpenTofu will download these providers when you run 'tofu init'.
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# Configure the AWS Provider.
# We are specifying the region requested: us-east-1.
provider "aws" {
  region = "us-east-1"
}

# -----------------------------------------------------------------------------
# DATA SOURCE - Find the latest Amazon Linux 2 AMI
# -----------------------------------------------------------------------------

# This data source looks up the ID of the most recent Amazon Linux 2 AMI
# in the us-east-1 region. This avoids hardcoding an AMI ID, which can
# become outdated.
data "aws_ami" "amazon_linux_2" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

# -----------------------------------------------------------------------------
# RESOURCE - EC2 Instances
# -----------------------------------------------------------------------------

# This resource block provisions the AWS EC2 instances.
resource "aws_instance" "tiny_nodes" {
  # 'count = 2' tells OpenTofu to create two identical instances from this block.
  count = 1

  # AMI ID is dynamically sourced from our data block above.
  ami = data.aws_ami.amazon_linux_2.id

  # 't2.nano' is one of the smallest, general-purpose instance types.
  # It is also eligible for the AWS Free Tier.
  instance_type = "t2.nano"

  # We use tags to name our instances.
  # The 'count.index' starts at 0, so we add 1 to make the names
  # more human-friendly (e.g., node-1, node-2).
  tags = {
    Name = "aj-iacm-instance-${count.index}"
  }
}
