From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Thu, 29 Aug 2019 09:31:47 +0000
Subject: [cip-dev] [PATCH/RFC 4.19.y-cip 07/41] pinctrl: sh-pfc: Absorb
 enum IDs in PINMUX_CFG_REG() macro
In-Reply-To: <20190829080914.GC10041@amd>
References: <1566991328-25476-1-git-send-email-fabrizio.castro@bp.renesas.com>
	<1566991328-25476-8-git-send-email-fabrizio.castro@bp.renesas.com>
	<20190829080914.GC10041@amd>
Message-ID: <TY1PR01MB17709A28B3CC835C274D6E65C0A20@TY1PR01MB1770.jpnprd01.prod.outlook.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hello Pavel,

Thank you for your feedback!

> From: Pavel Machek <pavel@denx.de>
> Sent: 29 August 2019 09:09
> Subject: Re: [cip-dev] [PATCH/RFC 4.19.y-cip 07/41] pinctrl: sh-pfc: Absorb enum IDs in PINMUX_CFG_REG() macro
> 
> Hi!
> 
> > commit efca8da0c5fcc7f5617bab769faa595f7efdc593 upstream.
> >
> > Currently the PINMUX_CFG_REG() macro must be followed by initialization
> > data, specifying all enum IDs.  Hence the macro itself does not know
> > anything about the enum IDs, preventing the macro from performing any
> > validation on it.
> >
> > Make the macro accept the enum IDs as a parameter, and update all users.
> > Note that array data enclosed by curly braces cannot be passed to a
> > macro as a parameter, hence the enum IDs are wrapped using a new macro
> > GROUPS().
> 
> The macro is called "GROUP" and we already have macros with same name
> (but different functionality) in the tree.
> 
> One of the other uses is ./arch/sh/kernel/cpu/sh4a/setup-sh7734.c. Not
> sure if it is huge problem, but it might be a bit confusing...
> 
> ./drivers/pinctrl/sirf/pinctrl-atlas7.c:#define GROUP(n, p)  \
> ./drivers/pinctrl/meson/pinctrl-meson-axg-pmx.h:#define GROUP(grp, f)
> ./drivers/pinctrl/meson/pinctrl-meson8-pmx.h:#define GROUP(grp, r, b)
> ./drivers/input/rmi4/rmi_driver.h:#define GROUP(_attrs) { \
> ./arch/sh/kernel/cpu/sh4a/setup-sh7734.c:#define GROUP 0

To me it looks like all of those definitions are local to the corresponding
drivers, and so is the GROUP definition for the sh-pfc driver:
linux$ find . -iname "*.c" -exec grep -Hn "sh_pfc\.h" '{}' \;                                                     
./drivers/pinctrl/sh-pfc/pfc-r8a77970.c:20:#include "sh_pfc.h"
./drivers/pinctrl/sh-pfc/pfc-sh7203.c:12:#include "sh_pfc.h"
./drivers/pinctrl/sh-pfc/pfc-sh7264.c:12:#include "sh_pfc.h"
./drivers/pinctrl/sh-pfc/pfc-sh7785.c:12:#include "sh_pfc.h"
./drivers/pinctrl/sh-pfc/pfc-r8a7794.c:15:#include "sh_pfc.h"
./drivers/pinctrl/sh-pfc/pfc-sh7757.c:17:#include "sh_pfc.h"
./drivers/pinctrl/sh-pfc/pfc-r8a77995.c:18:#include "sh_pfc.h"
./drivers/pinctrl/sh-pfc/pfc-r8a77965.c:19:#include "sh_pfc.h"
./drivers/pinctrl/sh-pfc/pfc-r8a7795.c:13:#include "sh_pfc.h"
./drivers/pinctrl/sh-pfc/pfc-sh73a0.c:17:#include "sh_pfc.h"
./drivers/pinctrl/sh-pfc/pfc-r8a7740.c:12:#include "sh_pfc.h"
./drivers/pinctrl/sh-pfc/pfc-emev2.c:10:#include "sh_pfc.h"
./drivers/pinctrl/sh-pfc/pfc-r8a7790.c:17:#include "sh_pfc.h"
./drivers/pinctrl/sh-pfc/pfc-sh7269.c:13:#include "sh_pfc.h"
./drivers/pinctrl/sh-pfc/pfc-r8a7791.c:12:#include "sh_pfc.h"
./drivers/pinctrl/sh-pfc/pfc-r8a7796.c:18:#include "sh_pfc.h"
./drivers/pinctrl/sh-pfc/pfc-r8a77990.c:18:#include "sh_pfc.h"
./drivers/pinctrl/sh-pfc/pfc-sh7786.c:17:#include "sh_pfc.h"
./drivers/pinctrl/sh-pfc/pfc-r8a73a4.c:11:#include "sh_pfc.h"
./drivers/pinctrl/sh-pfc/pfc-shx3.c:11:#include "sh_pfc.h"
./drivers/pinctrl/sh-pfc/pfc-sh7734.c:12:#include "sh_pfc.h"
./drivers/pinctrl/sh-pfc/pfc-r8a77470.c:11:#include "sh_pfc.h"
./drivers/pinctrl/sh-pfc/pfc-r8a7778.c:20:#include "sh_pfc.h"
./drivers/pinctrl/sh-pfc/pfc-r8a77980.c:20:#include "sh_pfc.h"
./drivers/pinctrl/sh-pfc/pfc-r8a7795-es1.c:12:#include "sh_pfc.h"
./drivers/pinctrl/sh-pfc/pfc-sh7720.c:12:#include "sh_pfc.h"
./drivers/pinctrl/sh-pfc/pfc-sh7724.c:17:#include "sh_pfc.h"
./drivers/pinctrl/sh-pfc/pfc-sh7722.c:7:#include "sh_pfc.h"
./drivers/pinctrl/sh-pfc/pfc-sh7723.c:12:#include "sh_pfc.h"
./drivers/pinctrl/sh-pfc/pfc-r8a7779.c:12:#include "sh_pfc.h"
./drivers/pinctrl/sh-pfc/pfc-r8a7792.c:12:#include "sh_pfc.h"
linux$ find . -iname "*.h" -exec grep -Hn "sh_pfc\.h" '{}' \;                                                     
./drivers/pinctrl/sh-pfc/core.h:12:#include "sh_pfc.h"

I think this is ok for both upstream and 4.19.y-cip.

Thanks,
Fab

> 
> Best regards,
> 								Pavel
> 
> > +++ b/drivers/pinctrl/sh-pfc/sh_pfc.h
> > @@ -118,20 +118,24 @@ struct pinmux_cfg_reg {
> >  	const u8 *var_field_width;
> >  };
> >
> > +#define GROUP(...)	__VA_ARGS__
> > +
> 
> --
> DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
