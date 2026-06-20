# key pair
resource "aws_key_pair" "key_pair_ec2" {
    key_name = "${var.env}-ec2-terra-key"
    public_key = file("ec2-terra-key.pub")
}

# vpc and security group
resource "aws_default_vpc" "default" {
}

resource "aws_security_group" "sg_ec2" {
    name = "${var.env}-sg_ec2"
    description = "Security group for EC2 instance"
    vpc_id = aws_default_vpc.default.id

    ingress{
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress{
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress{
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

# ec2

resource "aws_instance" "my_instance" {
    for_each = tomap({
        "${var.workspace}"-terra-automate-ec2-micro = "t3.micro"
    })
    instance_type = each.value
    key_name = aws_key_pair.key_pair_ec2.key_name
    vpc_security_group_ids = [aws_security_group.sg_ec2.id]
    ami = "ami-01a00762f46d584a1"
    user_data = file("install_nginx.sh")

    root_block_device {
		volume_size = 10
		volume_type = "gp3"
	}

    tags = {
    Name = each.key
    Environment = var.env
  }

}