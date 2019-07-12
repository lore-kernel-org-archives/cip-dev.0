From: ben.hutchings@codethink.co.uk (Ben Hutchings)
Date: Fri, 12 Jul 2019 17:34:47 +0100
Subject: [cip-dev] Request for guidance: removal of old config files
 [was: Kernel configurations for 4.19?]
In-Reply-To: <909b4353-87c9-08e2-46f1-4ef8ce3fb6d2@siemens.com>
References: <1555501985.3557.26.camel@codethink.co.uk>
	<9210b0ba912e7a8c64f6562b43f25e4763ac4379.camel@codethink.co.uk>
	<7c8d175eaa43357d6484c6fee89c4d0f@codethink.co.uk>
	<909b4353-87c9-08e2-46f1-4ef8ce3fb6d2@siemens.com>
Message-ID: <fae9b423882c15f5e31eaef237086f38055dcfce.camel@codethink.co.uk>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

On Thu, 2019-07-11 at 18:51 +0200, Jan Kiszka wrote:
[...]
> > 4.19/arm/hitachi_omap_defconfig
> > 4.19/arm/moxa_mxc_defconfig
> > 4.19/arm/siemens_am335x-axm2_defconfig
> > 4.19/arm/siemens_am335x-draco_defconfig
> > 4.19/arm/siemens_am335x-dxr2_defconfig
> > 4.19/arm/siemens_am335x-etamin_defconfig
> > 4.19/arm/siemens_am57xx-pxm3_defconfig
> 
> Those can go, I'm not aware of their usage on 4.19. But do we have one for the
> am335-x-based BBB, our reference board?

Good point.  I have not yet tried running 4.19 on the BBB, but I can
look at adding one - or perhaps Nobuhiro or Pavel already has a
suitable config?

> > 4.19/arm/toshiba_tegra_defconfig
> > 4.19/arm/toshiba_zynq_defconfig
> > 4.19/powerpc/toshiba_defconfig
> > 4.19/x86/plathome_obsvx1.config
> > 4.19/x86/siemens_i386-rt.config
> 
> I do not recall the history of that one anymore. We should have at least one -rt
> config for x86 somewhere.

Yes, and also the build rules should check out -rt branches instead of
the main CIP branches when processing an -rt configuration.

> > 4.19/x86/siemens_iot2000.config
> > 4.19/x86/siemens_server_defconfig
> 
> Those two should stay.

But they need to be reviewed, as automatic config updates usually don't
cope with renaming of config symbols.

Ben.

> > 4.19/x86/toshiba_defconfig
> > 
> > Ben.
> 
> Thanks,
> Jan
> 
-- 
Ben Hutchings, Software Developer                         Codethink Ltd
https://www.codethink.co.uk/                 Dale House, 35 Dale Street
                                     Manchester, M1 2HF, United Kingdom
