From: pavel@denx.de (Pavel Machek)
Date: Fri, 8 Nov 2019 10:28:24 +0100
Subject: [cip-dev] [PATCH 4.4.y-cip 36/83] mmc: sh_mobile_sdhi: add
	ocr_mask option
In-Reply-To: <1573115572-13513-37-git-send-email-biju.das@bp.renesas.com>
References: <1573115572-13513-1-git-send-email-biju.das@bp.renesas.com>
	<1573115572-13513-37-git-send-email-biju.das@bp.renesas.com>
Message-ID: <20191108092824.GG1017@amd>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi!

> commit f19417f38264f9a2f7b4627aa4060133c237b211 upstream.
> 
> In moving platforms from board files to DT, there still needs to be a way
> to set the ocr_mask setting for the tmio driver during probe. Without this
> setting, the probe will fail because the supported voltages are not known.
> 
> This patch will also traditional platform registration platforms to
> migrate to DT.

This is not quite english.

> +++ b/drivers/mmc/host/sh_mobile_sdhi.c
> @@ -49,6 +49,7 @@
>  
>  struct sh_mobile_sdhi_of_data {
>  	unsigned long tmio_flags;
> +	u32	      tmio_ocr_mask;
>  	unsigned long capabilities;
>  	unsigned long capabilities2;
>  	enum dma_slave_buswidth dma_buswidth;
> @@ -370,6 +371,7 @@ static int sh_mobile_sdhi_probe(struct platform_device *pdev)
>  		const struct sh_mobile_sdhi_of_data *of_data = of_id->data;
>  
>  		mmc_data->flags |= of_data->tmio_flags;
> +		mmc_data->ocr_mask = of_data->tmio_ocr_mask;
>  		mmc_data->capabilities |= of_data->capabilities;
>  		mmc_data->capabilities2 |= of_data->capabilities2;
>  		mmc_data->dma_rx_offset = of_data->dma_rx_offset;

And as of_data->tmio_ocr_mask is never written, I don't see how this
can fix the problem effect.

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
URL: <http://lists.cip-project.org/pipermail/cip-dev/attachments/20191108/d31f69fd/attachment.sig>
