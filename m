From: biju.das@bp.renesas.com (Biju Das)
Date: Fri, 8 Nov 2019 13:41:58 +0000
Subject: [cip-dev] [PATCH 4.4.y-cip 71/83] mmc: tmio,
 renesas-sdhi: add max_{segs, blk_count} to tmio_mmc_data
In-Reply-To: <20191108100349.GO1017@amd>
References: <1573115572-13513-1-git-send-email-biju.das@bp.renesas.com>
	<1573115572-13513-72-git-send-email-biju.das@bp.renesas.com>
	<20191108100349.GO1017@amd>
Message-ID: <OSBPR01MB21031E81E0B14CF37FF39715B87B0@OSBPR01MB2103.jpnprd01.prod.outlook.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi Pavel,

Thanks for the feedback.

> -----Original Message-----
> From: Pavel Machek <pavel@denx.de>
> Sent: Friday, November 8, 2019 10:04 AM
> To: Biju Das <biju.das@bp.renesas.com>
> Cc: cip-dev at lists.cip-project.org; Nobuhiro Iwamatsu
> <nobuhiro1.iwamatsu@toshiba.co.jp>; Pavel Machek <pavel@denx.de>;
> Chris Paterson <Chris.Paterson2@renesas.com>; Fabrizio Castro
> <fabrizio.castro@bp.renesas.com>
> Subject: Re: [PATCH 4.4.y-cip 71/83] mmc: tmio, renesas-sdhi: add
> max_{segs, blk_count} to tmio_mmc_data
> 
> Hi!
> 
> > commit 603aa14d3daaa7073bab4c472025c4963030e0cc upstream.
> >
> > Allow TMIO and SDHI driver implementations to provide values for
> > max_segs and max_blk_count.
> >
> > A follow-up patch will set these values for Renesas Gen3 SoCs the
> > using an SDHI driver.
> >
> > Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> 
> > +++ b/drivers/mmc/host/tmio_mmc_core.c
> > @@ -1224,10 +1224,10 @@ int tmio_mmc_host_probe(struct
> tmio_mmc_host
> > *_host,
> >
> >  	mmc->caps |= MMC_CAP_4_BIT_DATA | pdata->capabilities;
> >  	mmc->caps2 |= pdata->capabilities2;
> > -	mmc->max_segs = 32;
> > +	mmc->max_segs = pdata->max_segs ? : 32;
> >  	mmc->max_blk_size = 512;
> > -	mmc->max_blk_count = (PAGE_CACHE_SIZE / mmc->max_blk_size)
> *
> > -		mmc->max_segs;
> > +	mmc->max_blk_count = pdata->max_blk_count ? :
> > +		(PAGE_SIZE / mmc->max_blk_size) * mmc->max_segs;
> >  	mmc->max_req_size = mmc->max_blk_size * mmc-
> >max_blk_count;
> >  	mmc->max_seg_size = mmc->max_req_size;
> 
> This also changes PAGE_CACHE_SIZE -> PAGE_SIZE. I guess that's
> okay/bugfix, as PAGE_CACHE_SIZE probably is equal to PAGE_SIZE in all
> relevant configurations, but...

It is a big change from PAGE_CACHE_SIZE -> PAGE_SIZE at start of kernel tree Please see the commit (09cbfea  " mm, fs: get rid of PAGE_CACHE_* and page_cache_{get,release} macros")

Regards,
Biju
