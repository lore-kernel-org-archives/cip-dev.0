Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB145C27C55
	for <webhook@archiver.kernel.org>; Mon, 10 Jun 2024 21:21:53 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web11.31449.1718054508768236238
 for <cip-dev@lists.cip-project.org>;
 Mon, 10 Jun 2024 14:21:49 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 5043F1C008E; Mon, 10 Jun 2024 23:21:47 +0200 (CEST)
Date: Mon, 10 Jun 2024 23:21:46 +0200
From: Pavel Machek <pavel@denx.de>
To: Claudiu <claudiu.beznea@tuxon.dev>
Cc: nobuhiro1.iwamatsu@toshiba.co.jp, pavel@denx.de,
	cip-dev@lists.cip-project.org, biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com
Subject: Re: [PATCH 6.1.y-cip 00/17] Add suspend to RAM support for pin and
 IA55 IRQ controllers
Message-ID: <ZmduagIa3vZ6y1Ft@duo.ucw.cz>
References: <20240607140856.2497508-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="CHoWDPtbCCJJgb5W"
Content-Disposition: inline
In-Reply-To: <20240607140856.2497508-1-claudiu.beznea.uj@bp.renesas.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 10 Jun 2024 21:21:53 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16184


--CHoWDPtbCCJJgb5W
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Series adds suspend to RAM support for pin and IA55 IRQ controller.
> Support is needed for RZ/G3S SoC.
>=20
> Along with it pin controller and IA55 interrupt controller drivers
> were updated with enhancements.
>=20
> Series is split as follows:
> - patch 01:      add clock and reset support for IA55 IRQ controller on
>                  RZ/G3S
> - patches 02-08: update the pin controller driver with fixes for spurious
>                  interrupts when pin controller interrupt lines are routed
>                  to IA55 IRQ controller
> - patch 09:      add suspend to RAM support for pinctrl driver

I went through the patches, and while 09 looks "interesting", I don't
see any functionality problem and its nothing we should change in
-cip.

So, I can apply the series if I get no other comments and if it passes
testing.

Best regards,
								Pavel
							=09
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--CHoWDPtbCCJJgb5W
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZmduagAKCRAw5/Bqldv6
8hzCAJ9p4NNtmGhLbZ2uLxYv754Ysknd1wCgkf6deEyQmAWGzpetIigt264f1sA=
=CrJZ
-----END PGP SIGNATURE-----

--CHoWDPtbCCJJgb5W--

