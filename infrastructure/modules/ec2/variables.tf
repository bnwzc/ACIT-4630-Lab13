variable ami {
    description = "ami"
}

variable instance_type {
    description = "instance_type"
}

variable subnet_ids {
    description = "subnet ids"
    type        = list(string)
}

variable security_groups {
    description = "security groups"
    type        = list(string)
}

variable key_name {
    description = "key_name"
}