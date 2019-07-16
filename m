From: pavel@denx.de (Pavel Machek)
Date: Tue, 16 Jul 2019 22:22:12 +0200
Subject: [cip-dev] [PATCH 4.19.y-cip 4/6] rtc: rx8581: Add support for
 Epson rx8571 RTC
In-Reply-To: <1563200245-30331-5-git-send-email-biju.das@bp.renesas.com>
References: <1563200245-30331-1-git-send-email-biju.das@bp.renesas.com>
	<1563200245-30331-5-git-send-email-biju.das@bp.renesas.com>
Message-ID: <20190716202212.GB9557@amd>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi!

> +static int rx85x1_nvram_read(void *priv, unsigned int offset, void *val,
> +			     size_t bytes)
> +{
> +	struct rx8581 *rx8581 = priv;
> +	unsigned int tmp_val;
> +	int ret;
> +
> +	ret = regmap_read(rx8581->regmap, RX8581_REG_RAM, &tmp_val);
> +	(*(unsigned char *)val) = (unsigned char) tmp_val;
> +
> +	return ret;
> +}
> +
> +static int rx85x1_nvram_write(void *priv, unsigned int offset, void *val,
> +			      size_t bytes)
> +{
> +	struct rx8581 *rx8581 = priv;
> +	unsigned char tmp_val;
> +
> +	tmp_val = *((unsigned char *)val);
> +	return regmap_write(rx8581->regmap, RX8581_REG_RAM,
> +				(unsigned int)tmp_val);
> +}

I see that 85x1 has single byte of RAM. I'd still expect return of
error in case of offset != 0 or bytes != 1.

Probably best done in mainline first...

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
URL: <http://lists.cip-project.org/pipermail/cip-dev/attachments/20190716/22b19a6e/attachment.sig>
