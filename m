From: biju.das@bp.renesas.com (Biju Das)
Date: Wed, 19 Jul 2017 13:59:10 +0000
Subject: [cip-dev] [PATCH  0/6] Basic SoC support for r8a7743/r8a7745
In-Reply-To: <1500472467.1935.124.camel@codethink.co.uk>
References: <1499851271-20037-1-git-send-email-biju.das@bp.renesas.com>
	<1500391823.1935.111.camel@codethink.co.uk>
	<1500393500.1935.119.camel@codethink.co.uk>
	<KL1PR06MB1702DE0CA0C499B831FFC8F4B8A60@KL1PR06MB1702.apcprd06.prod.outlook.com>
	<1500472467.1935.124.camel@codethink.co.uk>
Message-ID: <KL1PR06MB1702CAD91500A927559B835FB8A60@KL1PR06MB1702.apcprd06.prod.outlook.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org



> -----Original Message-----
> From: Ben Hutchings [mailto:ben.hutchings at codethink.co.uk]
> Sent: 19 July 2017 14:54
> To: Biju Das <biju.das@bp.renesas.com>
> Cc: Chris Paterson <Chris.Paterson2@renesas.com>; cip-dev at lists.cip-
> project.org
> Subject: Re: [PATCH 0/6] Basic SoC support for r8a7743/r8a7745
>
> On Wed, 2017-07-19 at 08:24 +0000, Biju Das wrote:
> [...]
> > > Actually, there's something not quite right here.  With just
> > > CONFIG_ARCH_R8A7743 and CONFIG_ARCH_R8A7745 enabled (but no
> other R-
> > > Car
> > > platforms) I get:
> >
> > The patches are for Basic SoC support. Next I am planning Clock
> > driver, then DT support for SoC, then Board DTS and then Enabling the config
> option(CONFIG_ARCH_R8A7743 and CONFIG_ARCH_R8A7745) .
> > >
> > > arch/arm/mach-shmobile/built-in.o: In function `rcar_gen2_timer_init':
> > > /home/bwh/ln001-cip/kernel/arch/arm/mach-shmobile/setup-rcar-
> gen2.c:131:
> > > undefined reference to `rcar_gen2_clocks_init'
> > >
> > > There seems to have been a lot of refactoring of
> > > drivers/clk/{shmobile,renesas} since 4.4 so I'm not sure how this should be
> fixed.
> >
> > Current upstreamed RZ/G1M clock driver uses the new Renesas CPG/MSSR
> clock  driver frame work.
> > Backporting requires lot of refactoring of drivers/clk/{shmobile,renesas}.
> > So I don't think backporting the RZ/G1M clock driver is the right choice.
>
> OK.
>
> > However r8a7743( RZ/G1M) is identical to r8a7791(RCar-M2) platform. We
> ported r8a7743( RZ/G1M) clk driver based on this.
> > The current patch series, which I submitted is tested with this clk driver.
>
> Then I think I should just make this change:
>
> Subject: CIP: Build essential clock driver for Renesas RZ/G1 platforms
>
> In mainline, clk-rcar-gen2 is selected by CONFIG_CLK_RCAR_GEN2 but here
> there is no such common config symbol and we need to select it for each
> platform.
>
> Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
> ---
>  drivers/clk/shmobile/Makefile | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/clk/shmobile/Makefile b/drivers/clk/shmobile/Makefile
> index 97c71c885e4f..b339c0b6bb2f 100644
> --- a/drivers/clk/shmobile/Makefile
> +++ b/drivers/clk/shmobile/Makefile
> @@ -2,6 +2,8 @@ obj-$(CONFIG_ARCH_EMEV2)+= clk-
> emev2.o
>  obj-$(CONFIG_ARCH_R7S72100)+= clk-rz.o
>  obj-$(CONFIG_ARCH_R8A73A4)+= clk-r8a73a4.o
>  obj-$(CONFIG_ARCH_R8A7740)+= clk-r8a7740.o
> +obj-$(CONFIG_ARCH_R8A7743)+= clk-rcar-gen2.o
> +obj-$(CONFIG_ARCH_R8A7745)+= clk-rcar-gen2.o
>  obj-$(CONFIG_ARCH_R8A7778)+= clk-r8a7778.o
>  obj-$(CONFIG_ARCH_R8A7779)+= clk-r8a7779.o
>  obj-$(CONFIG_ARCH_R8A7790)+= clk-rcar-gen2.o
> --- END ---
>
> Right?
Yes. That is correct.

> Ben.
>
> --
> Ben Hutchings
> Software Developer, Codethink Ltd.
>




Renesas Electronics Europe Ltd, Dukes Meadow, Millboard Road, Bourne End, Buckinghamshire, SL8 5FH, UK. Registered in England & Wales under Registered No. 04586709.
