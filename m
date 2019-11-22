From: pavel@denx.de (Pavel Machek)
Date: Fri, 22 Nov 2019 10:43:34 +0100
Subject: [cip-dev] [PATCH 4.4.y-cip 01/17] mmc: tmio: rename
 tmio_mmc_{pio => core}.c
In-Reply-To: <1574341247-46652-2-git-send-email-biju.das@bp.renesas.com>
References: <1574341247-46652-1-git-send-email-biju.das@bp.renesas.com>
 <1574341247-46652-2-git-send-email-biju.das@bp.renesas.com>
Message-ID: <20191122094334.GB30479@amd>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

On Thu 2019-11-21 13:00:31, Biju Das wrote:
> From: Simon Horman <horms+renesas@verge.net.au>
> 
> commit 426e95d1766bad20e59f219af64fdd50c39bcfee upstream.
> 
> Rename tmio_mmc_pio.c to tmio_mmc_core.c to more accurately reflect its
> function: to provide core code for the tmio-mmc and sh-mobole-sdhi drivers.

...

> ---
>  drivers/mmc/host/Makefile        |    1 -
>  drivers/mmc/host/tmio_mmc_core.c | 1392 ++++++++++++++++++++++++++++++++++++++
>  drivers/mmc/host/tmio_mmc_pio.c  | 1392 --------------------------------------

This is just a rename with no changes. Good.

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
URL: <http://lists.cip-project.org/pipermail/cip-dev/attachments/20191122/8a0cb78f/attachment.sig>
