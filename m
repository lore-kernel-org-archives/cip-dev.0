From: pavel@denx.de (Pavel Machek)
Date: Fri, 8 Nov 2019 10:24:57 +0100
Subject: [cip-dev] [PATCH 4.4.y-cip 33/83] mmc: tmio: add eMMC support
In-Reply-To: <1573115572-13513-34-git-send-email-biju.das@bp.renesas.com>
References: <1573115572-13513-1-git-send-email-biju.das@bp.renesas.com>
	<1573115572-13513-34-git-send-email-biju.das@bp.renesas.com>
Message-ID: <20191108092457.GF1017@amd>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

On Thu 2019-11-07 08:32:02, Biju Das wrote:
> From: Wolfram Sang <wsa+renesas@sang-engineering.com>
> 
> commit 0bc0b6e86524526c92a9409faea79d53db8e7e6e upstream.
> 
> We need to add R1 without CRC support, refactor the bus width routine a
> little and extend a quirk check. To support "non-removable;" we need a
> workaround which will be hopefully removed when reworking PM soon.

> index addbc71..eafd92d 100644
> --- a/drivers/mmc/host/tmio_mmc.h
> +++ b/drivers/mmc/host/tmio_mmc.h
> @@ -79,6 +79,9 @@
>  #define	CLK_CTL_DIV_MASK	0xff
>  #define	CLK_CTL_SCLKEN		BIT(8)
>  
> +#define CARD_OPT_WIDTH8		BIT(13)
> +#define CARD_OPT_WIDTH		BIT(15)

WIDTH_1 and WIDTH_8 would be better names, for consistency with rest
of code. "WIDTH" without number is quite confusing.

Best regards,
								Pavel
								
> +	/* Some hardware cannot perform 2 byte requests in 4/8 bit mode */
> +	if (host->mmc->ios.bus_width == MMC_BUS_WIDTH_4 ||
> +	    host->mmc->ios.bus_width == MMC_BUS_WIDTH_8) {

-- 
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: Digital signature
URL: <http://lists.cip-project.org/pipermail/cip-dev/attachments/20191108/cb80b4d0/attachment-0001.sig>
