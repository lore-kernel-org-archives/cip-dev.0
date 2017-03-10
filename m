From: ben.hutchings@codethink.co.uk (Ben Hutchings)
Date: Fri, 10 Mar 2017 12:39:41 +0000
Subject: [cip-dev] Kernel feature support
In-Reply-To: <1489085747.2949.78.camel@codethink.co.uk>
References: <1489070021.2949.73.camel@codethink.co.uk>
	<CA+TH9VmBs6kZ6x+j=2i_caGAVa3oHggxYH8NEtriB6ygP8H3zA@mail.gmail.com>
	<1489085747.2949.78.camel@codethink.co.uk>
Message-ID: <1489149581.2949.80.camel@codethink.co.uk>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

On Thu, 2017-03-09 at 18:55 +0000, Ben Hutchings wrote:
> On Thu, 2017-03-09 at 16:25 +0100, Angelo Compagnucci wrote:
> > Dear Ben Hutchings,
> > 
> > 2017-03-09 15:33 GMT+01:00 Ben Hutchings <ben.hutchings@codethink.co.uk>:
> > > We've previously agreed that not all kernel features (drivers,
> > > filesystems, network protocols, etc.) can be supported in an SLTS
> > > branch.  I'd like to start working out what the supported features
> > > should be for the 4.4 branch.
> > >
> > > Are members able to share their kernel .config files, showing which
> > > features are enabled?  Or would you prefer to specify your needs at a
> > > slightly higher level?
> > 
> > I would really like to have IIO drivers, they are generally easy to
> > backport and extremely useful in industrial contexts.
> 
> But you don't use *all* the IIO drivers, do you?

Also, I'm not talking about backports here - only about which of the
existing features in 4.4 will need SLTS.

Ben.

-- 
Ben Hutchings
Software Developer, Codethink Ltd.
