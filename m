Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAE0EC433EF
	for <webhook@archiver.kernel.org>; Sun, 26 Dec 2021 16:08:15 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web08.17545.1640534893824201319
 for <cip-dev@lists.cip-project.org>;
 Sun, 26 Dec 2021 08:08:14 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 2DD0B1C0B76; Sun, 26 Dec 2021 17:08:10 +0100 (CET)
Date: Sun, 26 Dec 2021 17:08:09 +0100
From: Pavel Machek <pavel@denx.de>
To: cip-dev@lists.cip-project.org
Cc: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Pavel Machek <pavel@denx.de>,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [cip-dev] [PATCH 5.10.y-cip 15/21] can: rcar_canfd: Add support
 for RZ/G2L family
Message-ID: <20211226160809.GA13169@duo.ucw.cz>
References: <20211222134951.19432-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20211222134951.19432-16-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20211222231343.GA25345@amd>
 <OSZPR01MB7019D83A9F1DFC14AD31114EAA7D9@OSZPR01MB7019.jpnprd01.prod.outlook.com>
 <16C376847BE1186B.4760@lists.cip-project.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="45Z9DzgjV8m4Oswq"
Content-Disposition: inline
In-Reply-To: <16C376847BE1186B.4760@lists.cip-project.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sun, 26 Dec 2021 16:08:15 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7272


--45Z9DzgjV8m4Oswq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > Agreed, this needs a fix.
>=20
> Yes. OTOH this is just a problem in error paths. Other patches look
> good, so this should probably be fixed in the mainline.
>=20
> I can apply the series if there are no other comments.

I applied/pushed the series.

Best regards,

								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--45Z9DzgjV8m4Oswq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCYciTaQAKCRAw5/Bqldv6
8tlyAKCuedcxpyUP+w7Te1yfTMgkt6nxcACgm0L78tAv9FFtzcl5sCnwjvE9+DM=
=o7i4
-----END PGP SIGNATURE-----

--45Z9DzgjV8m4Oswq--

