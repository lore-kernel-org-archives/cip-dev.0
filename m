Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD8B0C27C7B
	for <webhook@archiver.kernel.org>; Thu, 13 Jun 2024 11:47:32 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web11.6563.1718279243107024535
 for <cip-dev@lists.cip-project.org>;
 Thu, 13 Jun 2024 04:47:23 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id A97AA1C0082; Thu, 13 Jun 2024 13:47:20 +0200 (CEST)
Date: Thu, 13 Jun 2024 13:47:20 +0200
From: Pavel Machek <pavel@denx.de>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH 5.10.y-cip 0/7] Fix USBHS pipe configuration
Message-ID: <ZmrcSDQuJTRiQbCl@duo.ucw.cz>
References: <20240613104726.422783-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wPtOHpRcUf/5lErZ"
Content-Disposition: inline
In-Reply-To: <20240613104726.422783-1-biju.das.jz@bp.renesas.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 13 Jun 2024 11:47:32 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16218


--wPtOHpRcUf/5lErZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> The USBHS IP found on RZ/G2L SoCs only has 10 pipe buffers compared to 16
> pipe buffers on RZ/A2M.
>=20
> Fix the USBHS Pipe configuration
>=20
> All the patches are cherry-picked from the mainline.

This looks ok to me. I can apply it if there are no other comments and
if it passes testing.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--wPtOHpRcUf/5lErZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZmrcSAAKCRAw5/Bqldv6
8mDSAJwJZfy3FhQ9tiTCZjRFkZGJzeUlfACfSTZOgW85H2Y5jSaYY7aRxo9dfeQ=
=0dWD
-----END PGP SIGNATURE-----

--wPtOHpRcUf/5lErZ--

