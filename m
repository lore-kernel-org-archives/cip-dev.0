Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98C26C83F12
	for <webhook@archiver.kernel.org>; Tue, 29 Aug 2023 20:33:10 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web10.1676.1693341185920887278
 for <cip-dev@lists.cip-project.org>;
 Tue, 29 Aug 2023 13:33:06 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 3401C1C0004; Tue, 29 Aug 2023 22:33:03 +0200 (CEST)
Date: Tue, 29 Aug 2023 22:33:02 +0200
From: Pavel Machek <pavel@denx.de>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: Re: [PATCH 5.10.y-cip 0/2] Fix RZ/{G2L,V2M} pinctrl NULL pointer
 dereference
Message-ID: <ZO5V/tvoS/u0DBlW@duo.ucw.cz>
References: <20230829135148.173386-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Bk2Jb1M5m9B/hR9R"
Content-Disposition: inline
In-Reply-To: <20230829135148.173386-1-biju.das.jz@bp.renesas.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 29 Aug 2023 20:33:10 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12896


--Bk2Jb1M5m9B/hR9R
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This patch series aims to fix RZ/{G2L,V2M} pinctrl NULL pointer
> dereference
> =20
> All the patches are cherry-picked from the mainline.
>=20
> This patch is not required for 6.1.y as it will be applied in
> stable.

Ok, looks good to me, I can apply it if there are no other comments
and if it passes testing.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--Bk2Jb1M5m9B/hR9R
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZO5V/gAKCRAw5/Bqldv6
8kT2AJ9uifEQ0o0JCejnPzB2DMeduFSeIwCfa1Tmw/ats/DU3LOmzZ/Mj0l2xw4=
=dZSA
-----END PGP SIGNATURE-----

--Bk2Jb1M5m9B/hR9R--

