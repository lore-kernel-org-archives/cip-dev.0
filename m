From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Tue, 14 May 2019 09:23:53 +0000
Subject: [cip-dev] [PATCH 4.4.y 05/52] pinctrl: sh-pfc: Add r8a77470 PFC
 support
In-Reply-To: <20190513194418.GD27497@amd>
References: <1557761837-24993-1-git-send-email-fabrizio.castro@bp.renesas.com>
	<1557761837-24993-6-git-send-email-fabrizio.castro@bp.renesas.com>
	<20190513194418.GD27497@amd>
Message-ID: <TY1PR01MB1770ABE4F290749ACFB03F1AC0080@TY1PR01MB1770.jpnprd01.prod.outlook.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi Pavel,

Thank you for your feedback!

> From: Pavel Machek <pavel@denx.de>
> Sent: 13 May 2019 20:44
> Subject: Re: [cip-dev] [PATCH 4.4.y 05/52] pinctrl: sh-pfc: Add r8a77470 PFC support
> 
> Hi!
> 
> > From: Biju Das <biju.das@bp.renesas.com>
> >
> > commit 73dacc3403436fc246258c0933e35b6e809640ac upstream.
> >
> > Add PFC support for the R8A77470 SoC including pin groups for
> > some on-chip devices such as SCIF and MMC.
> >
> > Signed-off-by: Biju Das <biju.das@bp.renesas.com>
> > Reviewed-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> > (fab: moved r8a77470_pinmux_info declaration from sh_pfc.h to core.h,
> > in pfc-r8a77470.c: added #include "core.h", removed #include "sh_pfc.h",
> > and added a few missing macro definitions)
> > Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> 
> > new file mode 100644
> > index 0000000..8973f61
> > --- /dev/null
> > +++ b/drivers/pinctrl/sh-pfc/pfc-r8a77470.c
> > @@ -0,0 +1,2368 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * R8A77470 processor support - PFC hardware block.
> > + *
> 
> SPDX here, good. But this one is GPL-2.0, and the other one was
> GPL-2.0+. Is that difference intentional?

What other SPDX header are you referring to?

Thanks,
Fab

> 								Pavel
> --
> (english) http://www.livejournal.com/~pavelmachek
> (cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
