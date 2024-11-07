Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89A65D5D687
	for <webhook@archiver.kernel.org>; Thu,  7 Nov 2024 19:57:22 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web11.1885.1731009433838163578
 for <cip-dev@lists.cip-project.org>;
 Thu, 07 Nov 2024 11:57:14 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=fail (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 6D07E1C00A0; Thu,  7 Nov 2024 20:57:11 +0100 (CET)
Date: Thu, 7 Nov 2024 20:57:10 +0100
From: Pavel Machek <pavel@denx.de>
To: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>, Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [PATCH 5.10.y-cip v2 0/5] Enable CRU, CSI support on RZ/{G2LC,
 G2UL}
Message-ID: <Zy0blthjPWyLzs3U@duo.ucw.cz>
References: <20241107093934.14574-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gZd5jWLXVlpVp6zJ"
Content-Disposition: inline
In-Reply-To: <20241107093934.14574-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 07 Nov 2024 19:57:22 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17223


--gZd5jWLXVlpVp6zJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This patch series aims to add (and enable) CRU, CSI support on the
> Renesas RZ/{G2LC, G2UL} SoCs.
>=20
> All the patches have been cherry-picked from upstream.

Series looks good to me.

Reviewed-by: Pavel Machek <pavel@denx.de>
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--gZd5jWLXVlpVp6zJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZy0blgAKCRAw5/Bqldv6
8paDAKCYjjzN94h3STgh6kdKaRxWkHSzaQCfe1SPQ/fYXDd6mIYBtE70PHw2+5w=
=EHHU
-----END PGP SIGNATURE-----

--gZd5jWLXVlpVp6zJ--

