From: pavel@denx.de (Pavel Machek)
Date: Wed, 15 May 2019 12:28:02 +0200
Subject: [cip-dev] [PATCH 4.4.y 05/52] pinctrl: sh-pfc: Add r8a77470 PFC
 support
In-Reply-To: <TY1PR01MB1770ABE4F290749ACFB03F1AC0080@TY1PR01MB1770.jpnprd01.prod.outlook.com>
References: <1557761837-24993-1-git-send-email-fabrizio.castro@bp.renesas.com>
	<1557761837-24993-6-git-send-email-fabrizio.castro@bp.renesas.com>
	<20190513194418.GD27497@amd>
	<TY1PR01MB1770ABE4F290749ACFB03F1AC0080@TY1PR01MB1770.jpnprd01.prod.outlook.com>
Message-ID: <20190515102802.GB3783@amd>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi!

> Thank you for your feedback!

You are welcome.

> > Subject: Re: [cip-dev] [PATCH 4.4.y 05/52] pinctrl: sh-pfc: Add r8a77470 PFC support

...
> > > +++ b/drivers/pinctrl/sh-pfc/pfc-r8a77470.c
> > > @@ -0,0 +1,2368 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +/*
> > > + * R8A77470 processor support - PFC hardware block.
> > > + *
> > 
> > SPDX here, good. But this one is GPL-2.0, and the other one was
> > GPL-2.0+. Is that difference intentional?
> 
> What other SPDX header are you referring to?

I'm refering to

[PATCH 4.4.y 04/52] ARM: shmobile: r8a77470: Add clock index macros
        for DT sources

That one has GPL-2.0+:

+++ b/include/dt-bindings/clock/r8a77470-clock.h
+/*
+ * Copyright (C) 2019 Renesas Electronics Corporation
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */

Best regrads,
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
URL: <http://lists.cip-project.org/pipermail/cip-dev/attachments/20190515/27cd3ec1/attachment.sig>
