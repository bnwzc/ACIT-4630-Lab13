output "tag_names" {
    value = [for i in aws_instance.instances: i.tags["Name"]]
}

output "private_ips" {
    value = [for i in aws_instance.instances: i.private_ip]
}

output "instances" {
    value = [for i in aws_instance.instances: i]
}