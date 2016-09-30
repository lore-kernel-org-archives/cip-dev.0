From: daniel.sangorrin@toshiba.co.jp (Daniel Sangorrin)
Date: Fri, 30 Sep 2016 10:05:06 +0900
Subject: [cip-dev] Maintenance policies and early considerations III
In-Reply-To: <57E3D4EC.2080008@codethink.co.uk>
References: <57E3D4EC.2080008@codethink.co.uk>
Message-ID: <002101d21ab6$af105960$0d310c20$@toshiba.co.jp>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi Agustin,

Sorry for the late reply.

> +++ Request to members from maintainer
> 
> During the meeting Ben requested CIP members to provide him some
> guidelines or policies currently followed to choose security patches.
> This information will hopefully provide some light that help maintainers
> to define some basic policies for choosing security fixes. This policies
> need to be tested over time.
> 
> Due to the length of the maintenance period, it is unlikely that the
> same person/team maintain the kernel for the entire life cycle so the
> main policies at least need to be left written.

I think that one possible guideline for backporting security patches to the CIP kernel
is to look at kernel CVEs [1]. A table (probably only accessible by members) 
indicating whether a CIP kernel is vulnerable or not to a CVE would be of great help.

Another source of bug/security fixes will be the PREEMPT RT patch. We will probably
need to check whether bugs found in new versions are properly backported to our
CIP kernels. 
# I see that Ben is already doing this! [2]

Finally, we may need to decide how to disclosure bugs that we may find ourselves 
while testing the CIP kernels. I guess we will need to make sure that all members are
ready for the disclosure.

Best regards
Daniel

[1] http://www.cvedetails.com/product/47/Linux-Linux-Kernel.html?vendor_id=33
[2] https://lkml.org/lkml/2016/9/29/473
