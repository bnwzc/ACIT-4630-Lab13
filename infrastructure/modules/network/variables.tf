variable "region" {
    description = "region"
}
variable "vpc_ip" {
    description = "vpc ip"
}
variable "subnet_ips" {
    description = "subnet ips"
    type        = list(string)
}

variable "availability_zones" {
    description = "availability zones"
    type        = list(string)
}