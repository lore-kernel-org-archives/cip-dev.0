Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0014C433EF
	for <webhook@archiver.kernel.org>; Wed, 22 Dec 2021 09:45:52 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web10.17340.1640166351261386063
 for <cip-dev@lists.cip-project.org>;
 Wed, 22 Dec 2021 01:45:52 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id EE8DE1C0B7C; Wed, 22 Dec 2021 10:45:46 +0100 (CET)
Date: Wed, 22 Dec 2021 10:45:46 +0100
From: Pavel Machek <pavel@denx.de>
To: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>, Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [PATCH 5.10.y-cip 03/22] dt-bindings: pinctrl: renesas: Add DT
 bindings for RZ/G2L pinctrl
Message-ID: <20211222094546.GB15186@amd>
References: <20211220133139.21624-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20211220133139.21624-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ZoaI/ZTpAVc4A5k6"
Content-Disposition: inline
In-Reply-To: <20211220133139.21624-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 22 Dec 2021 09:45:52 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7225


--ZoaI/ZTpAVc4A5k6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> commit 7958f88aa6636f1927513c887a00e83168f12e35 upstream.
>=20
> Add device tree binding documentation and header file for Renesas
> RZ/G2L pinctrl.
>=20
> +        drive-strength:
> +          enum: [ 2, 4, 8, 12 ]
> +        power-source:
> +          enum: [ 1800, 2500, 3300 ]

These are likely milliamps and millivolts, right? Elsewhere in device
trees microvolts and microamps are used, so that is not too
consistent.

Is the unit mentioned somewhere / should it be?

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--ZoaI/ZTpAVc4A5k6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAmHC88oACgkQMOfwapXb+vJ5BQCdHEBJ++E4R3fRWI0PGruNFwgR
TEoAoI1wNv6km+oiP3dC+rnVYCD1YJsI
=oGEb
-----END PGP SIGNATURE-----

--ZoaI/ZTpAVc4A5k6--

