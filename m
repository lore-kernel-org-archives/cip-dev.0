From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Wed, 15 May 2019 14:05:52 +0000
Subject: [cip-dev] [PATCH 4.4.y 05/52] pinctrl: sh-pfc: Add r8a77470 PFC
 support
In-Reply-To: <20190515102802.GB3783@amd>
References: <1557761837-24993-1-git-send-email-fabrizio.castro@bp.renesas.com>
	<1557761837-24993-6-git-send-email-fabrizio.castro@bp.renesas.com>
	<20190513194418.GD27497@amd>
	<TY1PR01MB1770ABE4F290749ACFB03F1AC0080@TY1PR01MB1770.jpnprd01.prod.outlook.com>
	<20190515102802.GB3783@amd>
Message-ID: <TY1PR01MB17700DB614BE232BD6179523C0090@TY1PR01MB1770.jpnprd01.prod.outlook.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hello Pavel,

> From: Pavel Machek <pavel@denx.de>
> Sent: 15 May 2019 11:28
> Subject: Re: [cip-dev] [PATCH 4.4.y 05/52] pinctrl: sh-pfc: Add r8a77470 PFC support
> 
> Hi!
> 
> > Thank you for your feedback!
> 
> You are welcome.
> 
> > > Subject: Re: [cip-dev] [PATCH 4.4.y 05/52] pinctrl: sh-pfc: Add r8a77470 PFC support
> 
> ...
> > > > +++ b/drivers/pinctrl/sh-pfc/pfc-r8a77470.c
> > > > @@ -0,0 +1,2368 @@
> > > > +// SPDX-License-Identifier: GPL-2.0
> > > > +/*
> > > > + * R8A77470 processor support - PFC hardware block.
> > > > + *
> > >
> > > SPDX here, good. But this one is GPL-2.0, and the other one was
> > > GPL-2.0+. Is that difference intentional?
> >
> > What other SPDX header are you referring to?
> 
> I'm refering to
> 
> [PATCH 4.4.y 04/52] ARM: shmobile: r8a77470: Add clock index macros
>         for DT sources
> 
> That one has GPL-2.0+:

Thank you for looking into this.

I am not a license expert, but this one (and other similar files) probably need fixing.

I have used the same license as:
https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/tree/include/dt-bindings/clock/r8a7743-clock.h?h=linux-4.4.y-cip
https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/tree/include/dt-bindings/clock/r8a7745-clock.h?h=linux-4.4.y-cip

but now that you are pointing this out I am noticing that the driver comes with GPL-2.0 as well:
https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/tree/drivers/clk/shmobile/clk-rcar-gen2.c?h=linux-4.4.y-cip

and so are the device trees that include the definitions for the clocks:
https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/tree/arch/arm/boot/dts/r8a7743.dtsi?h=linux-4.4.y-cip
https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/tree/arch/arm/boot/dts/r8a7745.dtsi?h=linux-4.4.y-cip
https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/tree/arch/arm/boot/dts/r8a77470.dtsi?h=linux-4.4.y-cip

I think using GPL-2.0+ with:
https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/tree/include/dt-bindings/clock/r8a7743-clock.h?h=linux-4.4.y-cip
https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/tree/include/dt-bindings/clock/r8a7745-clock.h?h=linux-4.4.y-cip
https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/tree/include/dt-bindings/clock/r8a77470-clock.h?h=linux-4.4.y-cip
was the wrong call, what do you think?

Thanks,
Fab

> 
> +++ b/include/dt-bindings/clock/r8a77470-clock.h
> +/*
> + * Copyright (C) 2019 Renesas Electronics Corporation
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + */
> 
> Best regrads,
> 								Pavel
> --
> DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
