Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82EA4C27C40
	for <webhook@archiver.kernel.org>; Wed, 22 Nov 2023 21:01:22 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web11.39891.1700686878486270643
 for <cip-dev@lists.cip-project.org>;
 Wed, 22 Nov 2023 13:01:18 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 14C371C0050; Wed, 22 Nov 2023 22:01:16 +0100 (CET)
Date: Wed, 22 Nov 2023 22:01:15 +0100
From: Pavel Machek <pavel@denx.de>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: Re: [PATCH 6.1.y-cip 0/3] Document MTU3 IP on RZ/{G2UL,Five} SoCs
Message-ID: <ZV5sG6y3chKkzI+8@duo.ucw.cz>
References: <20231122165106.235838-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vD1UxaLTlYzvLY0F"
Content-Disposition: inline
In-Reply-To: <20231122165106.235838-1-biju.das.jz@bp.renesas.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 22 Nov 2023 21:01:22 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13651


--vD1UxaLTlYzvLY0F
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This patch series aims to document MTU3 IP on RZ/G2{UL,Five} SoCs.
>=20
> All the patches are cherry-picked from the mainline.

Thanks for series. Looks ok to me, and I can apply it if there are no
other comments.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--vD1UxaLTlYzvLY0F
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZV5sGwAKCRAw5/Bqldv6
8keQAJ0W128yOs0ChZfDeRshy4Hz7yPpMACdEmiDXEytTPqhc4qKEBywemCtI7c=
=l3ID
-----END PGP SIGNATURE-----

--vD1UxaLTlYzvLY0F--

