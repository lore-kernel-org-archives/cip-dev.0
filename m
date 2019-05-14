From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Tue, 14 May 2019 09:50:25 +0000
Subject: [cip-dev] [PATCH 4.4.y 04/52] ARM: shmobile: r8a77470: Add
 clock index macros for DT sources
In-Reply-To: <20190513235655.gox3dyrjqluncmm4@toshiba.co.jp>
References: <1557761837-24993-1-git-send-email-fabrizio.castro@bp.renesas.com>
	<1557761837-24993-5-git-send-email-fabrizio.castro@bp.renesas.com>
	<20190513190322.GB27497@amd>
	<20190513235655.gox3dyrjqluncmm4@toshiba.co.jp>
Message-ID: <TY1PR01MB177056585BD4A61E1EF51197C0080@TY1PR01MB1770.jpnprd01.prod.outlook.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hello Nobuhiro-san, hello Pavel,

> -----Original Message-----
> From: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
> Sent: 14 May 2019 00:57
> To: Pavel Machek <pavel@denx.de>
> Cc: Fabrizio Castro <fabrizio.castro@bp.renesas.com>; cip-dev at lists.cip-project.org; Biju Das <biju.das@bp.renesas.com>
> Subject: Re: [cip-dev] [PATCH 4.4.y 04/52] ARM: shmobile: r8a77470: Add clock index macros for DT sources
> 
> Hi,
> 
> On Mon, May 13, 2019 at 09:03:22PM +0200, Pavel Machek wrote:
> > On Mon 2019-05-13 16:36:29, Fabrizio Castro wrote:
> > > Add macros usable by device tree sources to reference the r8a77470
> > > clocks by index.
> >
> > Is this commit in the mainline? I could not find it in recent mainline
> > nor in -next kernel.
> >
> > > diff --git a/include/dt-bindings/clock/r8a77470-clock.h b/include/dt-bindings/clock/r8a77470-clock.h
> > > new file mode 100644
> > > index 0000000..2f20bcc
> > > --- /dev/null
> > > +++ b/include/dt-bindings/clock/r8a77470-clock.h
> > > @@ -0,0 +1,140 @@
> > > +/*
> > > + * Copyright (C) 2019 Renesas Electronics Corporation
> > > + *
> > > + * This program is free software; you can redistribute it and/or modify
> > > + * it under the terms of the GNU General Public License as published by
> > > + * the Free Software Foundation; either version 2 of the License, or
> > > + * (at your option) any later version.
> > > + */
> >
> > World is moving to SPDX. (But you want to fix it in the mainline, not
> > here, so...)

I can confirm this file is not coming from mainline, it's brand you, would you like
me to send a patch for this?

> >
> 
> CIP has _Upstream first_ policy. So we can not apply this patch.
> Fabrizio, if you can not backport, please include the reason in the commit log.

For some things backporting is not possible, especially for the clocks as the driver
architecture has changed so much over time that the code in mainline is not
applicable in here. We have found ourselves at crossroads in the past because of
this, and after discussing this with Ben (who is now reading us in copy) we all
agreed it made sense to add new commits to compensate for differences between
mainline and the CIP version we need to backport the patches to.

In particular, this patch comes from the same context as the below patches:
* bdc09aa64336 ("ARM: shmobile: r8a7745: Add clock index macros for DT sources")
* 9683f2eba952 ("ARM: shmobile: r8a7743: Add clock index macros for DT sources")
And therefore the commit messages are all very similar.

Could you please suggest a format for new commits you would be comfortable with
so that we know what to do?

Thanks,
Fab

> 
> Best regards,
>   Nobuhiro
