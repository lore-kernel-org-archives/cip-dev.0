Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74B47C433F5
	for <webhook@archiver.kernel.org>; Tue,  1 Feb 2022 11:22:20 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web08.46926.1643714539637399227
 for <cip-dev@lists.cip-project.org>;
 Tue, 01 Feb 2022 03:22:20 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 0D9D11C0B81; Tue,  1 Feb 2022 12:22:18 +0100 (CET)
Date: Tue, 1 Feb 2022 12:22:17 +0100
From: Pavel Machek <pavel@denx.de>
To: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>, Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [PATCH 5.10.y-cip 00/27] Add RPCIF, SCI{F1} support to Renesas
 RZ/G2L SoC
Message-ID: <20220201112217.GF30077@amd>
References: <20220131121903.8620-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="oFbHfjnMgUMsrGjO"
Content-Disposition: inline
In-Reply-To: <20220131121903.8620-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 01 Feb 2022 11:22:20 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7556


--oFbHfjnMgUMsrGjO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This patch series add support for the below:
> * Adds a generic property "output-impedance-ohms"
> * Pinctrl driver update to support set/get drive-strength and
>   output-impedance-ohms
> * Driver fixes and updates for RPC-IF
> * Support to SPI Multi I/O Bus controller (RPC-IF) for RZ/G2L
> * Support to SCI for RZ/G2L SoC
> * DTS updates for RZ/G2L SMARC
>=20
> All the patches have been cherry-picked from Linux v5.17-rc2.

I found some minor details, but overall series looks okay. I'm
currently running tests, I can apply it if it passes and if there are
no other comments.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--oFbHfjnMgUMsrGjO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAmH5F+kACgkQMOfwapXb+vJl4ACfZ1x0je8ngJwP3df4HO21IgRi
MLoAnAyXDYn87s8Vg1RM8f8w9bssHkfB
=wrgR
-----END PGP SIGNATURE-----

--oFbHfjnMgUMsrGjO--

