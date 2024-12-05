resource "aws_instance" "instances" {
    count        = 2
    ami          = var.ami
    instance_type= var.instance_type
    subnet_id    = var.subnet_ids[count.index]
    security_groups = [var.security_groups[count.index]]
    key_name     = var.key_name
    tags = {
        Name = count.index == 0 ? "w01" : "b01"
        Server_Role = count.index == 0 ? "web" : "backend"
        Project = "lab13"
    }
    user_data = <<-EOF
            #!/bin/bash
            hostnamectl set-hostname 'i${count.index + 1}'
            EOF
}