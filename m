Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1A1AC4345F
	for <webhook@archiver.kernel.org>; Mon, 22 Apr 2024 20:37:37 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web11.2940.1713818250499742817
 for <cip-dev@lists.cip-project.org>;
 Mon, 22 Apr 2024 13:37:30 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 842191C0080; Mon, 22 Apr 2024 22:37:27 +0200 (CEST)
Date: Mon, 22 Apr 2024 22:37:27 +0200
From: Pavel Machek <pavel@denx.de>
To: Claudiu <claudiu.beznea@tuxon.dev>
Cc: nobuhiro1.iwamatsu@toshiba.co.jp, pavel@denx.de,
	cip-dev@lists.cip-project.org, biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com
Subject: Re: [PATCH 6.1.y-cip 00/44] Add initial support for the Renesas
 RZ/G3S SoC
Message-ID: <ZibKh3qxKMgR9ZDS@duo.ucw.cz>
References: <20240419113842.3675543-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="GzB+/hHni0IqQRcS"
Content-Disposition: inline
In-Reply-To: <20240419113842.3675543-1-claudiu.beznea.uj@bp.renesas.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 22 Apr 2024 20:37:37 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15730


--GzB+/hHni0IqQRcS
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This patch series adds initial support for The Renesas RZ/G3S (R9A08G045{=
S33})
> SoC. The RZ/G3S device is a general-purpose microprocessor with a
> single-core Arm=AE Cortex=AE-A55 (1.1GHz) and a dual-core Arm=AE Cortex=
=AE-M33 (250MHz),
> perfect for an IOT gateway controller.
>=20
> This patch series includes:
> - SoC identification;
> - clocks (core clocks, pin controller clock, serial interface, SDHI
>   clocks) and corresponding resets;
> - pinctrl support necessary for SDHIs and serial console
> - minimal device tree for SoM and carrier boards.
>=20
> With this series Linux can boot from eMMC or SD card. The eMMC and uSD
> interface are multiplexed on the SoM; selection is made using a hardware
> switch.

Thanks for the patches, applied.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--GzB+/hHni0IqQRcS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZibKhwAKCRAw5/Bqldv6
8rYiAKCib62D2v6PBpiDYcP9Md+MJ9APvACeI1DgRnAll/z/Je67gs0EqAEO5IQ=
=6NWK
-----END PGP SIGNATURE-----

--GzB+/hHni0IqQRcS--

