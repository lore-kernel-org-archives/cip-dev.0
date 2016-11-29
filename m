From: Tim.Bird@am.sony.com (Bird, Timothy)
Date: Tue, 29 Nov 2016 06:10:29 +0000
Subject: [cip-dev] [Fuego]  Update week 47
In-Reply-To: <002401d249f0$b34b9760$19e2c620$@toshiba.co.jp>
References: <583AC090.6050608@codethink.co.uk>
	<002401d249f0$b34b9760$19e2c620$@toshiba.co.jp>
Message-ID: <ECADFF3FD767C149AD96A924E7EA6EAF0ABB7A82@USCULXMSG01.am.sony.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org



> -----Original Message-----
> From: fuego-bounces at lists.linuxfoundation.org [mailto:fuego-
> bounces at lists.linuxfoundation.org] On Behalf Of Daniel Sangorrin
> Sent: Tuesday, November 29, 2016 12:29 PM
> To: 'Agustin Benito Bethencourt' <agustin.benito@codethink.co.uk>; cip-
> dev at lists.cip-project.org
> Cc: ltsi-dev at lists.linuxfoundation.org; fuego at lists.linuxfoundation.org
> Subject: Re: [Fuego] [cip-dev] Update week 47
> 
> Hi,
> 
> (Cc'ed to Fuego and LTSI mailing lists).
> 
> > -----Original Message-----
> > From: cip-dev-bounces at lists.cip-project.org [mailto:cip-dev-
> bounces at lists.cip-project.org] On Behalf Of Agustin Benito Bethencourt
> > Sent: Sunday, November 27, 2016 8:17 PM
> > To: cip-dev at lists.cip-project.org
> > Subject: [cip-dev] Update week 47
> ...
> > ++ Testing
> >
> >   * The testing project has been created in Gitlab. A couple of
> > colleagues at Codethink has picked up the initial effort done by Siemens
> > and move it forward, in order to create a virtual machine with kernelci[2].
> > **The goal of the first milestone is that any developer with a board at
> > her desk can test a kernel and see the results of those tests in her own
> > machine.
> > ** A tutorial will be published for those of you not familiar with the
> > tools involved.
> >
> > If you are interested in using kernelci in your company, please join our
> > effort. Collaboration is working.
> > [2] https://gitlab.com/cip-project/testing/tree/master
> 
> I am planning to add support for kernel-ci on Fuego (Jenkins + a bunch of
> tests)
> using "https://ci.linaro.org/view/kernel-ci/" as a reference. That is, Fuego will
> git-trigger
> and perform kernel builds, and then send the results to a kernel-ci server
> (e.g. a
> local vagrant server or https://kernelci.org) using its REST API.
> 
> My short-term vision is:
> 
> [Fuego at toshiba]
> ....                                   ----build results--------> [Kernel-ci at server]
> [Fuego@<company X>]
> 
> Fuego can also be used for visualizing the local build results (maybe not as
> pretty as kernel-ci's dashboard) but
> as far as I know it doesn't have the kind of back-end API that kernel-ci has.
> For that reason, although for
> local testing Fuego is enough, we need a way to publish the results (mostly
> so that
> maintainers can see them).
> 
> However, my long-term vision would be:
> 
> [Fuego at toshiba]
> ....                                   ----build/boot/LTP/Cyclictest/other_tests results-------->
> [Fuego OR modified kernel-ci at server]
> [Fuego@<company X>]
> 
> In other words, Build and Boot tests are good but not enough. There are
> many other tests that we
> want to run (e.g. tests in Fuego for both the kernel and the root filesystem).
> I can see at least two options
> for implementing that:
>    Option 1: Extend kernel-ci to support other type of tests.
>    Option 2: Add a backend REST API to Fuego similar to the one kernel-ci has.
> 
> Any feedback would be welcome.

This sounds really great.

I would really like to see how the two systems (kernelci and fuego) could be
integrated, so I am interested in this work.  I see kernelci and fuego as complementary.
That's why I'm focusing on the runtime aspects of Fuego, and not on the
build/boot tests, at the moment.

If we extend kernel-ci to support other types of tests, it would be nice if
there were some ability to reuse aspects of fuego test definitions there.

I got together with Fenguang Wu (the author of the 0day test project) at plumbers,
and found that 0day and Fuego has some very similar concepts, and we might
be able to share some materials.  0day is missing visualization tools for results,
and doesn't support the  notion of cross-compilation yet.  But they have similar
test phases (download, build, deploy, test, gather logs, parse results).  For an initial
attempt at writing a standard test API, I was hoping I could find enough common
ground between 0day and Fuego to support the same test collateral between the
two systems.  From what I have seen so far, the test API for LAVA (which kernelci
is based on) also has some similar concepts, but they haven't gotten around
to formalizing the API in a way that could be used as the common shared API
with multiple systems.

Regards,
 -- Tim
