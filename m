From: biju.das@bp.renesas.com (Biju Das)
Date: Fri, 8 Nov 2019 12:54:20 +0000
Subject: [cip-dev] [PATCH 4.4.y-cip 26/83] mmc: tmio/sdhi: introduce
 flag for RCar 2+ specific features
In-Reply-To: <20191108092054.GD1017@amd>
References: <1573115572-13513-1-git-send-email-biju.das@bp.renesas.com>
	<1573115572-13513-27-git-send-email-biju.das@bp.renesas.com>
	<20191108092054.GD1017@amd>
Message-ID: <OSBPR01MB2103D1889B13EFACAE6BE7CEB87B0@OSBPR01MB2103.jpnprd01.prod.outlook.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi Pavel,
[>] 
> Subject: Re: [PATCH 4.4.y-cip 26/83] mmc: tmio/sdhi: introduce flag for RCar
> 2+ specific features
> 
> Hi!
> 
> > @@ -66,8 +66,8 @@
> >   */
> >  #define TMIO_MMC_SDIO_IRQ		(1 << 2)
> >
> > -/* Some controllers don't need to wait 10ms for clock changes */
> > -#define TMIO_MMC_FAST_CLK_CHG		(1 << 3)
> > +/* Some features are only available or tested on RCar Gen2 or later */
> > +#define TMIO_MMC_MIN_RCAR2		(1 << 3)
> >
> 
> I'd add a comment here that gen2 allows fast clock changes ... and whatever
> other features the driver is actually using.

Yes, I agree it should have done in the mainline first.

Regards,
Biju
