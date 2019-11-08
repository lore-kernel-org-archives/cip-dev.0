From: pavel@denx.de (Pavel Machek)
Date: Fri, 8 Nov 2019 10:56:03 +0100
Subject: [cip-dev] [PATCH 4.4.y-cip 69/83] mmc: renesas-sdhi: make
 renesas_sdhi_sys_dmac main module file
In-Reply-To: <1573115572-13513-70-git-send-email-biju.das@bp.renesas.com>
References: <1573115572-13513-1-git-send-email-biju.das@bp.renesas.com>
	<1573115572-13513-70-git-send-email-biju.das@bp.renesas.com>
Message-ID: <20191108095603.GN1017@amd>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

On Thu 2019-11-07 08:32:38, Biju Das wrote:
> From: Simon Horman <horms+renesas@verge.net.au>
> 
> commit 9d08428afb722fedaea699a32aaf603a8f1ebd5a upstream.
> 
> Make renesas_sdhi_sys_dmac.c a top-level module file that makes use of
> library code supplied by renesas_sdhi_core.c
> 
> This is in order to facilitate adding other variants of SDHI;
> in particular SDHI using different DMA controllers.

Patches 66 to 69 do a big rename while changing the code in
question. That makes them hard / tricky to review. I should review
that again, either now or in next version of the patch.

> -static int renesas_sdhi_probe(struct platform_device *pdev)
> +int renesas_sdhi_probe(struct platform_device *pdev,
> +		       const struct tmio_mmc_dma_ops *dma_ops)
>  {
> -	const struct renesas_sdhi_of_data *of_data = of_device_get_match_data(&pdev->dev);
> +	const struct renesas_sdhi_of_data *of_data = of_device_get_match_data( &pdev->dev);
>  	struct renesas_sdhi *priv;

Prototype changed here. The space was added in the wrong place.

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

But this is worse: wait_for_completion is moving around, along with
locking changes. Change is not documented and is not present in
upstream version of the commit.

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
URL: <http://lists.cip-project.org/pipermail/cip-dev/attachments/20191108/e11a1348/attachment-0001.sig>
