From: daniel.sangorrin@toshiba.co.jp (Daniel Sangorrin)
Date: Thu, 1 Jun 2017 22:30:58 +0900
Subject: [cip-dev] Kernel feature support - filesystems and networking
In-Reply-To: <1496225732.2083.58.camel@codethink.co.uk>
References: <1496023981.2083.43.camel@codethink.co.uk>	<390B4EACA1A32748BA6BC7F859F7D71656BF302D@GSjpTKYDCembx32.service.hitachi.net>
	<1496225732.2083.58.camel@codethink.co.uk>
Message-ID: <009f01d2dadb$5843d860$08cb8920$@toshiba.co.jp>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

> -----Original Message-----
> From: cip-dev-bounces at lists.cip-project.org [mailto:cip-dev-bounces at lists.cip-project.org] On Behalf Of Ben Hutchings
> Sent: Wednesday, May 31, 2017 7:16 PM
> To: ???? / KOGUCHI?TAKUO
> Cc: cip-dev at lists.cip-project.org
> Subject: Re: [cip-dev] Kernel feature support - filesystems and networking
> 
> On Mon, 2017-05-29 at 02:40 +0000, ???? / KOGUCHI?TAKUO wrote:
> > Hi Ben,
> >
> > Thanks for your efforts.
> >
> > > - overlayfs (CONFIG_OVERLAY_FS)
> > OVERLAY_FS is one of the features Hitachi wants to use.
> > I hope you look into this further and I would like to know if other members also want it.
> 
> Yes, I thought this was popular.  I think we will have to find some way
> to support it.
> 

During the CIP TSC meeting I proposed using Ubuntu kernel backports.
http://kernel.ubuntu.com/git/ubuntu/ubuntu-xenial.git/log/fs/overlayfs

What do you think?

Thanks,
Daniel


 
