From: Chris.Paterson2@renesas.com (Chris Paterson)
Date: Wed, 12 Apr 2017 08:34:29 +0000
Subject: [cip-dev] u-boot policy for CIP
In-Reply-To: <1490378001.3749.155.camel@codethink.co.uk>
References: <HK2PR0601MB13296740334D8058F10B1919B7260@HK2PR0601MB1329.apcprd06.prod.outlook.com>
	<1490378001.3749.155.camel@codethink.co.uk>
Message-ID: <HK2PR0601MB13298568C67F80A2CB715CC4B7030@HK2PR0601MB1329.apcprd06.prod.outlook.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hello all,

I'd like to reach some conclusion on the discussion/policy about u-boot. We briefly spoke about it in the last TSC, and agreed to continue the discussion here.

As highlighted by Ben and Wolfgang, a policy should be driven by the use-case requirements from the member companies. Until more feedback comes in from the member companies, would it be an idea for me to draft an outline policy we can use to focus discussions? Sometimes it is easier to have a starting point to amend, rather than waffle aimlessly.

On a side note, I won't be able to attend the next TSC (Easter holidays), but please continue the discussion without me.


Kind regards, Chris


> From: Ben Hutchings [mailto:ben.hutchings at codethink.co.uk]
> Sent: 24 March 2017 17:53
> 
> On Thu, 2017-03-16 at 12:07 +0000, Chris Paterson wrote:
> 
> > I?m bringing a discussion I?ve started in other places here as it will
> > benefit from wider participation.
> 
> Thank you.  I have limited knowledge of u-boot, but I did work on it recently
> to add support for a new board.
> 
> [...]
> > Ideally CIP should choose a version of u-boot and use it when
> > testing/verifying the CIP Kernel on the reference hardware.
> 
> We should certainly pick one version for each reference board.
> 
> > How we actively maintain that version (bug fixes/security
> > patches/features?) is another question. Given that most devices in the
> > field won?t have a way to update u-boot in the field (security
> > issues/practicalities), I think ?SLTS? support for u-boot may not be
> > required. Perhaps we just tag a version of u-boot at the launch of a
> > new CIP Kernel and stick with it?
> 
> If u-boot is configured to use network boot, or to require authentication of
> its environment or boot images, or authentication to interrupt boot
> (CONFIG_AUTOBOOT_KEYED=y), then it is sometimes handling untrusted
> input and might need security updates.  Otherwise it probably does not.
> 
> It seems possible that some fixes might be needed to improve reliability, e.g.
> if boot timing changes as hardware gets older.
> 
> > How do we decide what u-boot version to support? Currently it looks
> > like the BBB platform are shipped with 2014.04
> 
> I have a new BBB that came with 2015.10 installed.  So we cannot be certain
> that a particular model of board will always be shipped with the same
> version!
> 
> > and the Renesas platform is shipped with 2013.01. That said, it looks
> > like there is upstream support for BBB [1], but how the feature set
> > compares to the version shipped with the platform I don?t know. There
> > is also support for some Renesas platforms [2], but not for the exact
> > board CIP will be using.
> >
> > Do we want to push Ti/Renesas to ensure there is full support for
> > their boards upstream? When this is done do we pick the first version
> > that includes this support to work with? Or do we just stick with the
> > vendor provided forks?
> 
> I don't have an opinion on whether CIP should provide support for u-boot,
> beyond the testing it will get through booting each kernel to be tested.  If we
> do, I would prefer not to include vendor forks as this could greatly increase
> the maintenance effort.
> 
> > Is there a particular feature set that CIP requires?
> [...]
> 
> For testing purposes we will need at least an unauthenticated command
> prompt (CONFIG_AUTOBOOT_KEYED=n), networking and TFTP support.
> That probably isn't a complete list.
> 
> Ben.
> 
> --
> Ben Hutchings
> Software Developer, Codethink Ltd.
> 
