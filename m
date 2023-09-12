Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2F70EE3F33
	for <webhook@archiver.kernel.org>; Tue, 12 Sep 2023 21:15:06 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web10.2191.1694553296231219252
 for <cip-dev@lists.cip-project.org>;
 Tue, 12 Sep 2023 14:14:57 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id B7EA21C001B; Tue, 12 Sep 2023 23:14:54 +0200 (CEST)
Date: Tue, 12 Sep 2023 23:14:54 +0200
From: Pavel Machek <pavel@denx.de>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: Re: [PATCH 6.1.y-cip 00/14] Enable Renesas PMIC RAA215300 and RTC
 builtin support
Message-ID: <ZQDUzmyf4zQGd4fB@duo.ucw.cz>
References: <20230911162840.1115401-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/hwUtK7uhNEDT2X0"
Content-Disposition: inline
In-Reply-To: <20230911162840.1115401-1-biju.das.jz@bp.renesas.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 12 Sep 2023 21:15:06 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13091


--/hwUtK7uhNEDT2X0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This patch series aims to enable PMIC RAA215300 and builtin RTC support on
> RZ/G2L SMARC EVK platform.
> =20
> All the patches are cherry-picked from the mainline.

This is a bit strange; these two look quite unrelated.

>   arm64: dts: renesas: rzg2lc-smarc-som: Add PHY interrupt support for
>     ETH0
>   arm64: dts: renesas: rzg2l: Fix txdv-skew-psec typos

I'm happy to apply the rest (unless testing fails or someone
objects). I can take these two, too, if you tell me this is
intentional.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--/hwUtK7uhNEDT2X0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZQDUzgAKCRAw5/Bqldv6
8vDnAJ9Nfr94HJz0y9JkHMWCepORMm3W4wCfZ4nujB6JP8C75w5nt/NXugbFOtk=
=6MEj
-----END PGP SIGNATURE-----

--/hwUtK7uhNEDT2X0--

