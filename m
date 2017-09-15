From: henning.schild@siemens.com (Henning Schild)
Date: Fri, 15 Sep 2017 17:43:23 +0200
Subject: [cip-dev] CIP kernel debian packages available?
In-Reply-To: <1505489264.1860.23.camel@codethink.co.uk>
References: <20170915093555.5beb3b4e@md1em3qc>
	<1505483563.1860.7.camel@codethink.co.uk>
	<9892e86c-97dc-5715-dd11-fe892c39d549@siemens.com>
	<1505489264.1860.23.camel@codethink.co.uk>
Message-ID: <20170915174323.2b9fdab5@md1em3qc>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Am Fri, 15 Sep 2017 16:27:44 +0100
schrieb Ben Hutchings <ben.hutchings@codethink.co.uk>:

> On Fri, 2017-09-15 at 16:04 +0200, Jan Kiszka wrote:
> > On 2017-09-15 15:52, Ben Hutchings wrote:  
> > > On Fri, 2017-09-15 at 09:35 +0200, Henning Schild wrote:  
> > >> Hi,
> > >>
> > >> i would like to integrate a CIP kernel into an x86_64 debian9,
> > >> for starters a defconfig would be good enough. Is there by any
> > >> chance a debian repo with cip kernels in it?  
> > > 
> > > Is this intended for Siemens use or for all CIP members with
> > > applications using x86_64?  
> > 
> > We are currently the one with the immediate use case, but I could
> > imagine that having such packages for x86-64 and maybe later on also
> > i386 and arm64 would be beneficial for others as well. It's a
> > matter of logistics and effort (at least initially).  
> 
> So long as you want your own kernel config, I would suggest building
> packages using
> 'make foo_defconfig && make deb-pkg' (substitute your preferred name
> for 'foo').  Since Linux 4.3 this builds both source and binary
> packages, so it should be easy to satisfy your source distribution
> requirements this way.

Thanks, that is exactly what i was doing already.

> If we get to a point where members can use the CIP branch without
> further patches and can share common configuration per-architecture,
> then it may be worth making a fork of Debian's official kernel
> packaging.  But if not, I think that will be more trouble to maintain
> than it's worth.

Sure, i never wanted to suggest that we need that, i just wanted to
know whether it already exists.

Henning

> Ben.
> 
> > What do others think?
> > 
> > Jan  
> 
