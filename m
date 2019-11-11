From: biju.das@bp.renesas.com (Biju Das)
Date: Mon, 11 Nov 2019 13:52:03 +0000
Subject: [cip-dev] [PATCH 4.4.y-cip 66/83] mmc: tmio: rename
 tmio_mmc_{pio => core}.c
In-Reply-To: <20191108200237.GB23750@amd>
References: <1573115572-13513-1-git-send-email-biju.das@bp.renesas.com>
	<1573115572-13513-67-git-send-email-biju.das@bp.renesas.com>
	<20191108094752.GM1017@amd>
	<OSBPR01MB2103AE0B3CB3C1538ACCB534B87B0@OSBPR01MB2103.jpnprd01.prod.outlook.com>
	<20191108200237.GB23750@amd>
Message-ID: <OSBPR01MB21039FC0AD3BEFE8549FCEC6B8740@OSBPR01MB2103.jpnprd01.prod.outlook.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi Pavel,


> Subject: Re: [PATCH 4.4.y-cip 66/83] mmc: tmio: rename tmio_mmc_{pio =>
> core}.c
> 
> Hi!
> 
> > > > commit 426e95d1766bad20e59f219af64fdd50c39bcfee upstream.
> > > >
> > > > Rename tmio_mmc_pio.c to tmio_mmc_core.c to more accurately
> > > > reflect its
> > > > function: to provide core code for the tmio-mmc and sh-mobole-sdhi
> > > drivers.
> > > >
> > > > Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> > > > Acked-by: Arnd Bergmann <arnd@arndb.de>
> > > > Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> > > > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> > > > Signed-off-by: Biju Das <biju.das@bp.renesas.com>
> > > > ---
> > > >  drivers/mmc/host/Makefile        |    1 -
> > > >  drivers/mmc/host/tmio_mmc_core.c | 1394
> > > > ++++++++++++++++++++++++++++++++++++++
> > > >  drivers/mmc/host/tmio_mmc_pio.c  | 1394
> > > > --------------------------------------
> > >
> > > This patch creates tmio_mmc_core.c ...
> >
> > yes, if you see the subec mmc: tmio: rename tmio_mmc_{pio => core}.c
> >
> > Is it anything wrong? Am I missing something here?
> 
> There were more comments in my email, see below.
> 
> But reading them again, I see I was wrong. Makefile magic was used to turn
> tmio_mmc_pio.c into tmio_mmc_core.o, so there's no bug here.
> 
> Sorry for the noise.

OK.

Cheers,
Biju

> > > > +++ b/drivers/mmc/host/Makefile
> > > > @@ -36,7 +36,6 @@ obj-$(CONFIG_MMC_S3C)   	+= s3cmci.o
> > > >  obj-$(CONFIG_MMC_SDRICOH_CS)	+= sdricoh_cs.o
> > > >  obj-$(CONFIG_MMC_TMIO)		+= tmio_mmc.o
> > > >  obj-$(CONFIG_MMC_TMIO_CORE)	+= tmio_mmc_core.o
> > > > -tmio_mmc_core-y			:= tmio_mmc_pio.o
> > > >  obj-$(CONFIG_MMC_SDHI)		+= sh_mobile_sdhi.o
> > > tmio_mmc_dma.o
> > > >  obj-$(CONFIG_MMC_CB710)		+= cb710-mmc.o
> > > >  obj-$(CONFIG_MMC_VIA_SDMMC)	+= via-sdmmc.o
> > >
> > > ... which is already present in the Makefile before the patch. That
> > > can't be right.
> 
> --
> DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
