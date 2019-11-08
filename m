From: biju.das@bp.renesas.com (Biju Das)
Date: Fri, 8 Nov 2019 12:58:19 +0000
Subject: [cip-dev] [PATCH 4.4.y-cip 33/83] mmc: tmio: add eMMC support
In-Reply-To: <20191108092457.GF1017@amd>
References: <1573115572-13513-1-git-send-email-biju.das@bp.renesas.com>
	<1573115572-13513-34-git-send-email-biju.das@bp.renesas.com>
	<20191108092457.GF1017@amd>
Message-ID: <OSBPR01MB210300F18B4D0B99A15D4B33B87B0@OSBPR01MB2103.jpnprd01.prod.outlook.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi Pavel,

> Subject: Re: [PATCH 4.4.y-cip 33/83] mmc: tmio: add eMMC support
> 
> On Thu 2019-11-07 08:32:02, Biju Das wrote:
> > From: Wolfram Sang <wsa+renesas@sang-engineering.com>
> >
> > commit 0bc0b6e86524526c92a9409faea79d53db8e7e6e upstream.
> >
> > We need to add R1 without CRC support, refactor the bus width routine
> > a little and extend a quirk check. To support "non-removable;" we need
> > a workaround which will be hopefully removed when reworking PM soon.
> 
> > index addbc71..eafd92d 100644
> > --- a/drivers/mmc/host/tmio_mmc.h
> > +++ b/drivers/mmc/host/tmio_mmc.h
> > @@ -79,6 +79,9 @@
> >  #define	CLK_CTL_DIV_MASK	0xff
> >  #define	CLK_CTL_SCLKEN		BIT(8)
> >
> > +#define CARD_OPT_WIDTH8		BIT(13)
> > +#define CARD_OPT_WIDTH		BIT(15)
> 
> WIDTH_1 and WIDTH_8 would be better names, for consistency with rest of
> code. "WIDTH" without number is quite confusing.

I agree, it is little bit confusing. May be we should fixing this Mainline first and then backport to cip kernel.

Cheers,
Biju
 
> > +	/* Some hardware cannot perform 2 byte requests in 4/8 bit mode
> */
> > +	if (host->mmc->ios.bus_width == MMC_BUS_WIDTH_4 ||
> > +	    host->mmc->ios.bus_width == MMC_BUS_WIDTH_8) {
> 
> --
> DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
