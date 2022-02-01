Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03686C433F5
	for <webhook@archiver.kernel.org>; Tue,  1 Feb 2022 18:58:22 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web09.53259.1643741900555807657
 for <cip-dev@lists.cip-project.org>;
 Tue, 01 Feb 2022 10:58:21 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 6AD681C0B82; Tue,  1 Feb 2022 19:58:15 +0100 (CET)
Date: Tue, 1 Feb 2022 19:58:14 +0100
From: Pavel Machek <pavel@denx.de>
To: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>, Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [PATCH 5.10.y-cip 00/27] Add RPCIF, SCI{F1} support to Renesas
 RZ/G2L SoC
Message-ID: <20220201185814.GA23162@duo.ucw.cz>
References: <20220131121903.8620-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bp/iNruPH9dso1Pn"
Content-Disposition: inline
In-Reply-To: <20220131121903.8620-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 01 Feb 2022 18:58:21 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7561


--bp/iNruPH9dso1Pn
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

Testing did not uncover any kernel problems. I have applied the
patches and pushed the tree.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--bp/iNruPH9dso1Pn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCYfmCxgAKCRAw5/Bqldv6
8mLlAKCVDoBxv7l4cp7kTK/Qez2mBjNTYgCfe+lvFH/RCJKWnnw9ONXJQdnJGfA=
=h3Gi
-----END PGP SIGNATURE-----

--bp/iNruPH9dso1Pn--

