Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 094CCC4167B
	for <webhook@archiver.kernel.org>; Thu,  7 Dec 2023 11:18:06 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web11.81282.1701947881982404016
 for <cip-dev@lists.cip-project.org>;
 Thu, 07 Dec 2023 03:18:02 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id C93421C0080; Thu,  7 Dec 2023 12:17:59 +0100 (CET)
Date: Thu, 7 Dec 2023 12:17:59 +0100
From: Pavel Machek <pavel@denx.de>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH 5.10.y-cip 00/12]  Add display/dsi/gpt/poeg clk support
Message-ID: <ZXGp54L7auNL+rRs@duo.ucw.cz>
References: <20231207105508.171162-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Jh92bZhvx1UiXtTP"
Content-Disposition: inline
In-Reply-To: <20231207105508.171162-1-biju.das.jz@bp.renesas.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 07 Dec 2023 11:18:06 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13827


--Jh92bZhvx1UiXtTP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This patch series aims to add display/dsi/gpt/poeg clk support support on
> RZ/{G2L,G2LC,V2L} SMARC EVKs.
> =20
> All the patches are cherry-picked from the mainline.
>=20
> Display is tested with these clock patches. Will send DSI/VSPD
> driver/dt patches soon.

Series looks good to me. If it passes testing and if there are no
other comments, I can apply it.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--Jh92bZhvx1UiXtTP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZXGp5wAKCRAw5/Bqldv6
8ng4AKCYbCSzN4OPNSXf+phxogHjGrXJtgCgk8qIaNQWf4N9imC1L6TVQ+TRMqs=
=8zKp
-----END PGP SIGNATURE-----

--Jh92bZhvx1UiXtTP--

