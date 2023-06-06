Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E877C77B7A
	for <webhook@archiver.kernel.org>; Tue,  6 Jun 2023 09:16:00 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web10.4408.1686042958628219627
 for <cip-dev@lists.cip-project.org>;
 Tue, 06 Jun 2023 02:15:58 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 4D7F91C0CAF; Tue,  6 Jun 2023 11:15:56 +0200 (CEST)
Date: Tue, 6 Jun 2023 11:15:55 +0200
From: Pavel Machek <pavel@denx.de>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>,
	Chris Paterson <chris.paterson2@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH 6.1.y-cip 0/8] Add MTU3 core/counter driver support for
 RZ/G2L alike SoCs
Message-ID: <ZH75S2f7nR3fHCDP@duo.ucw.cz>
References: <20230606075235.183132-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="yQBbXLrz4HQIbUgv"
Content-Disposition: inline
In-Reply-To: <20230606075235.183132-1-biju.das.jz@bp.renesas.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 06 Jun 2023 09:16:00 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11852


--yQBbXLrz4HQIbUgv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This patch series aims to add MTU3 core/counter driver support for RZ/G2L=
 alike
> SoCs.
>=20
> All these patches are cherry-picked from the mainline.
>=20
> It is tested with Rotary encoder[1]
> [1]
> https://www.mouser.co.uk/ProductDetail/Alps-Alpine/EC11E15244B2?qs=3Dm0BA=
540hBPfDpUEkDmFV5A%3D%3D

I'll review this, but lets delay merging this after 6.1-cip1 is
released.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--yQBbXLrz4HQIbUgv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZH75SwAKCRAw5/Bqldv6
8oCZAKCSZ/uHwWnVAeFry6zfN8Y9HnpKQQCbBFUwsvoIGOEqO1YsmIzlR5q2GIA=
=e/MU
-----END PGP SIGNATURE-----

--yQBbXLrz4HQIbUgv--

