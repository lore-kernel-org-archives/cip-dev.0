From: pavel@denx.de (Pavel Machek)
Date: Fri, 8 Nov 2019 10:42:11 +0100
Subject: [cip-dev] [PATCH 4.4.y-cip 56/83] mmc: host: tmio: refactor
 calls to sdio irq
In-Reply-To: <1573115572-13513-57-git-send-email-biju.das@bp.renesas.com>
References: <1573115572-13513-1-git-send-email-biju.das@bp.renesas.com>
	<1573115572-13513-57-git-send-email-biju.das@bp.renesas.com>
Message-ID: <20191108094211.GK1017@amd>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

On Thu 2019-11-07 08:32:25, Biju Das wrote:
> From: Wolfram Sang <wsa+renesas@sang-engineering.com>
> 
> commit e4f38eb18aedd098b3019e82df07f583a5cbcc58 upstream.
> 
> tmio_mmc_sdio_irq() is not used as a seperate irq handler anymore, so we
> can make it similar to the other irq helper functions, namely:
> 
> * only give the host as argument function which is what it really needs
> * prefix function name with __
> 

> +++ b/drivers/mmc/host/tmio_mmc_pio.c
> @@ -709,7 +709,7 @@ static bool __tmio_mmc_sdcard_irq(struct tmio_mmc_host *host,
>  	return false;
>  }
>  
> -static bool tmio_mmc_sdio_irq(int irq, void *devid)
> +static bool __tmio_mmc_sdio_irq(int irq, void *devid)
>  {
>  	struct tmio_mmc_host *host = devid;
>  	struct mmc_host *mmc = host->mmc;


In mainline, the commit removes the argument, as it says in the
changelog. Not here in the backport. Why the difference?

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
URL: <http://lists.cip-project.org/pipermail/cip-dev/attachments/20191108/56413811/attachment.sig>
