From: pavel@denx.de (Pavel Machek)
Date: Thu, 29 Aug 2019 22:04:29 +0200
Subject: [cip-dev] [PATCH/RFC 4.19.y-cip 00/41] Fast forward sh-pfc
In-Reply-To: <af4fbd68b11573481451a6436030a46775211e4e.camel@codethink.co.uk>
References: <1566991328-25476-1-git-send-email-fabrizio.castro@bp.renesas.com>
	<20190829081221.GD10041@amd>
	<TY1PR01MB1770129C698AAE461CFCE4FDC0A20@TY1PR01MB1770.jpnprd01.prod.outlook.com>
	<20190829094751.GB20258@amd>
	<TY1PR01MB1770F6AE638C3F42AF85A480C0A20@TY1PR01MB1770.jpnprd01.prod.outlook.com>
	<TYAPR01MB228547C1D35538FE0A074410B7A20@TYAPR01MB2285.jpnprd01.prod.outlook.com>
	<TY1PR01MB1770BF5D1B46FF214219B97DC0A20@TY1PR01MB1770.jpnprd01.prod.outlook.com>
	<af4fbd68b11573481451a6436030a46775211e4e.camel@codethink.co.uk>
Message-ID: <20190829200429.GA17059@amd>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi!

> > > > > > Since nothing nasty was spotted during code review and it works ok, I
> > > > believe
> > > > > > merging this series could really help us with future development, so yes
> > > > > > please, go ahead and merge.
> > > > > 
> > > > > Ok, merged, and pushed out.
> > > 
> > > Our CI is hitting some build errors with the latest v4.19-cip (commit b11ac993) with the renesas shmobile_defconfig configurations:
> > > https://gitlab.com/cip-project/cip-kernel/linux-cip/-/jobs/283063646
> > > https://gitlab.com/cip-project/cip-kernel/linux-cip/-/jobs/283063654
> > > 
> > > In file included from ./include/linux/kernel.h:15,
> > >                  from ./include/asm-generic/bug.h:18,
> > >                  from ./arch/arm/include/asm/bug.h:60,
> > >                  from ./include/linux/bug.h:5,
> > >                  from ./include/linux/io.h:23,
> > >                  from drivers/pinctrl/sh-pfc/pfc-r8a7740.c:21:
> > > ./include/linux/build_bug.h:29:45: error: negative width in bit-field '<anonymous>'
> > >  #define BUILD_BUG_ON_ZERO(e) (sizeof(struct { int:(-!!(e)); }))
> > >                                              ^
> > > drivers/pinctrl/sh-pfc/sh_pfc.h:52:3: note: in expansion of macro 'BUILD_BUG_ON_ZERO'
> > >    BUILD_BUG_ON_ZERO(sizeof(n##_pins) != sizeof(n##_mux)), \
> > >    ^~~~~~~~~~~~~~~~~
> > > drivers/pinctrl/sh-pfc/sh_pfc.h:54:29: note: in expansion of macro 'SH_PFC_PIN_GROUP_ALIAS'
> > >  #define SH_PFC_PIN_GROUP(n) SH_PFC_PIN_GROUP_ALIAS(n, n)
> > >                              ^~~~~~~~~~~~~~~~~~~~~~
> > > drivers/pinctrl/sh-pfc/pfc-r8a7740.c:2806:2: note: in expansion of macro 'SH_PFC_PIN_GROUP'
> > >   SH_PFC_PIN_GROUP(gether_gmii),
> > >   ^~~~~~~~~~~~~~~~
> [...]
> > Thank you for reporting this, and I am so glad we have CI in place to spot this things early on now.
> > 
> > I think the safest thing to do here is dropping this series after seeing the build log,
> > there is clearly more effort needed to keep arm32 and arm64 in check, and backporting
> > more patches to the sh-pfc driver would still be a pain.
> > 
> > Pavel, do you think you can drop this series?
> 
> The failing assertions were added by "pinctrl: sh-pfc: Validate
> pins/marks in pin groups at build time".  We could revert that one
> patch, but it seems to be detecting actual bugs in r8a7740.c, so I
> think we should take the fixes for those:
> 
> commit 1ebc589a7786f17f97b9e87b44e0fb4d0290d8f8
> Author: Geert Uytterhoeven <geert+renesas@glider.be>
> Date:   Wed Dec 12 10:57:27 2018 +0100
> 
>     pinctrl: sh-pfc: r8a7740: Add missing REF125CK pin to gether_gmii group
> 
> commit 96bb2a6ab4eca10e5b6490b3f0738e9f7ec22c2b
> Author: Geert Uytterhoeven <geert+renesas@glider.be>
> Date:   Wed Dec 12 11:00:27 2018 +0100
> 
>     pinctrl: sh-pfc: r8a7740: Add missing LCD0 marks to lcd0_data24_1 group

I'd rather apply these two patches than revert the series. If they are
in the new series, I can pick them easily... and we should have the
tree building again.

Ok... I tried that. I pushed the tree now, and will take a look at the
lava.

Best regards,
								Pavel
-- 
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: Digital signature
URL: <http://lists.cip-project.org/pipermail/cip-dev/attachments/20190829/2d1452d4/attachment.sig>
