terraform {
  required_version = "= 0.12.19"
}

provider "aws" {
  region = "ap-northeast-1"
}

resource "aws_instance" "virtual_machine" {
  ami           = "ami-02b658ac34935766f"
  instance_type = "t2.micro"
}

output "vm_info" {
    value = {
      ip = aws_instance.virtual_machine.public_ip
      cpu = aws_instance.virtual_machine.cpu_core_count
      instance_type = aws_instance.virtual_machine.instance_type
      root_block_device = aws_instance.virtual_machine.root_block_device
    }
}