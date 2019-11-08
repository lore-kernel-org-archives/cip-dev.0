From: pavel@denx.de (Pavel Machek)
Date: Fri, 8 Nov 2019 10:22:51 +0100
Subject: [cip-dev] [PATCH 4.4.y-cip 31/83] mmc: host: sh_mobile_sdhi:
 move card_busy from tmio to sdhi
In-Reply-To: <1573115572-13513-32-git-send-email-biju.das@bp.renesas.com>
References: <1573115572-13513-1-git-send-email-biju.das@bp.renesas.com>
	<1573115572-13513-32-git-send-email-biju.das@bp.renesas.com>
Message-ID: <20191108092251.GE1017@amd>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

On Thu 2019-11-07 08:32:00, Biju Das wrote:
> From: Wolfram Sang <wsa+renesas@sang-engineering.com>
> 
> commit 6a4679f312357ac7c74c0e1b996efdd1d0a612fa upstream.
> 
> card_busy is only used/tested on SDHI for R-Car Gen2 and later.
> Move it to the SDHI driver, so we can then activate it conditionally
> depending on the SDHI type.


> @@ -217,6 +217,13 @@ static void sh_mobile_sdhi_clk_disable(struct tmio_mmc_host *host)
>  	clk_disable_unprepare(priv->clk);
>  }
>  
> +static int sh_mobile_sdhi_card_busy(struct mmc_host *mmc)
> +{
> +	struct tmio_mmc_host *host = mmc_priv(mmc);
> +
> +	return !(sd_ctrl_read16_and_16_as_32(host, CTL_STATUS) & TMIO_STAT_DAT0);
> +}
> +

Bool would make sense here, if the change is practical without
changing too many interfaces... (and unless interface is something
like 0/1/-ERRNO...)

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
URL: <http://lists.cip-project.org/pipermail/cip-dev/attachments/20191108/e0254263/attachment.sig>
