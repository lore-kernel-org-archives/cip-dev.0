Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7901AC30653
	for <webhook@archiver.kernel.org>; Sun,  7 Jul 2024 09:31:00 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web11.55107.1720344652411050854
 for <cip-dev@lists.cip-project.org>;
 Sun, 07 Jul 2024 02:30:52 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 0884C1C0099; Sun,  7 Jul 2024 11:30:50 +0200 (CEST)
Date: Sun, 7 Jul 2024 11:30:49 +0200
From: Pavel Machek <pavel@denx.de>
To: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>, Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [PATCH 5.10.y-cip 00/10] Add IRQC support for RZ/Five SoC
Message-ID: <ZopgSYBT9hdgz+yO@duo.ucw.cz>
References: <20240705125230.125392-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="d54jieonXVdB3+FY"
Content-Disposition: inline
In-Reply-To: <20240705125230.125392-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sun, 07 Jul 2024 09:31:00 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16423


--d54jieonXVdB3+FY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This patch series aims to add IRQC support to RZ/Five SoC. While at it
> fix build warning for RZ/G2L CPG driver and fix for ax45mp_cache driver.
>=20
> - patch 1/10 new patch
> - patch 5/10 and 6/10 have been cherry picked from -next
> - rest of the patches are have been cherry picked from v6.10-rc6

I went through the series and it looks okay to me. I can apply it if
it passes testing and if there are no other comments.

Best regards,
                                                                Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--d54jieonXVdB3+FY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZopgSQAKCRAw5/Bqldv6
8gjAAJ4pxyF68xInaYFie3EGafTJ8FMuTACguyOgi3xeQPuHACA83LWBua5RzLg=
=i4Iq
-----END PGP SIGNATURE-----

--d54jieonXVdB3+FY--

