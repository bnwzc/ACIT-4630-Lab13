output "subnet_ids" {
    value = [for subnet in aws_subnet.subnets : subnet.id]
}
output "security_groups" {
    value = [for security_group in aws_security_group.main : security_group.id]
}
output "vpc_id" {
    value = aws_vpc.main.id
}