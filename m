From: biju.das@bp.renesas.com (Biju Das)
Date: Fri, 8 Nov 2019 13:34:53 +0000
Subject: [cip-dev] [PATCH 4.4.y-cip 69/83] mmc: renesas-sdhi: make
 renesas_sdhi_sys_dmac main module file
In-Reply-To: <20191108095603.GN1017@amd>
References: <1573115572-13513-1-git-send-email-biju.das@bp.renesas.com>
	<1573115572-13513-70-git-send-email-biju.das@bp.renesas.com>
	<20191108095603.GN1017@amd>
Message-ID: <OSBPR01MB2103E6007BAE50BAF079E047B87B0@OSBPR01MB2103.jpnprd01.prod.outlook.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi Pavel,

> Subject: Re: [PATCH 4.4.y-cip 69/83] mmc: renesas-sdhi: make
> renesas_sdhi_sys_dmac main module file
> 
> On Thu 2019-11-07 08:32:38, Biju Das wrote:
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
> Patches 66 to 69 do a big rename while changing the code in question. That
> makes them hard / tricky to review. I should review that again, either now or
> in next version of the patch.

Yes I agree, it is little bit trickier. I am waiting for your comments.

Regards,
biju

> > -static int renesas_sdhi_probe(struct platform_device *pdev)
> > +int renesas_sdhi_probe(struct platform_device *pdev,
> > +		       const struct tmio_mmc_dma_ops *dma_ops)
> >  {
> > -	const struct renesas_sdhi_of_data *of_data =
> of_device_get_match_data(&pdev->dev);
> > +	const struct renesas_sdhi_of_data *of_data =
> > +of_device_get_match_data( &pdev->dev);
> >  	struct renesas_sdhi *priv;
> 
> Prototype changed here. The space was added in the wrong place.
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
> But this is worse: wait_for_completion is moving around, along with locking
> changes. Change is not documented and is not present in upstream version
> of the commit.
> 
> Best regards,
> 								Pavel
> --
> DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
