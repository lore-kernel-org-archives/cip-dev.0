Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5068C4345F
	for <webhook@archiver.kernel.org>; Sun, 21 Apr 2024 14:13:54 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web10.32737.1713708824270264370
 for <cip-dev@lists.cip-project.org>;
 Sun, 21 Apr 2024 07:13:44 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id CE5E11C0080; Sun, 21 Apr 2024 16:13:42 +0200 (CEST)
Date: Sun, 21 Apr 2024 16:13:42 +0200
From: Pavel Machek <pavel@denx.de>
To: Claudiu <claudiu.beznea@tuxon.dev>
Cc: nobuhiro1.iwamatsu@toshiba.co.jp, pavel@denx.de,
	cip-dev@lists.cip-project.org, biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com
Subject: Re: [PATCH 6.1.y-cip 00/44] Add initial support for the Renesas
 RZ/G3S SoC
Message-ID: <ZiUfFm+R5V1XantX@duo.ucw.cz>
References: <20240419113842.3675543-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="r3SrQMJlNmmnszOY"
Content-Disposition: inline
In-Reply-To: <20240419113842.3675543-1-claudiu.beznea.uj@bp.renesas.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sun, 21 Apr 2024 14:13:54 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15711


--r3SrQMJlNmmnszOY
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

This looks okay to me and it passed testing. (I have some minor
comments that should not prevent merge.) I can merge it if there are
no other comments.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--r3SrQMJlNmmnszOY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZiUfFgAKCRAw5/Bqldv6
8m0iAJ97pS5J4+T/bFmYbekUD9mwSk66iwCfQeGgB7IhwgDVN8JyYwMfw/GcOKQ=
=vT2w
-----END PGP SIGNATURE-----

--r3SrQMJlNmmnszOY--

