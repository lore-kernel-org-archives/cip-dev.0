From: biju.das@bp.renesas.com (Biju Das)
Date: Fri, 8 Nov 2019 12:56:44 +0000
Subject: [cip-dev] [PATCH 4.4.y-cip 31/83] mmc: host: sh_mobile_sdhi:
 move card_busy from tmio to sdhi
In-Reply-To: <20191108092251.GE1017@amd>
References: <1573115572-13513-1-git-send-email-biju.das@bp.renesas.com>
	<1573115572-13513-32-git-send-email-biju.das@bp.renesas.com>
	<20191108092251.GE1017@amd>
Message-ID: <OSBPR01MB2103E1A343A0226718FBB127B87B0@OSBPR01MB2103.jpnprd01.prod.outlook.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi Pavel,

> Subject: Re: [PATCH 4.4.y-cip 31/83] mmc: host: sh_mobile_sdhi: move
> card_busy from tmio to sdhi
> 
> On Thu 2019-11-07 08:32:00, Biju Das wrote:
> > From: Wolfram Sang <wsa+renesas@sang-engineering.com>
> >
> > commit 6a4679f312357ac7c74c0e1b996efdd1d0a612fa upstream.
> >
> > card_busy is only used/tested on SDHI for R-Car Gen2 and later.
> > Move it to the SDHI driver, so we can then activate it conditionally
> > depending on the SDHI type.
> 
> 
> > @@ -217,6 +217,13 @@ static void sh_mobile_sdhi_clk_disable(struct
> tmio_mmc_host *host)
> >  	clk_disable_unprepare(priv->clk);
> >  }
> >
> > +static int sh_mobile_sdhi_card_busy(struct mmc_host *mmc) {
> > +	struct tmio_mmc_host *host = mmc_priv(mmc);
> > +
> > +	return !(sd_ctrl_read16_and_16_as_32(host, CTL_STATUS) &
> > +TMIO_STAT_DAT0); }
> > +
> 
> Bool would make sense here, if the change is practical without changing too
> many interfaces... (and unless interface is something like 0/1/-ERRNO...)
> 

Yes I agree with you. Last statement is clearly returns a Boolean value.

Regards,
Biju
