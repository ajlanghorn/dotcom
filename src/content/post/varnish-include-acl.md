+++
tags = [
  "",
  "",
]
title = "Easily managing ACLs in Varnish"
date = "2015-05-09T00:00:00+00:00"
slug = "varnish-include-acl"

+++

[Varnish](https://varnish-cache.org) is a popular caching HTTP reverse
proxy, used by organisations large and smaller to reduce load on their
canonical origins, to speed up page response times, and to tamper with HTTP
requests and responses which pass through it. It's easily one of my
favourite tools to use when building infrastructure, given how extensible it
is, and for how many use cases it can be an answer.

I want to focus on a little trick I try regularly to tidy up my VCL (the
Varnish Configuration Language). Let's say we have a specific snippet that I
want to use across multiple VCL files, but I don't want to have to update
the snippet everywhere every time a change is made. A good example might be
an access control list, or `ACL`.

## Creating the ACL

Firstly, we need to define the ACL. We can do this in a new file - you might
wish to separate your files to include, like this one, in to a separate
directory - with this content:

```
acl restrict_purge {
  "1.2.3.4";
  "10.20.30.40"/27;
}
```

The `restrict_purge` section is simply a descriptive name: call it whatever
you wish, although I find it easier to name snippets as I would functions
when programming, in that their purpose is clear and they aren't too finely
scoped. Make sure, howver, that you keep `acl` at the start, since that's
what Varnish is using here to work out that this section is an ACL. You'll
end up in a sticky place if that's not there.

## Using the ACL

Now that we've got our ACL defined, we can start to use it. Head in to your
main VCL (where you've got your Varnish functions defined), and add the
following lines to `vcl_recv`:

```
if (req.request == "PURGE" && !(client.ip ~ purge_whitelist)) {
  error 403 "Forbidden";
}
```

Here, we're saying that if the HTTP request is sent with the PURGE method,
and the source IP isn't contained in the `purge_whitelist` ACL we defined
earlier, Varnish should route the request to `vcl_error` and return a 403
without processing the request further at all.

## Using `include`

At this stage, the logic in our main VCL to check the client IP against the
ACL we created earlier doesn't yet do exactly what we're after since we've
not included the ACL. That's a one-liner:

```
include restrict_purge.vcl
```

And there you have it: a reusable snippet of VCL with an ACL inside that you
can use across VCL files. That should keep your VCL a little cleaner when
you have shared dependencies of data.
