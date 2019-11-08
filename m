From: pavel@denx.de (Pavel Machek)
Date: Fri, 8 Nov 2019 11:03:49 +0100
Subject: [cip-dev] [PATCH 4.4.y-cip 71/83] mmc: tmio,
 renesas-sdhi: add max_{segs, blk_count} to tmio_mmc_data
In-Reply-To: <1573115572-13513-72-git-send-email-biju.das@bp.renesas.com>
References: <1573115572-13513-1-git-send-email-biju.das@bp.renesas.com>
	<1573115572-13513-72-git-send-email-biju.das@bp.renesas.com>
Message-ID: <20191108100349.GO1017@amd>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi!

> commit 603aa14d3daaa7073bab4c472025c4963030e0cc upstream.
> 
> Allow TMIO and SDHI driver implementations to provide values for
> max_segs and max_blk_count.
> 
> A follow-up patch will set these values for Renesas Gen3 SoCs
> the using an SDHI driver.
> 
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

> +++ b/drivers/mmc/host/tmio_mmc_core.c
> @@ -1224,10 +1224,10 @@ int tmio_mmc_host_probe(struct tmio_mmc_host *_host,
>  
>  	mmc->caps |= MMC_CAP_4_BIT_DATA | pdata->capabilities;
>  	mmc->caps2 |= pdata->capabilities2;
> -	mmc->max_segs = 32;
> +	mmc->max_segs = pdata->max_segs ? : 32;
>  	mmc->max_blk_size = 512;
> -	mmc->max_blk_count = (PAGE_CACHE_SIZE / mmc->max_blk_size) *
> -		mmc->max_segs;
> +	mmc->max_blk_count = pdata->max_blk_count ? :
> +		(PAGE_SIZE / mmc->max_blk_size) * mmc->max_segs;
>  	mmc->max_req_size = mmc->max_blk_size * mmc->max_blk_count;
>  	mmc->max_seg_size = mmc->max_req_size;

This also changes PAGE_CACHE_SIZE -> PAGE_SIZE. I guess that's
okay/bugfix, as PAGE_CACHE_SIZE probably is equal to PAGE_SIZE in all
relevant configurations, but...

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
URL: <http://lists.cip-project.org/pipermail/cip-dev/attachments/20191108/c2a3f7fc/attachment.sig>
