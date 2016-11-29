From: daniel.sangorrin@toshiba.co.jp (Daniel Sangorrin)
Date: Tue, 29 Nov 2016 12:28:49 +0900
Subject: [cip-dev] Update week 47
In-Reply-To: <583AC090.6050608@codethink.co.uk>
References: <583AC090.6050608@codethink.co.uk>
Message-ID: <002401d249f0$b34b9760$19e2c620$@toshiba.co.jp>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi,

(Cc'ed to Fuego and LTSI mailing lists).

> -----Original Message-----
> From: cip-dev-bounces at lists.cip-project.org [mailto:cip-dev-bounces at lists.cip-project.org] On Behalf Of Agustin Benito Bethencourt
> Sent: Sunday, November 27, 2016 8:17 PM
> To: cip-dev at lists.cip-project.org
> Subject: [cip-dev] Update week 47
...
> ++ Testing
> 
>   * The testing project has been created in Gitlab. A couple of
> colleagues at Codethink has picked up the initial effort done by Siemens
> and move it forward, in order to create a virtual machine with kernelci[2].
> **The goal of the first milestone is that any developer with a board at
> her desk can test a kernel and see the results of those tests in her own
> machine.
> ** A tutorial will be published for those of you not familiar with the
> tools involved.
> 
> If you are interested in using kernelci in your company, please join our
> effort. Collaboration is working.
> [2] https://gitlab.com/cip-project/testing/tree/master

I am planning to add support for kernel-ci on Fuego (Jenkins + a bunch of tests)
using "https://ci.linaro.org/view/kernel-ci/" as a reference. That is, Fuego will git-trigger
and perform kernel builds, and then send the results to a kernel-ci server (e.g. a 
local vagrant server or https://kernelci.org) using its REST API.

My short-term vision is:

[Fuego at toshiba]
....                                   ----build results--------> [Kernel-ci at server]
[Fuego@<company X>]

Fuego can also be used for visualizing the local build results (maybe not as pretty as kernel-ci's dashboard) but 
as far as I know it doesn't have the kind of back-end API that kernel-ci has. For that reason, although for
local testing Fuego is enough, we need a way to publish the results (mostly so that
maintainers can see them).

However, my long-term vision would be:

[Fuego at toshiba]
....                                   ----build/boot/LTP/Cyclictest/other_tests results--------> [Fuego OR modified kernel-ci at server]
[Fuego@<company X>]

In other words, Build and Boot tests are good but not enough. There are many other tests that we
want to run (e.g. tests in Fuego for both the kernel and the root filesystem).  I can see at least two options 
for implementing that:
   Option 1: Extend kernel-ci to support other type of tests.
   Option 2: Add a backend REST API to Fuego similar to the one kernel-ci has.

Any feedback would be welcome.

Best regards,
Daniel

[1] http://bird.org/ffiles/Introduction-to-Fuego-LCJ-2016.pdf
