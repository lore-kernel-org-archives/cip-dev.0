From: biju.das@bp.renesas.com (Biju Das)
Date: Tue, 26 Nov 2019 10:28:23 +0000
Subject: [cip-dev] [PATCH 4.4.y-cip 02/17] mmc: renesas-sdhi: rename
 tmio_mmc_dma.c => renesas_sdhi_sys_dmac.c
In-Reply-To: <20191122095312.GC30479@amd>
References: <1574341247-46652-1-git-send-email-biju.das@bp.renesas.com>
 <1574341247-46652-3-git-send-email-biju.das@bp.renesas.com>
 <20191122095312.GC30479@amd>
Message-ID: <OSBPR01MB2103C9E8A0AAF428DB21A1C6B8450@OSBPR01MB2103.jpnprd01.prod.outlook.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi Pavel,

Thanks for the feedback.

> Subject: Re: [PATCH 4.4.y-cip 02/17] mmc: renesas-sdhi: rename
> tmio_mmc_dma.c => renesas_sdhi_sys_dmac.c
> 
> Hi!
> 
> > commit c2a96987c76f093be50550130f5629723b091176 upstream.
> >
> > Rename the source file for DMA for SDHI as a follow-up to attaching
> > DMA code to the SDHI driver rather than the tmio_core driver.
> >
> > The name "renesas" is chosen as the SDHI driver is applicable to a
> > wider range of SoCs than SH-Mobile it seems to be a more appropriate
> name.
> > However, the SDHI driver source itself, is left as sh_mobile_sdhi to
> > avoid unnecessary churn.
> >
> > The name sys_dmac was chosen to reflect the type of DMA used.
> >
> > Internal symbols have also been renamed to reflect the filename change.
> >
> > A follow-up patch will re-organise the SDHI driver removing the need
> > for renesas_sdhi_get_dma_ops().
> 
> 
> >  drivers/mmc/host/Makefile                |   2 +-
> >  drivers/mmc/host/renesas_sdhi.h          |  18 ++
> >  drivers/mmc/host/renesas_sdhi_sys_dmac.c | 368
> +++++++++++++++++++++++++++++++
> >  drivers/mmc/host/sh_mobile_sdhi.c        |   3 +-
> >  drivers/mmc/host/tmio_mmc.h              |   9 -
> >  drivers/mmc/host/tmio_mmc_dma.c          | 365 ------------------------------
> 
> So there is rename, and function prefixes change accordingly.
> 
> The real change is that !IS_ENABLED(CONFIG_MMC_SDHI) fallback below
> disappeared. I don't how this is related to the rename.
> 
> Are you sure it will not cause compile problems in
> !IS_ENABLED(CONFIG_MMC_SDHI) case?

I am not seeing any compilation issues with disabling CONFIG_MMC_SDHI.

> 
> > diff --git a/drivers/mmc/host/renesas_sdhi.h
> > b/drivers/mmc/host/renesas_sdhi.h new file mode 100644 index
> > 0000000..f65d936c
> > --- /dev/null
> > +++ b/drivers/mmc/host/renesas_sdhi.h
> > @@ -0,0 +1,18 @@
> > +/*
> > + * Renesas Mobile SDHI
> > + *
> > + * Copyright (C) 2017 Horms Solutions Ltd., Simon Horman
> > + * Copyright (C) 2017 Renesas Electronics Corporation
> > + *
> > + * This program is free software; you can redistribute it and/or
> > +modify
> > + * it under the terms of the GNU General Public License version 2 as
> > + * published by the Free Software Foundation.
> > + */
> > +
> > +#ifndef RENESAS_SDHI_H
> > +#define RENESAS_SDHI_H
> > +
> > +#include "tmio_mmc.h"
> > +
> > +const struct tmio_mmc_dma_ops *renesas_sdhi_get_dma_ops(void);
> #endif
> > diff --git a/drivers/mmc/host/tmio_mmc.h
> b/drivers/mmc/host/tmio_mmc.h
> > index 86aa49f3..cd5b4f3 100644
> > --- a/drivers/mmc/host/tmio_mmc.h
> > +++ b/drivers/mmc/host/tmio_mmc.h
> > @@ -212,15 +212,6 @@ void tmio_mmc_enable_mmc_irqs(struct
> > tmio_mmc_host *host, u32 i);  void tmio_mmc_disable_mmc_irqs(struct
> > tmio_mmc_host *host, u32 i);  irqreturn_t tmio_mmc_irq(int irq, void
> > *devid);
> >
> > -#if IS_ENABLED(CONFIG_MMC_SDHI)
> > -const struct tmio_mmc_dma_ops *tmio_mmc_get_dma_ops(void); -
> #else
> > -static inline const struct tmio_mmc_dma_ops
> > *tmio_mmc_get_dma_ops(void) -{
> > -	return NULL;
> > -}
> > -#endif
> > -
> >  static inline char *tmio_mmc_kmap_atomic(struct scatterlist *sg,
> >  					 unsigned long *flags)
> >  {
> 
> --
> DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
