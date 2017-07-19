From: biju.das@bp.renesas.com (Biju Das)
Date: Wed, 19 Jul 2017 08:24:45 +0000
Subject: [cip-dev] [PATCH  0/6] Basic SoC support for r8a7743/r8a7745
In-Reply-To: <1500393500.1935.119.camel@codethink.co.uk>
References: <1499851271-20037-1-git-send-email-biju.das@bp.renesas.com>
	<1500391823.1935.111.camel@codethink.co.uk>
	<1500393500.1935.119.camel@codethink.co.uk>
Message-ID: <KL1PR06MB1702DE0CA0C499B831FFC8F4B8A60@KL1PR06MB1702.apcprd06.prod.outlook.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org



> -----Original Message-----
> From: Ben Hutchings [mailto:ben.hutchings at codethink.co.uk]
> Sent: 18 July 2017 16:58
> To: Biju Das <biju.das@bp.renesas.com>
> Cc: Chris Paterson <Chris.Paterson2@renesas.com>; cip-dev at lists.cip-
> project.org
> Subject: Re: [PATCH 0/6] Basic SoC support for r8a7743/r8a7745
>
> On Tue, 2017-07-18 at 16:30 +0100, Ben Hutchings wrote:
> > On Wed, 2017-07-12 at 10:21 +0100, Biju Das wrote:
> > > This series aims to add basic SoC support for r8a7743/r8a7745. All
> > > the patches in this series are cherry-picked from the upstream
> > > kernel.
> > >
> > > This series has been tested against linux-cip tag v4.4.75-cip6.
> >
> > These all look good to me, so I've applied these to the
> > linux-4.4.y-cip branch.  Are you going to add more driver support
> > (e.g. ravb, xhci-rcar) and device tree sources?
>
> Actually, there's something not quite right here.  With just
> CONFIG_ARCH_R8A7743 and CONFIG_ARCH_R8A7745 enabled (but no other R-
> Car
> platforms) I get:

The patches are for Basic SoC support. Next I am planning Clock driver, then DT support for SoC, then Board DTS
and then Enabling the config option(CONFIG_ARCH_R8A7743 and CONFIG_ARCH_R8A7745) .
>
> arch/arm/mach-shmobile/built-in.o: In function `rcar_gen2_timer_init':
> /home/bwh/ln001-cip/kernel/arch/arm/mach-shmobile/setup-rcar-gen2.c:131:
> undefined reference to `rcar_gen2_clocks_init'
>
> There seems to have been a lot of refactoring of drivers/clk/{shmobile,renesas}
> since 4.4 so I'm not sure how this should be fixed.

Current upstreamed RZ/G1M clock driver uses the new Renesas CPG/MSSR clock  driver frame work.
Backporting requires lot of refactoring of drivers/clk/{shmobile,renesas}.
So I don't think backporting the RZ/G1M clock driver is the right choice.

However r8a7743( RZ/G1M) is identical to r8a7791(RCar-M2) platform. We ported r8a7743( RZ/G1M) clk driver based on this.
The current patch series, which I submitted is tested with this clk driver.

>
> Ben.
>
> --
> Ben Hutchings
> Software Developer, Codethink Ltd.
>




Renesas Electronics Europe Ltd, Dukes Meadow, Millboard Road, Bourne End, Buckinghamshire, SL8 5FH, UK. Registered in England & Wales under Registered No. 04586709.
