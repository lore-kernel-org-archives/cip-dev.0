Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EA7BC433F5
	for <webhook@archiver.kernel.org>; Wed, 15 Dec 2021 10:06:06 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web11.38454.1639562764792363865
 for <cip-dev@lists.cip-project.org>;
 Wed, 15 Dec 2021 02:06:05 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 2F26A1C0B96; Wed, 15 Dec 2021 11:05:54 +0100 (CET)
Date: Wed, 15 Dec 2021 11:05:37 +0100
From: Pavel Machek <pavel@denx.de>
To: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>, Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [PATCH 5.10.y-cip 0/7] Add binding and SoC identification for
 Renesas RZ/G2L SoC and Renesas RZ/G2L SMARC EVK
Message-ID: <20211215100537.GA18047@amd>
References: <20211215004612.13289-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3V7upXqbjpZ4EhLz"
Content-Disposition: inline
In-Reply-To: <20211215004612.13289-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 15 Dec 2021 10:06:06 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7108


--3V7upXqbjpZ4EhLz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This patch series adds initial support for Renesas RZ/G2L SoC [0] and
> Renesas RZ/G2L SMARC EVK [1].
>=20
> The RZ/G2L microprocessor includes a Cortex-A55 (1.2 GHz) CPU, 16-bit
> DDR3L/DDR4 interface, 3D graphics engine with Arm Mali-G31 and video codec
> (H.264). It also has many interfaces such as camera input, display output,
> USB 2.0, and Gbit-Ether, making it ideal for applications such as
> entry-class industrial human-machine interfaces (HMIs) and embedded devic=
es
> with video capabilities.

I have reviewed patches and they look okay to me. I'll proceed with
testing.

Do we have suitable board in the test lab / is there plan to add one?

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--3V7upXqbjpZ4EhLz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAmG5vfAACgkQMOfwapXb+vIfcwCaA/aQSoDff50jLb6UooGj7fr6
V/oAnj6hQc52jdEyxXcuNM/i11h57wLQ
=vy2w
-----END PGP SIGNATURE-----

--3V7upXqbjpZ4EhLz--

