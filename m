From: biju.das@bp.renesas.com (Biju Das)
Date: Fri, 8 Nov 2019 12:53:07 +0000
Subject: [cip-dev] [PATCH 4.4.y-cip 18/83] mmc: tmio: remove now
 unneeded seperate irq handlers
In-Reply-To: <20191108091849.GC1017@amd>
References: <1573115572-13513-1-git-send-email-biju.das@bp.renesas.com>
	<1573115572-13513-19-git-send-email-biju.das@bp.renesas.com>
	<20191108091849.GC1017@amd>
Message-ID: <OSBPR01MB21030FFE95E20FCA3B5C8C1AB87B0@OSBPR01MB2103.jpnprd01.prod.outlook.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi Pavel,

> Subject: Re: [PATCH 4.4.y-cip 18/83] mmc: tmio: remove now unneeded
> seperate irq handlers
> 
> Hi!
> 
> > We removed installation of separate handlers previously, so we can
> > also remove the separate handlers.
> 
> > -
> > -irqreturn_t tmio_mmc_sdio_irq(int irq, void *devid)
> > +static bool tmio_mmc_sdio_irq(int irq, void *devid)
> >  {
> >  	struct tmio_mmc_host *host = devid;
> >  	struct mmc_host *mmc = host->mmc;
> > @@ -720,7 +696,7 @@ irqreturn_t tmio_mmc_sdio_irq(int irq, void *devid)
> >  	unsigned int sdio_status;
> >
> >  	if (!(pdata->flags & TMIO_MMC_SDIO_IRQ))
> > -		return IRQ_NONE;
> > +		return false;
> >
> >  	status = sd_ctrl_read16(host, CTL_SDIO_STATUS);
> >  	ireg = status & TMIO_SDIO_MASK_ALL & ~host->sdcard_irq_mask;
> @@
> > -734,9 +710,8 @@ irqreturn_t tmio_mmc_sdio_irq(int irq, void *devid)
> >  	if (mmc->caps & MMC_CAP_SDIO_IRQ && ireg &
> TMIO_SDIO_STAT_IOIRQ)
> >  		mmc_signal_sdio_irq(mmc);
> >
> > -	return IRQ_RETVAL(ireg);
> > +	return ireg;
> >  }
> 
> I'm not a great fan of function conversion to boolean here. With irqreturn_t it
> is clear what the values area; it is more ambiguous with the bool.

> > @@ -751,7 +726,10 @@ irqreturn_t tmio_mmc_irq(int irq, void *devid)
> >  	if (__tmio_mmc_sdcard_irq(host, ireg, status))
> >  		return IRQ_HANDLED;
> >
> > -	return tmio_mmc_sdio_irq(irq, devid);
> > +	if (tmio_mmc_sdio_irq(irq, devid))
> > +		return IRQ_HANDLED;
> > +
> > +	return IRQ_NONE;
> >  }
> 
> And it is converted right back into irqreturn_t here, anyway...

Yes, it looks ok now.

Regards,
Biju
