From: biju.das@bp.renesas.com (Biju Das)
Date: Tue, 26 Nov 2019 12:10:09 +0000
Subject: [cip-dev] [PATCH 4.4.y-cip 04/17] mmc: renesas-sdhi: make
 renesas_sdhi_sys_dmac main module file
In-Reply-To: <20191122110321.GF30479@amd>
References: <1574341247-46652-1-git-send-email-biju.das@bp.renesas.com>
 <1574341247-46652-5-git-send-email-biju.das@bp.renesas.com>
 <20191122110321.GF30479@amd>
Message-ID: <OSBPR01MB2103BFB10F91429B778AEAC9B8450@OSBPR01MB2103.jpnprd01.prod.outlook.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi Pavel,

Thanks for the feedback.

> Subject: Re: [PATCH 4.4.y-cip 04/17] mmc: renesas-sdhi: make
> renesas_sdhi_sys_dmac main module file
> 
> Hi!
> 
> > From: Simon Horman <horms+renesas@verge.net.au>
> >
> > commit 9d08428afb722fedaea699a32aaf603a8f1ebd5a upstream.
> >
> > Make renesas_sdhi_sys_dmac.c a top-level module file that makes use of
> > library code supplied by renesas_sdhi_core.c
> >
> > This is in order to facilitate adding other variants of SDHI; in
> > particular SDHI using different DMA controllers.
> 
> >  drivers/mmc/host/renesas_sdhi.h          |  23 +++++-
> >  drivers/mmc/host/renesas_sdhi_core.c     | 128 ++-----------------------------
> >  drivers/mmc/host/renesas_sdhi_sys_dmac.c | 109
> > +++++++++++++++++++++++++-
> 
> There is real code change hidden between the move. Is that intentional / is
> that okay thing to do? Unmapping DMA buffers before the DMA is
> completed sounds strange.
> 

Looks like to avoid confusion, We need to backport this patch before the renaming.

5f07ef8f603ace496ca8c20eef446c5ae7a10474 (mmc: tmio: always unmap DMA before waiting for interrupt)

What do you think?

Regards,
Biju


> 
> 
> > @@ -46,8 +119,6 @@ static void
> renesas_sdhi_sys_dmac_dma_callback(void
> > *arg)  {
> >  	struct tmio_mmc_host *host = arg;
> >
> > -	wait_for_completion(&host->dma_dataend);
> > -
> >  	spin_lock_irq(&host->lock);
> >
> >  	if (!host->data)
> > @@ -62,6 +133,11 @@ static void
> renesas_sdhi_sys_dmac_dma_callback(void *arg)
> >  			     host->sg_ptr, host->sg_len,
> >  			     DMA_TO_DEVICE);
> >
> > +	spin_unlock_irq(&host->lock);
> > +
> > +	wait_for_completion(&host->dma_dataend);
> > +
> > +	spin_lock_irq(&host->lock);
> >  	tmio_mmc_do_data_irq(host);
> >  out:
> >  	spin_unlock_irq(&host->lock);
> 
> 
> 
> --
> DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
