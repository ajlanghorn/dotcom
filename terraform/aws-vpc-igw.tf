resource "aws_internet_gateway" "dotcom-public" {
  vpc_id = "${aws_vpc.dotcom.id}"
}

resource "aws_route_table" "dotcom-public" {
  vpc_id = "${aws_vpc.dotcom.id}"
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.dotcom-public.id}"
  }
}
