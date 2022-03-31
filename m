Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41324C433F5
	for <webhook@archiver.kernel.org>; Thu, 31 Mar 2022 10:14:56 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web10.5337.1648721694537377878
 for <cip-dev@lists.cip-project.org>;
 Thu, 31 Mar 2022 03:14:55 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 5ABC91C0B96; Thu, 31 Mar 2022 12:14:51 +0200 (CEST)
Date: Thu, 31 Mar 2022 12:14:50 +0200
From: Pavel Machek <pavel@denx.de>
To: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>, Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [PATCH 5.10.y-cip 09/39] mmc: renesas_sdhi: sort includes
Message-ID: <20220331101450.GB21513@amd>
References: <20220330185454.10887-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220330185454.10887-10-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ZfOjI3PrQbgiZnxM"
Content-Disposition: inline
In-Reply-To: <20220330185454.10887-10-prabhakar.mahadev-lad.rj@bp.renesas.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 31 Mar 2022 10:14:56 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7896


--ZfOjI3PrQbgiZnxM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> From: Wolfram Sang <wsa+renesas@sang-engineering.com>
>=20
> commit ab07a1356043f07142ba351253904ef8c42ecd4f upstream.
>=20
> Better prevent double includes.

> +++ b/drivers/mmc/host/renesas_sdhi_core.c
> @@ -18,22 +18,22 @@
>   *
>   */
> =20
> -#include <linux/kernel.h>
>  #include <linux/clk.h>
> -#include <linux/slab.h>
> -#include <linux/module.h>
> -#include <linux/of_device.h>
> -#include <linux/platform_device.h>
> -#include <linux/pm_domain.h>
> +#include <linux/delay.h>
> +#include <linux/kernel.h>
> +#include <linux/mfd/tmio.h>
>  #include <linux/mmc/host.h>
>  #include <linux/mmc/mmc.h>
>  #include <linux/mmc/slot-gpio.h>
> -#include <linux/mfd/tmio.h>
> -#include <linux/sh_dma.h>
> -#include <linux/delay.h>
> +#include <linux/module.h>
> +#include <linux/of_device.h>
>  #include <linux/pinctrl/consumer.h>
>  #include <linux/pinctrl/pinctrl-state.h>
> +#include <linux/platform_device.h>
> +#include <linux/pm_domain.h>
>  #include <linux/regulator/consumer.h>
> +#include <linux/sh_dma.h>
> +#include <linux/slab.h>
>  #include <linux/sys_soc.h>
> =20
>  #include "renesas_sdhi.h"

In these cases we usually sort be include length, first ("reverse
xmass tree").

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--ZfOjI3PrQbgiZnxM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAmJFfxoACgkQMOfwapXb+vLZkQCdHQJ2BtW7iL0flbHdJc49nu+C
DhMAn2P2EmMJfO4xwrrk3cylx0zXddOi
=7N8M
-----END PGP SIGNATURE-----

--ZfOjI3PrQbgiZnxM--

