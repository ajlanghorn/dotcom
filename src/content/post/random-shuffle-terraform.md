+++
title = "Terraform's random_shuffle resource"
date = "2016-11-21T16:37:01Z"
slug = "random-shuffle-terraform"
+++

Today I learned about the `random_shuffle` resource in Terraform, and wanted
to write a quick note about the use I found for it today.

Some resources in Terraform have required attributes which can only accept
one value, but are the only or nicest way to architect for failure scenarios
occurring.

An example I came across today was the `aws_emr_cluster` resource's
`subnet_id` key in the `ec2_attributes` block. Subnets abstract availability
zones at my current projects, since we attach one subnet to one availability
zone. When we come to need to specify multiple availability zones, I ran in
to a problem: the `subnet_id` key only accepts a single-value string.

So, I used the `random_shuffle` resource to input a list of my subnet IDs,
and limit the returned values to one entry. And then I pumped that in to the
`subnet_id` value, and limited the scope to the first entry in the list (0).

Here's how that looks:

```
resource "random_shuffle" "az" {
  input = [
    "${aws_subnet.emr-private-a.id}",
    "${aws_subnet.emr-private-b.id}",
    "${aws_subnet.emr-private-c.id}"
  ]
  result_count = 1
}

resource "aws_emr_cluster" "emr" {
  name = "emr"
  ...
  ec2_attributes {
    ...
    subnet_id = "${random_shuffle.az.result[0]}"
  }
}
```

Each time that runs, the IDs for each of the referenced subnets are
interpolated from the state file, and then Terraform returns a list of one,
the value being the ID randomly chosen from the available input values.

And, then, in order to manipulate the list to a string, we choose the first
(and, actually, only) value of the returned list and give that to
`subnet_id`.

And the nice thing is that there are no hardcoded values, so the same code
should work across different AWS accounts.

It's working a charm for us, spinning up EMR clusters in any available AZ,
reducing our reliance on one AZ.

