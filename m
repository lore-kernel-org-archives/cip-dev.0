From: pavel@denx.de (Pavel Machek)
Date: Fri, 22 Nov 2019 12:03:21 +0100
Subject: [cip-dev] [PATCH 4.4.y-cip 04/17] mmc: renesas-sdhi: make
 renesas_sdhi_sys_dmac main module file
In-Reply-To: <1574341247-46652-5-git-send-email-biju.das@bp.renesas.com>
References: <1574341247-46652-1-git-send-email-biju.das@bp.renesas.com>
 <1574341247-46652-5-git-send-email-biju.das@bp.renesas.com>
Message-ID: <20191122110321.GF30479@amd>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi!

> From: Simon Horman <horms+renesas@verge.net.au>
> 
> commit 9d08428afb722fedaea699a32aaf603a8f1ebd5a upstream.
> 
> Make renesas_sdhi_sys_dmac.c a top-level module file that makes use of
> library code supplied by renesas_sdhi_core.c
> 
> This is in order to facilitate adding other variants of SDHI;
> in particular SDHI using different DMA controllers.

>  drivers/mmc/host/renesas_sdhi.h          |  23 +++++-
>  drivers/mmc/host/renesas_sdhi_core.c     | 128 ++-----------------------------
>  drivers/mmc/host/renesas_sdhi_sys_dmac.c | 109 +++++++++++++++++++++++++-

There is real code change hidden between the move. Is that intentional
/ is that okay thing to do? Unmapping DMA buffers before the DMA is
completed sounds strange.

Best regards,
									Pavel


> @@ -46,8 +119,6 @@ static void renesas_sdhi_sys_dmac_dma_callback(void *arg)
>  {
>  	struct tmio_mmc_host *host = arg;
>  
> -	wait_for_completion(&host->dma_dataend);
> -
>  	spin_lock_irq(&host->lock);
>  
>  	if (!host->data)
> @@ -62,6 +133,11 @@ static void renesas_sdhi_sys_dmac_dma_callback(void *arg)
>  			     host->sg_ptr, host->sg_len,
>  			     DMA_TO_DEVICE);
>  
> +	spin_unlock_irq(&host->lock);
> +
> +	wait_for_completion(&host->dma_dataend);
> +
> +	spin_lock_irq(&host->lock);
>  	tmio_mmc_do_data_irq(host);
>  out:
>  	spin_unlock_irq(&host->lock);



-- 
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: Digital signature
URL: <http://lists.cip-project.org/pipermail/cip-dev/attachments/20191122/4e057f3e/attachment.sig>
