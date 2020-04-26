resource "aws_key_pair" "auth" {
  key_name   = "${var.pj-prefix}-web"
  public_key = file(var.public_key_path)
}


### Amazon Linux 2の最新版AMIを取得する
data aws_ssm_parameter amzn2_ami {
  name = "/aws/service/ami-amazon-linux-latest/amzn2-ami-hvm-x86_64-gp2"
}

### CentOS 7 の最新版AMIを取得する
data aws_ami centos7_ami {
  most_recent = true
  owners = [ "aws-marketplace" ]

  filter {
    name = "product-code"
    values = [ "aw0evgkw8e5c1q413zgy5pjce" ]
  }
}

resource "aws_instance" "web" {
  ami                         = data.aws_ami.centos7_ami.id
  instance_type               = "t2.micro"
  key_name                    = aws_key_pair.auth.id
  subnet_id                   = aws_subnet.public-a.id
  associate_public_ip_address = true

  vpc_security_group_ids = [
    aws_security_group.web.id,
    aws_security_group.ssh.id
  ]

  tags = {
    Name = "${var.pj-prefix}-web"
  }
}

resource "aws_eip" "web" {
  instance = aws_instance.web.id
  vpc      = true
}

# Output Param
output "ec2_public-dns" {
  value = aws_eip.web.public_dns
}