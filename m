Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CC31C25B75
	for <webhook@archiver.kernel.org>; Wed, 29 May 2024 18:42:31 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web10.23693.1717008144073747836
 for <cip-dev@lists.cip-project.org>;
 Wed, 29 May 2024 11:42:24 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 853441C0080; Wed, 29 May 2024 20:42:21 +0200 (CEST)
Date: Wed, 29 May 2024 20:42:20 +0200
From: Pavel Machek <pavel@denx.de>
To: Claudiu <claudiu.beznea@tuxon.dev>
Cc: nobuhiro1.iwamatsu@toshiba.co.jp, pavel@denx.de,
	cip-dev@lists.cip-project.org, biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	paul.barker.ct@bp.renesas.com
Subject: Re: [PATCH 6.1.y-cip 00/33] Add Ethernet support for Renesas RZ/G3S
 SoC
Message-ID: <Zld3DHvUmRKYE8Mt@duo.ucw.cz>
References: <20240529081434.639519-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="f6ISjL1SpzcmxV+c"
Content-Disposition: inline
In-Reply-To: <20240529081434.639519-1-claudiu.beznea.uj@bp.renesas.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 29 May 2024 18:42:31 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16067


--f6ISjL1SpzcmxV+c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Series adds Ethernet support for Renesas RZ/G3S SoC. Ethernet driver
> has been enhanced with runtime PM support. The suspend to RAM support
> was also improved.

I started reviewing this, and it looks okay so far. I can apply it
if it passes testing and there are no other comments.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--f6ISjL1SpzcmxV+c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZld3DAAKCRAw5/Bqldv6
8mRnAJ0ZVPh+IKkPCtnP8WXP4WNDfsBR5QCgivcG3kfSUczxlsjuS7kQAQ4cYfU=
=g1WY
-----END PGP SIGNATURE-----

--f6ISjL1SpzcmxV+c--

