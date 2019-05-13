From: nobuhiro1.iwamatsu@toshiba.co.jp (Nobuhiro Iwamatsu)
Date: Tue, 14 May 2019 08:56:55 +0900
Subject: [cip-dev] [PATCH 4.4.y 04/52] ARM: shmobile: r8a77470: Add
 clock index macros for DT sources
In-Reply-To: <20190513190322.GB27497@amd>
References: <1557761837-24993-1-git-send-email-fabrizio.castro@bp.renesas.com>
	<1557761837-24993-5-git-send-email-fabrizio.castro@bp.renesas.com>
	<20190513190322.GB27497@amd>
Message-ID: <20190513235655.gox3dyrjqluncmm4@toshiba.co.jp>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi,

On Mon, May 13, 2019 at 09:03:22PM +0200, Pavel Machek wrote:
> On Mon 2019-05-13 16:36:29, Fabrizio Castro wrote:
> > Add macros usable by device tree sources to reference the r8a77470
> > clocks by index.
> 
> Is this commit in the mainline? I could not find it in recent mainline
> nor in -next kernel.
> 
> > diff --git a/include/dt-bindings/clock/r8a77470-clock.h b/include/dt-bindings/clock/r8a77470-clock.h
> > new file mode 100644
> > index 0000000..2f20bcc
> > --- /dev/null
> > +++ b/include/dt-bindings/clock/r8a77470-clock.h
> > @@ -0,0 +1,140 @@
> > +/*
> > + * Copyright (C) 2019 Renesas Electronics Corporation
> > + *
> > + * This program is free software; you can redistribute it and/or modify
> > + * it under the terms of the GNU General Public License as published by
> > + * the Free Software Foundation; either version 2 of the License, or
> > + * (at your option) any later version.
> > + */
> 
> World is moving to SPDX. (But you want to fix it in the mainline, not
> here, so...)
> 

CIP has _Upstream first_ policy. So we can not apply this patch.
Fabrizio, if you can not backport, please include the reason in the commit log.

Best regards,
  Nobuhiro
