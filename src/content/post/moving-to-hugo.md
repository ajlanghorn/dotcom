+++
title = "On moving to Hugo"
date = "2016-10-09T17:39:32+01:00"
+++

I'm not particularly active when it comes to blogging, and I often wonder
whether or not half of the reason for this is because my existing blog takes
an age and a half to deploy once I've written a post.

For this reason, many posts end up either in draft form and never published,
or as heavily condensed tweetstorms, curated perfectly (of course!) for my
legion of followers.

Back in the day, this blog used to run on WordPress, but as times
progressed, I wondered why exactly I did need a relation database holding
all of my posts, and really what use I was getting out of all the additional
cruft it ships with. It's
[vulnerabilities](https://www.cvedetails.com/vulnerability-list/vendor_id-2337/product_id-4096/)
weren't too appealing, either.

So, then I moved to use Jekyll, and deployed it in to S3. This worked for a
while, but then I had to battle Ruby and some other internet beasts to get
the thing to work the way I wanted to. In the end, the process for
deployment was a little bit of hassle. However, I will say that Jekyll, and
Octopress (something else I tried for a while), are both significantly
better for my needs than WordPress was.

Since my needs are so light, I've decided to move to
[Hugo](https://gohugo.io). All I need is to
be able to write some words, run a command and have a static site built that
I can deploy anywhere. And partially, that last bit is why I chose Hugo;
because it's written in Golang, and therefore deployable most everywhere
under the sun.
