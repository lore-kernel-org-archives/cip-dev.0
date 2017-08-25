From: biju.das@bp.renesas.com (Biju Das)
Date: Fri, 25 Aug 2017 15:52:57 +0000
Subject: [cip-dev] [PATCH 01/14] ARM: dts: r8a7743: initial SoC device
	tree
In-Reply-To: <1503675645.2047.158.camel@codethink.co.uk>
References: <1502185828-45443-1-git-send-email-biju.das@bp.renesas.com>
	<1502185828-45443-2-git-send-email-biju.das@bp.renesas.com>
	<1503425253.2047.148.camel@codethink.co.uk>
	<KL1PR06MB1702CBCF9CD3050E0102A78AB8850@KL1PR06MB1702.apcprd06.prod.outlook.com>
	<1503675645.2047.158.camel@codethink.co.uk>
Message-ID: <KL1PR06MB1702827781FA06F92CD4290BB89B0@KL1PR06MB1702.apcprd06.prod.outlook.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org



> -----Original Message-----
> From: Ben Hutchings [mailto:ben.hutchings at codethink.co.uk]
> Sent: 25 August 2017 16:41
> To: Biju Das <biju.das@bp.renesas.com>
> Cc: Chris Paterson <Chris.Paterson2@renesas.com>; cip-dev at lists.cip-
> project.org
> Subject: Re: [PATCH 01/14] ARM: dts: r8a7743: initial SoC device tree
>
> On Wed, 2017-08-23 at 07:36 +0000, Biju Das wrote:
> >
> >
> > > -----Original Message-----
> > > From: Ben Hutchings [mailto:ben.hutchings at codethink.co.uk]
> > > Sent: 22 August 2017 19:08
> > > To: Biju Das <biju.das@bp.renesas.com>
> > > Cc: Chris Paterson <Chris.Paterson2@renesas.com>; cip-dev at lists.cip-
> > > project.org
> > > Subject: Re: [PATCH 01/14] ARM: dts: r8a7743: initial SoC device
> > > tree
> > >
> > > On Tue, 2017-08-08 at 10:50 +0100, Biju Das wrote:
> > > > The  initial r8A7743 SoC device tree including CPU0, GIC and timer.
> > > >
> > > > Signed-off-by: Biju Das <biju.das@bp.renesas.com>
> > >
> > > I compared this to the upstream version (commit
> > > 34e8d993a68ae459ad98c27afc07647e439deacc) and I roughly understand
> > > why the clocks are described differently, but can you explain why
> > > there's no soc node?
> >
> > Thanks for the comments.
> >
> > RZ/G1M(r8a7743) and R-Car M2(r8a7791) are almost identical. To make
> > consistant with other R-Car Gen2 dtsi patches on 4.4 kernel version, I have
> dropped the soc node.
>
> But in the upstream device tree sources, r8a7743.dtsi has an soc node and
> r8a7791.dtsi does not.  If it's OK for the two chips to be described differently
> upstream, I don't see why they should be described consistently here.
>
> > Do you see any issues with this approach?
> [...]
>
> I think that consistency with upstream is more important than consistency
> within the platform.  (Of course, the kernel and FDT need to actually *work*,
> and if introducing the soc node gets in the way of that then we shouldn't do it.)

OK. I will investigate this  and let you know.

> Ben.
>
> --
> Ben Hutchings
> Software Developer, Codethink Ltd.
>




Renesas Electronics Europe Ltd, Dukes Meadow, Millboard Road, Bourne End, Buckinghamshire, SL8 5FH, UK. Registered in England & Wales under Registered No. 04586709.
