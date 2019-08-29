From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Thu, 29 Aug 2019 11:04:36 +0000
Subject: [cip-dev] [PATCH/RFC 4.19.y-cip 00/41] Fast forward sh-pfc
In-Reply-To: <TYAPR01MB228547C1D35538FE0A074410B7A20@TYAPR01MB2285.jpnprd01.prod.outlook.com>
References: <1566991328-25476-1-git-send-email-fabrizio.castro@bp.renesas.com>
	<20190829081221.GD10041@amd>
	<TY1PR01MB1770129C698AAE461CFCE4FDC0A20@TY1PR01MB1770.jpnprd01.prod.outlook.com>
	<20190829094751.GB20258@amd>
	<TY1PR01MB1770F6AE638C3F42AF85A480C0A20@TY1PR01MB1770.jpnprd01.prod.outlook.com>
	<TYAPR01MB228547C1D35538FE0A074410B7A20@TYAPR01MB2285.jpnprd01.prod.outlook.com>
Message-ID: <TY1PR01MB1770BF5D1B46FF214219B97DC0A20@TY1PR01MB1770.jpnprd01.prod.outlook.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hello Chris,

Thank you for your feedback!

> From: Chris Paterson <Chris.Paterson2@renesas.com>
> Sent: 29 August 2019 11:23
> Subject: RE: [cip-dev] [PATCH/RFC 4.19.y-cip 00/41] Fast forward sh-pfc
> 
> Hello Pavel, Fab,
> 
> > From: cip-dev-bounces at lists.cip-project.org <cip-dev-bounces@lists.cip-
> > project.org> On Behalf Of Fabrizio Castro
> > Sent: 29 August 2019 10:50
> >
> > Hi Pavel,
> >
> > > From: Pavel Machek <pavel@denx.de>
> > > Sent: 29 August 2019 10:48
> > > Subject: Re: [cip-dev] [PATCH/RFC 4.19.y-cip 00/41] Fast forward sh-pfc
> > >
> > > Hi!
> > >
> > > > > > they have made good progress upstream with the development of
> > sh-pfc,
> > > > > > and although the functionality of the drivers hasn't changed much,
> > > > > > the code looks fairly different. This means that backporting patches
> > > > > > to SoC specific driver files will be increasingly hard and error
> > > > > > prone, unless we fast-forward the code base for 4.19.y-cip, hence
> > > > > > this series.
> > > > > > What do you gus think? Comments welcome!
> > > > >
> > > > > I reviewed the patches... and it is interesting how much magic can be
> > > > > done with preprocessor.
> > > >
> > > > I thought the same thing!
> > >
> > > > > I do not see anything preventing the merge, but they were marked
> > [rfc]
> > > > > so I'm not doing that yet. Let me know if I should.
> > > >
> > > > Since nothing nasty was spotted during code review and it works ok, I
> > believe
> > > > merging this series could really help us with future development, so yes
> > > > please, go ahead and merge.
> > >
> > > Ok, merged, and pushed out.
> 
> Our CI is hitting some build errors with the latest v4.19-cip (commit b11ac993) with the renesas shmobile_defconfig configurations:
> https://gitlab.com/cip-project/cip-kernel/linux-cip/-/jobs/283063646
> https://gitlab.com/cip-project/cip-kernel/linux-cip/-/jobs/283063654
> 
> In file included from ./include/linux/kernel.h:15,
>                  from ./include/asm-generic/bug.h:18,
>                  from ./arch/arm/include/asm/bug.h:60,
>                  from ./include/linux/bug.h:5,
>                  from ./include/linux/io.h:23,
>                  from drivers/pinctrl/sh-pfc/pfc-r8a7740.c:21:
> ./include/linux/build_bug.h:29:45: error: negative width in bit-field '<anonymous>'
>  #define BUILD_BUG_ON_ZERO(e) (sizeof(struct { int:(-!!(e)); }))
>                                              ^
> drivers/pinctrl/sh-pfc/sh_pfc.h:52:3: note: in expansion of macro 'BUILD_BUG_ON_ZERO'
>    BUILD_BUG_ON_ZERO(sizeof(n##_pins) != sizeof(n##_mux)), \
>    ^~~~~~~~~~~~~~~~~
> drivers/pinctrl/sh-pfc/sh_pfc.h:54:29: note: in expansion of macro 'SH_PFC_PIN_GROUP_ALIAS'
>  #define SH_PFC_PIN_GROUP(n) SH_PFC_PIN_GROUP_ALIAS(n, n)
>                              ^~~~~~~~~~~~~~~~~~~~~~
> drivers/pinctrl/sh-pfc/pfc-r8a7740.c:2806:2: note: in expansion of macro 'SH_PFC_PIN_GROUP'
>   SH_PFC_PIN_GROUP(gether_gmii),
>   ^~~~~~~~~~~~~~~~
> ./include/linux/build_bug.h:29:45: error: negative width in bit-field '<anonymous>'
>  #define BUILD_BUG_ON_ZERO(e) (sizeof(struct { int:(-!!(e)); }))
>                                              ^
> drivers/pinctrl/sh-pfc/sh_pfc.h:52:3: note: in expansion of macro 'BUILD_BUG_ON_ZERO'
>    BUILD_BUG_ON_ZERO(sizeof(n##_pins) != sizeof(n##_mux)), \
>    ^~~~~~~~~~~~~~~~~
> drivers/pinctrl/sh-pfc/sh_pfc.h:54:29: note: in expansion of macro 'SH_PFC_PIN_GROUP_ALIAS'
>  #define SH_PFC_PIN_GROUP(n) SH_PFC_PIN_GROUP_ALIAS(n, n)
>                              ^~~~~~~~~~~~~~~~~~~~~~
> drivers/pinctrl/sh-pfc/pfc-r8a7740.c:2868:2: note: in expansion of macro 'SH_PFC_PIN_GROUP'
>   SH_PFC_PIN_GROUP(lcd0_data24_1),
>   ^~~~~~~~~~~~~~~~
> make[3]: *** [drivers/pinctrl/sh-pfc/pfc-r8a7740.o] Error 1
> scripts/Makefile.build:303: recipe for target 'drivers/pinctrl/sh-pfc/pfc-r8a7740.o' failed
> make[2]: *** [drivers/pinctrl/sh-pfc] Error 2
> make[2]: *** Waiting for unfinished jobs....
> scripts/Makefile.build:544: recipe for target 'drivers/pinctrl/sh-pfc' failed
>   AR      drivers/pps/clients/built-in.a
>   AR      drivers/pps/generators/built-in.a
>   CC      drivers/pps/pps.o
>   CC      drivers/power/supply/power_supply_sysfs.o
>   CC      drivers/ptp/ptp_clock.o
> make[1]: *** [drivers/pinctrl] Error 2
> scripts/Makefile.build:544: recipe for target 'drivers/pinctrl' failed
> make[1]: *** Waiting for unfinished jobs....
>   CC      drivers/ptp/ptp_chardev.o
>   AR      drivers/power/supply/built-in.a
>   AR      drivers/power/built-in.a
>   CC      drivers/ptp/ptp_sysfs.o
>   CC      drivers/pps/kapi.o
>   CC      drivers/pps/sysfs.o
>   AR      drivers/ptp/built-in.a
>   AR      drivers/pps/built-in.a
> make: *** [drivers] Error 2
> Makefile:1046: recipe for target 'drivers' failed
> 
> 
> Complete pipeline is still running:
> https://gitlab.com/cip-project/cip-kernel/linux-cip/pipelines/79117946

Thank you for reporting this, and I am so glad we have CI in place to spot this things early on now.

I think the safest thing to do here is dropping this series after seeing the build log,
there is clearly more effort needed to keep arm32 and arm64 in check, and backporting
more patches to the sh-pfc driver would still be a pain.

Pavel, do you think you can drop this series?

Thanks,
Fab

> 
> 
> Kind regards, Chris
> 
> >
> > Thanks!
> >
> > Fab
> >
> > >
> > > Best regards,
> > > 								Pavel
> > > --
> > > DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
> > > HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
> > _______________________________________________
> > cip-dev mailing list
> > cip-dev at lists.cip-project.org
> > https://lists.cip-project.org/mailman/listinfo/cip-dev
