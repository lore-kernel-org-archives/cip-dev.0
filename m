Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1E43C54E67
	for <webhook@archiver.kernel.org>; Thu, 28 Mar 2024 10:44:07 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web11.12651.1711622646925926131
 for <cip-dev@lists.cip-project.org>;
 Thu, 28 Mar 2024 03:44:07 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 5F2E01C0081; Thu, 28 Mar 2024 11:44:04 +0100 (CET)
Date: Thu, 28 Mar 2024 11:44:03 +0100
From: Pavel Machek <pavel@denx.de>
To: Claudiu <claudiu.beznea@tuxon.dev>
Cc: nobuhiro1.iwamatsu@toshiba.co.jp, pavel@denx.de,
	cip-dev@lists.cip-project.org, biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com
Subject: Re: [PATCH 6.1.y-cip 00/13] Update IA55 driver
Message-ID: <ZgVJ83cHgn33gV00@duo.ucw.cz>
References: <20240327083508.2229567-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="kDLQqWgXLW1YJQsD"
Content-Disposition: inline
In-Reply-To: <20240327083508.2229567-1-claudiu.beznea.uj@bp.renesas.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 28 Mar 2024 10:44:07 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15475


--kDLQqWgXLW1YJQsD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>=20
> Hi,
>=20
> This series updates the Renesas IA55 IRQ driver with patches from
> mainline kernel. Along with it, a patch for Renesas pin controller driver
> was cherry-picked from mainline kernel.

Thanks for series, applied.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--kDLQqWgXLW1YJQsD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZgVJ8wAKCRAw5/Bqldv6
8h4lAKCIQJOKSb9mORB6adMhE3Gl8+ZuNACfSx46Fg03xwkXc21+o5bwGz/PU0Q=
=XWAw
-----END PGP SIGNATURE-----

--kDLQqWgXLW1YJQsD--

