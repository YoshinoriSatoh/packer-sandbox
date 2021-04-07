# If you don't set a default, then you will need to provide the variable
# at run time using the command line, or set it in the environment. For more
# information about the various options for setting variables, see the template
# [reference documentation](https://www.packer.io/docs/templates)
variable "ami_name" {
  type    = string
  default = "wordpress-nginx-bitnami"
}

variable "profile" {
  type    = string
}

variable "region" {
  type    = string
  default = "ap-northeast-1"
}

variable "instance_type" {
  type    = string
  default = "t3a.micro"
}

locals { timestamp = regex_replace(timestamp(), "[- TZ:]", "") }

# source blocks configure your builder plugins; your source is then used inside
# build blocks to create resources. A build block runs provisioners and
# post-processors on an instance created by the source.
source "amazon-ebs" "wordpress-nginx-bitnami" {
  profile       = "${var.profile}"
  region        = "${var.region}"
  instance_type = "${var.instance_type}"
  ami_name      = "${var.ami_name} ${local.timestamp}"
  source_ami_filter {
    filters = {
      name = "bitnami-wordpresspro-5.7-2-linux-debian-10-x86_64-hvm-ebs-*"
      virtualization-type: "hvm",
      root-device-type: "ebs"
    }
    most_recent = true
    owners      = ["aws-marketplace"]
  }
  ssh_username = "bitnami"
}

# a build block invokes sources and runs provisioning steps on them.
build {
  sources = ["source.amazon-ebs.wordpress-nginx-bitnami"]
  provisioner "shell-local" {
    script = "./files/var/www/wordpress/initialize.sh"
    environment_vars = [
      "SRC_WP_INIT_PATH={{user `src_wp_init_path`}}",
      "EMAIL_TO_ADDRESS={{user `email_to_address`}}",
      "EMAIL_FROM_ADDRESS={{user `email_from_address`}}",
      "SMTP_USERNAME={{user `smtp_username`}}",
      "SMTP_PASSWORD={{user `smtp_password`}}",
    ]
  }
  provisioner "file" {
    destination = "/tmp/"
    source      = "./toupload"
  }
  provisioner "shell" {
    script = "provision.sh"
  }
}
