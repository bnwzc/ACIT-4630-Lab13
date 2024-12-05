resource "aws_vpc_dhcp_options" "main" {
  domain_name         = var.domain_name
  domain_name_servers = [var.domain_name_server]
}

resource "aws_vpc_dhcp_options_association" "main" {
  vpc_id          = var.vpc_id
  dhcp_options_id = aws_vpc_dhcp_options.main.id
}

resource "aws_route53_zone" "main" {
  name = var.domain_name
  vpc {
    vpc_id = var.vpc_id
  }
}

resource "aws_route53_record" "instances" {
    count   = 2
    zone_id = aws_route53_zone.main.zone_id
    name    = "${var.tag_names[count.index]}.cit.local"
    type    = "A"
    ttl     = "300"
    records = [var.private_ips[count.index]]
}