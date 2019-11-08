From: pavel@denx.de (Pavel Machek)
Date: Fri, 8 Nov 2019 10:20:54 +0100
Subject: [cip-dev] [PATCH 4.4.y-cip 26/83] mmc: tmio/sdhi: introduce
 flag for RCar 2+ specific features
In-Reply-To: <1573115572-13513-27-git-send-email-biju.das@bp.renesas.com>
References: <1573115572-13513-1-git-send-email-biju.das@bp.renesas.com>
	<1573115572-13513-27-git-send-email-biju.das@bp.renesas.com>
Message-ID: <20191108092054.GD1017@amd>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi!

> @@ -66,8 +66,8 @@
>   */
>  #define TMIO_MMC_SDIO_IRQ		(1 << 2)
>  
> -/* Some controllers don't need to wait 10ms for clock changes */
> -#define TMIO_MMC_FAST_CLK_CHG		(1 << 3)
> +/* Some features are only available or tested on RCar Gen2 or later */
> +#define TMIO_MMC_MIN_RCAR2		(1 << 3)
>  

I'd add a comment here that gen2 allows fast clock changes ... and
whatever other features the driver is actually using.

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
URL: <http://lists.cip-project.org/pipermail/cip-dev/attachments/20191108/8abb7a83/attachment.sig>
