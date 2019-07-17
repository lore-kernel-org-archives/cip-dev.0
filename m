From: biju.das@bp.renesas.com (Biju Das)
Date: Wed, 17 Jul 2019 06:46:15 +0000
Subject: [cip-dev] [PATCH 4.19.y-cip 4/6] rtc: rx8581: Add support for
 Epson rx8571 RTC
In-Reply-To: <20190716202212.GB9557@amd>
References: <1563200245-30331-1-git-send-email-biju.das@bp.renesas.com>
	<1563200245-30331-5-git-send-email-biju.das@bp.renesas.com>
	<20190716202212.GB9557@amd>
Message-ID: <OSBPR01MB2103875841FF3739EE002080B8C90@OSBPR01MB2103.jpnprd01.prod.outlook.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi Pavel,

Thanks for the feedback.

> Subject: Re: [cip-dev] [PATCH 4.19.y-cip 4/6] rtc: rx8581: Add support for
> Epson rx8571 RTC
> 
> Hi!
> 
> > +static int rx85x1_nvram_read(void *priv, unsigned int offset, void *val,
> > +			     size_t bytes)
> > +{
> > +	struct rx8581 *rx8581 = priv;
> > +	unsigned int tmp_val;
> > +	int ret;
> > +
> > +	ret = regmap_read(rx8581->regmap, RX8581_REG_RAM, &tmp_val);
> > +	(*(unsigned char *)val) = (unsigned char) tmp_val;
> > +
> > +	return ret;
> > +}
> > +
> > +static int rx85x1_nvram_write(void *priv, unsigned int offset, void *val,
> > +			      size_t bytes)
> > +{
> > +	struct rx8581 *rx8581 = priv;
> > +	unsigned char tmp_val;
> > +
> > +	tmp_val = *((unsigned char *)val);
> > +	return regmap_write(rx8581->regmap, RX8581_REG_RAM,
> > +				(unsigned int)tmp_val);
> > +}
> 
> I see that 85x1 has single byte of RAM. I'd still expect return of error in case
> of offset != 0 or bytes != 1.

As per the discussion we had in ML. Any validation to be done at nvmem framework level.

> Probably best done in mainline first...

We need to fix this issue at nvmem frame work level. Which involves API changes.
Please see the mail discussion related to this.

https://patchwork.kernel.org/patch/10723299/

May be at some point, we will have a fix for this issues.

regards,
Biju
