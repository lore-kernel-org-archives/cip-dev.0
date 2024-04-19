Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D93A3C4345F
	for <webhook@archiver.kernel.org>; Fri, 19 Apr 2024 10:07:39 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web10.16978.1713521251956797531
 for <cip-dev@lists.cip-project.org>;
 Fri, 19 Apr 2024 03:07:32 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 2B03A1C0080; Fri, 19 Apr 2024 12:07:29 +0200 (CEST)
Date: Fri, 19 Apr 2024 12:07:28 +0200
From: Pavel Machek <pavel@denx.de>
To: Claudiu <claudiu.beznea@tuxon.dev>
Cc: nobuhiro1.iwamatsu@toshiba.co.jp, pavel@denx.de,
	cip-dev@lists.cip-project.org, biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com
Subject: Re: [PATCH 5.10.y-cip 00/53] Add initial support for the Renesas
 RZ/G3S SoC
Message-ID: <ZiJCYMyD2rciVwq9@duo.ucw.cz>
References: <20240419081742.3496709-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="M3ddLMR1xOlfwoB5"
Content-Disposition: inline
In-Reply-To: <20240419081742.3496709-1-claudiu.beznea.uj@bp.renesas.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 19 Apr 2024 10:07:39 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15649


--M3ddLMR1xOlfwoB5
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

Ok, let me review this.

But parts of these are not in 6.1. I'd like to merge this no earlier
than 5.10 changes.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--M3ddLMR1xOlfwoB5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZiJCYAAKCRAw5/Bqldv6
8mdGAJ9LM+HX/0vVg3CGJgx/GSbM7ZmTGACgpvc4qO5/2wHFFfjXqKkamm7PQEo=
=w8gj
-----END PGP SIGNATURE-----

--M3ddLMR1xOlfwoB5--

