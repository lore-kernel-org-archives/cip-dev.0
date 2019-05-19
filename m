From: pavel@denx.de (Pavel Machek)
Date: Sun, 19 May 2019 22:22:16 +0200
Subject: [cip-dev] [PATCH 4.4.y 05/52] pinctrl: sh-pfc: Add r8a77470 PFC
 support
In-Reply-To: <TY1PR01MB17700DB614BE232BD6179523C0090@TY1PR01MB1770.jpnprd01.prod.outlook.com>
References: <1557761837-24993-1-git-send-email-fabrizio.castro@bp.renesas.com>
	<1557761837-24993-6-git-send-email-fabrizio.castro@bp.renesas.com>
	<20190513194418.GD27497@amd>
	<TY1PR01MB1770ABE4F290749ACFB03F1AC0080@TY1PR01MB1770.jpnprd01.prod.outlook.com>
	<20190515102802.GB3783@amd>
	<TY1PR01MB17700DB614BE232BD6179523C0090@TY1PR01MB1770.jpnprd01.prod.outlook.com>
Message-ID: <20190519202216.GA26654@amd>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi!

> > > > > +++ b/drivers/pinctrl/sh-pfc/pfc-r8a77470.c
> > > > > @@ -0,0 +1,2368 @@
> > > > > +// SPDX-License-Identifier: GPL-2.0
> > > > > +/*
> > > > > + * R8A77470 processor support - PFC hardware block.
> > > > > + *
> > > >
> > > > SPDX here, good. But this one is GPL-2.0, and the other one was
> > > > GPL-2.0+. Is that difference intentional?
> > >
> > > What other SPDX header are you referring to?
> > 
> > I'm refering to
> > 
> > [PATCH 4.4.y 04/52] ARM: shmobile: r8a77470: Add clock index macros
> >         for DT sources
> > 
> > That one has GPL-2.0+:
> 
> Thank you for looking into this.
> 
> I am not a license expert, but this one (and other similar files) probably need fixing.
> 

Well, there's no "need" to fix anything. GPL-2.0+ is compatible with
GPL-2.0. And kernel is not likely to be released with GPL-3, so this
is mostly academic.

Normally, company lawyers are quite sensitive about this. If your
lawyers are not, consider yourself lucky ;-).

> I think using GPL-2.0+ with:
> https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/tree/include/dt-bindings/clock/r8a7743-clock.h?h=linux-4.4.y-cip
> https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/tree/include/dt-bindings/clock/r8a7745-clock.h?h=linux-4.4.y-cip
> https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/tree/include/dt-bindings/clock/r8a77470-clock.h?h=linux-4.4.y-cip
> was the wrong call, what do you think?

It really depends on your company policies. I believe GPL-3 is better
license than GPL-2.0, so I normally prefer GPL-2.0+, but... that's my
personal preference... and as kernel is not going to move to GPL-3 it
is really not important. There's no right or wrong, it all depends on
your company policies/lawyers.

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
URL: <http://lists.cip-project.org/pipermail/cip-dev/attachments/20190519/e9f8ffc4/attachment.sig>
