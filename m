From: daniel.sangorrin@toshiba.co.jp (Daniel Sangorrin)
Date: Fri, 2 Jun 2017 11:36:34 +0900
Subject: [cip-dev] Kernel feature support - filesystems and networking
In-Reply-To: <9fd5dc75-8c88-3f42-39e1-76582f327423@siemens.com>
References: <1496023981.2083.43.camel@codethink.co.uk>
	<390B4EACA1A32748BA6BC7F859F7D71656BF302D@GSjpTKYDCembx32.service.hitachi.net>
	<1496225732.2083.58.camel@codethink.co.uk>
	<009f01d2dadb$5843d860$08cb8920$@toshiba.co.jp>
	<9fd5dc75-8c88-3f42-39e1-76582f327423@siemens.com>
Message-ID: <000701d2db49$0d1d1130$27573390$@toshiba.co.jp>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org



> -----Original Message-----
> From: Jan Kiszka [mailto:jan.kiszka at siemens.com]
> Sent: Thursday, June 01, 2017 10:50 PM
> To: Daniel Sangorrin; 'Ben Hutchings'; '???? / KOGUCHI?TAKUO'
> Cc: cip-dev at lists.cip-project.org
> Subject: Re: [cip-dev] Kernel feature support - filesystems and networking
> 
> On 2017-06-01 15:30, Daniel Sangorrin wrote:
> >> -----Original Message-----
> >> From: cip-dev-bounces at lists.cip-project.org [mailto:cip-dev-bounces at lists.cip-project.org] On Behalf Of Ben Hutchings
> >> Sent: Wednesday, May 31, 2017 7:16 PM
> >> To: ???? / KOGUCHI?TAKUO
> >> Cc: cip-dev at lists.cip-project.org
> >> Subject: Re: [cip-dev] Kernel feature support - filesystems and networking
> >>
> >> On Mon, 2017-05-29 at 02:40 +0000, ???? / KOGUCHI?TAKUO wrote:
> >>> Hi Ben,
> >>>
> >>> Thanks for your efforts.
> >>>
> >>>> - overlayfs (CONFIG_OVERLAY_FS)
> >>> OVERLAY_FS is one of the features Hitachi wants to use.
> >>> I hope you look into this further and I would like to know if other members also want it.
> >>
> >> Yes, I thought this was popular.  I think we will have to find some way
> >> to support it.
> >>
> >
> > During the CIP TSC meeting I proposed using Ubuntu kernel backports.
> > http://kernel.ubuntu.com/git/ubuntu/ubuntu-xenial.git/log/fs/overlayfs
> >
> > What do you think?
> 
> Did overlayfs folks looked at/commented on this already? Ideally,
> maintainers should have at least a rough look on our backports whenever
> possible.

The Ubuntu LTS kernels contain patches back ported by them from upstream and
their own patches which are usually prefixed by UBUNTU. UBUNTU patches are often
based on BUG reports on launchpad.

As for overlayfs, it seems that UBUNTU has cherry-picked quite a few patches by
the main maintainer Miklos Szeredi. UBUNTU patches were mostly added by Seth Forshee
but I couldn't find any review online. 

I think it would be nice to have a rough overlook by the maintainers. And we should also
test them ourselves thoroughly. For example, running LXC with overlayfs.

Thanks,
Daniel
