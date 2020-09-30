terraform {
  required_version = "= 0.12.19"
}

provider "aws" {
  region  = "ap-northeast-1"
}

resource "aws_launch_template" "vm_template" {
  name_prefix   = "template_1"
  image_id      = "ami-0278fe6949f6b1a06"
  instance_type = "t2.micro"
  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "asg_flag"
    }
  }

  user_data = base64encode(<<-EOF
              #!/bin/bash
              echo "Hello, World" > index.html
              nohup busybox httpd -f -p 80 &
              EOF
              )
}

data "aws_availability_zones" "available" {
  state = "available"
}

locals{
  count_of_availability_zones = length(data.aws_availability_zones.available.names)
}

resource "aws_autoscaling_group" "asg" {
  availability_zones = data.aws_availability_zones.available.names
  desired_capacity   = local.count_of_availability_zones
  max_size           = local.count_of_availability_zones + 1
  min_size           = local.count_of_availability_zones

  launch_template {
    id      = aws_launch_template.vm_template.id
    version = "$Latest"
  }
}