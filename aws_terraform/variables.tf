variable "aws_access_key" {}
variable "aws_secret_key" {}

variable "region" {
  default = "ap-northeast-1"
}

### Amazon Linux のAMIリスト
variable "amis" {
  type = "map"

  default = {
    us-east-1      = "ami-1ecae776"
    us-west-2      = "ami-e7527ed7"
    us-west-1      = "ami-d114f295"
    eu-west-1      = "ami-a10897d6"
    eu-central-1   = "ami-a8221fb5"
    ap-northeast-1 = "ami-da9e2cbc"
    ap-southeast-1 = "ami-68d8e93a"
    ap-southeast-2 = "ami-fd9cecc7"
    sa-east-1      = "ami-b52890a8"
  }
}

variable "office_ip" {
  description = "Your office IP"
}

variable "key_name" {
  description = "Desired name of AWS key pair"
}

variable "public_key_path" {
  description = <<DESCRIPTION
Path to the SSH public key to be used for authentication.
Ensure this keypair is added to your local SSH agent so provisioners can
connect.

Example: ~/.ssh/terraform.pub
DESCRIPTION
}
