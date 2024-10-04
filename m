Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F1B5CF884C
	for <webhook@archiver.kernel.org>; Fri,  4 Oct 2024 15:48:45 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web11.25640.1728056915838384742
 for <cip-dev@lists.cip-project.org>;
 Fri, 04 Oct 2024 08:48:36 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id A7F721C0082; Fri,  4 Oct 2024 17:48:32 +0200 (CEST)
Date: Fri, 4 Oct 2024 17:48:32 +0200
From: Pavel Machek <pavel@denx.de>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH 6.1.y-cip 00/16] Full duplex audio + RZ/G2UL DU support
Message-ID: <ZwAOUExFGjjAW6Tn@duo.ucw.cz>
References: <20241002170417.655339-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5h31ozGQdPYf+Nz/"
Content-Disposition: inline
In-Reply-To: <20241002170417.655339-1-biju.das.jz@bp.renesas.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 04 Oct 2024 15:48:45 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17006


--5h31ozGQdPYf+Nz/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This patch series aim to add support for
> 1) RZ/G2UL display
> 2) Audio full duplex
> 3) Auto loading for CSI driver
>=20
> All the patches are cherry-picked from the mainline

Thank you. Applied, with exception of "02/16 pinctrl: renesas: rzg2l:
Use dev_err_probe()".

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--5h31ozGQdPYf+Nz/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZwAOUAAKCRAw5/Bqldv6
8v8bAJ9e+8beN4RqIHVEWmpakdo3g7UqVgCdHbH8ts/0LYzE33lzRnNM1kTE764=
=1EPl
-----END PGP SIGNATURE-----

--5h31ozGQdPYf+Nz/--

