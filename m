From: nobuhiro1.iwamatsu@toshiba.co.jp (nobuhiro1.iwamatsu at toshiba.co.jp)
Date: Sun, 14 Jul 2019 22:42:50 +0000
Subject: [cip-dev] Request for guidance: removal of old config files
 [was: Kernel configurations for 4.19?]
In-Reply-To: <fae9b423882c15f5e31eaef237086f38055dcfce.camel@codethink.co.uk>
References: <1555501985.3557.26.camel@codethink.co.uk>
	<9210b0ba912e7a8c64f6562b43f25e4763ac4379.camel@codethink.co.uk>
	<7c8d175eaa43357d6484c6fee89c4d0f@codethink.co.uk>
	<909b4353-87c9-08e2-46f1-4ef8ce3fb6d2@siemens.com>
	<fae9b423882c15f5e31eaef237086f38055dcfce.camel@codethink.co.uk>
Message-ID: <OSBPR01MB4184B2667DAF950E5E53623392CC0@OSBPR01MB4184.jpnprd01.prod.outlook.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi Ben,

> -----Original Message-----
> From: cip-dev-bounces at lists.cip-project.org
> [mailto:cip-dev-bounces at lists.cip-project.org] On Behalf Of Ben
> Hutchings
> Sent: Saturday, July 13, 2019 1:35 AM
> To: Jan Kiszka <jan.kiszka@siemens.com>
> Cc: takehisa.katayama.bx at renesas.com; sz.lin at moxa.com;
> cip-dev at lists.cip-project.org
> Subject: Re: [cip-dev] Request for guidance: removal of old config files
> [was: Kernel configurations for 4.19?]
> 
> On Thu, 2019-07-11 at 18:51 +0200, Jan Kiszka wrote:
> [...]
> > > 4.19/arm/hitachi_omap_defconfig
> > > 4.19/arm/moxa_mxc_defconfig
> > > 4.19/arm/siemens_am335x-axm2_defconfig
> > > 4.19/arm/siemens_am335x-draco_defconfig
> > > 4.19/arm/siemens_am335x-dxr2_defconfig
> > > 4.19/arm/siemens_am335x-etamin_defconfig
> > > 4.19/arm/siemens_am57xx-pxm3_defconfig
> >
> > Those can go, I'm not aware of their usage on 4.19. But do we have one
> > for the am335-x-based BBB, our reference board?
> 
> Good point.  I have not yet tried running 4.19 on the BBB, but I can look
> at adding one - or perhaps Nobuhiro or Pavel already has a suitable config?

I have a BBB, but I do not try running 4.19 on BBB.
I will try this.

> 
> > > 4.19/arm/toshiba_tegra_defconfig
> > > 4.19/arm/toshiba_zynq_defconfig
> > > 4.19/powerpc/toshiba_defconfig
> > > 4.19/x86/plathome_obsvx1.config
> > > 4.19/x86/siemens_i386-rt.config
> >
> > I do not recall the history of that one anymore. We should have at
> > least one -rt config for x86 somewhere.
> 
> Yes, and also the build rules should check out -rt branches instead of
> the main CIP branches when processing an -rt configuration.
> 
> > > 4.19/x86/siemens_iot2000.config
> > > 4.19/x86/siemens_server_defconfig
> >
> > Those two should stay.
> 
> But they need to be reviewed, as automatic config updates usually don't
> cope with renaming of config symbols.
> 

Best regards,
  Nobuhiro
