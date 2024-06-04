Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49315C25B78
	for <webhook@archiver.kernel.org>; Tue,  4 Jun 2024 13:21:01 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web10.21385.1717507254642096804
 for <cip-dev@lists.cip-project.org>;
 Tue, 04 Jun 2024 06:20:55 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 4C5A31C0082; Tue,  4 Jun 2024 15:20:52 +0200 (CEST)
Date: Tue, 4 Jun 2024 15:20:51 +0200
From: Pavel Machek <pavel@denx.de>
To: nobuhiro1.iwamatsu@toshiba.co.jp
Cc: claudiu.beznea@tuxon.dev, pavel@denx.de, cip-dev@lists.cip-project.org,
	biju.das.jz@bp.renesas.com, prabhakar.mahadev-lad.rj@bp.renesas.com,
	paul.barker.ct@bp.renesas.com
Subject: Re: [PATCH 6.1.y-cip 00/33] Add Ethernet support for Renesas RZ/G3S
 SoC
Message-ID: <Zl8Us5exOfhznry6@duo.ucw.cz>
References: <20240529081434.639519-1-claudiu.beznea.uj@bp.renesas.com>
 <OS0PR01MB6388FD37BAFD725020BEB60992F32@OS0PR01MB6388.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="hBhXgfgIjLsGXZ1K"
Content-Disposition: inline
In-Reply-To: <OS0PR01MB6388FD37BAFD725020BEB60992F32@OS0PR01MB6388.jpnprd01.prod.outlook.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 04 Jun 2024 13:21:01 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16106


--hBhXgfgIjLsGXZ1K
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Thanks for your work.
> I reviewd this series, so I have no comments.
>=20
> Reviewed-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>

Thank you, applied.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--hBhXgfgIjLsGXZ1K
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZl8UswAKCRAw5/Bqldv6
8i3hAKCP3lOvqp+U99n/3L5Z+0sjDqFQVQCghaD7xXia9LFGasgkYOho9VvJi4E=
=2yGP
-----END PGP SIGNATURE-----

--hBhXgfgIjLsGXZ1K--

