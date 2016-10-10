resource "aws_vpc" "dotcom" {
  cidr_block = "10.0.0.0/16"
  enable_dns_hostnames = "true"
  tags {
    Name = "dotcom"
  }
}

resource "aws_subnet" "dotcom-private-a" {
  vpc_id = "${aws_vpc.dotcom.id}"
  cidr_block = "10.0.1.0/24"
  availability_zone = "${data.aws_availability_zones.available.names[0]}"
}

resource "aws_subnet" "dotcom-private-b" {
  vpc_id = "${aws_vpc.dotcom.id}"
  cidr_block = "10.0.2.0/24"
  availability_zone = "${data.aws_availability_zones.available.names[1]}"
}

resource "aws_vpc_dhcp_options" "dotcom" {
  domain_name_servers = ["AmazonProvidedDNS"]
}
