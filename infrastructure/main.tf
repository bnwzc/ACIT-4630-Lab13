module "network" {
  source       = "./modules/network"
  region       = "us-west-2"
  vpc_ip       = "10.0.0.0/16"
  subnet_ips   = ["10.0.1.0/24", "10.0.2.0/24"]
  availability_zones = ["us-west-2a", "us-west-2b"]
}

module "ec2" {
  source       = "./modules/ec2"
  ami          = "ami-03839f1dba75bb628"
  instance_type= "t2.micro"
  subnet_ids   = module.network.subnet_ids
  security_groups = module.network.security_groups
  key_name     = module.ssh_key.ssh_key_name

}
module "dns_dhcp" {
  source       = "./modules/DNS_DHCP"
  domain_name  = "cit.local"
  domain_name_server = "AmazonProvidedDNS"
  vpc_id       = module.network.vpc_id
  tag_names    = module.ec2.tag_names
  private_ips  = module.ec2.private_ips
}

module "ssh_key" {
  source       = "git::https://gitlab.com/acit_4640_library/tf_modules/aws_ssh_key_pair.git"
  ssh_key_name = "acit_4640_lab_13"
  output_dir   = path.root
}

module "connect_script" {
  source           = "git::https://gitlab.com/acit_4640_library/tf_modules/aws_ec2_connection_script.git"
  ec2_instances    = { "i1" = module.ec2.instances[0], "i2" = module.ec2.instances[1] }
  output_file_path = "${path.root}/connect_vars.sh"
  ssh_key_file     = module.ssh_key.priv_key_file
  ssh_user_name    = "ubuntu"
}