resource "aws_instance" "rhel_instance" {
  ami           = var.ami_id
  instance_type = var.instance_type
  subnet_id     = data.terraform_remote_state.aws_dev_vpc.outputs.vpc_public_subnets
  key_name      = var.aws_key_pair_name
  tags          = var.ec2_tags
  vpc_security_group_ids = [data.terraform_remote_state.aws_dev_vpc.outputs.security_group-ssh_http_https_allowed] 
}

resource "aws_eip" "instance-eip" {
  instance = aws_instance.rhel_instance.id
  vpc = true
}