Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50891C4332F
	for <webhook@archiver.kernel.org>; Wed, 13 Dec 2023 08:20:21 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web11.31438.1702455610557937545
 for <cip-dev@lists.cip-project.org>;
 Wed, 13 Dec 2023 00:20:11 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id E53C81C006F; Wed, 13 Dec 2023 09:20:07 +0100 (CET)
Date: Wed, 13 Dec 2023 09:20:07 +0100
From: Pavel Machek <pavel@denx.de>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH 00/14] Add Mali-G31 GPU support for RZ/G2L SoC
Message-ID: <ZXlpN+5ODcVIfZj3@duo.ucw.cz>
References: <20231212124035.151367-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wQ9MAR5Wn113tzvU"
Content-Disposition: inline
In-Reply-To: <20231212124035.151367-1-biju.das.jz@bp.renesas.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 13 Dec 2023 08:20:21 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14060


--wQ9MAR5Wn113tzvU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> RZ/G2L SoC embeds Mali-G31 bifrost GPU.
> This patch series aims to add support for the same.
>=20
> Please don't apply patch#7 to patch#14as it is added for testing purpose.
>=20
> It is tested with 5.10.y-cip + out of tree patch for (DU) + [1]

I reviewed series, and the parts you want applied are really quite
simple. I can apply them if there are no other comments (and provided
tests pass).

Best regards,
          	       	    	       	     	     	       	    Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--wQ9MAR5Wn113tzvU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZXlpNwAKCRAw5/Bqldv6
8um/AKC+gogyJX9Te62OGJr0Nq2zvL/icgCglXydi0Jl1+uqnZFOnX3KORHKoEQ=
=3/xe
-----END PGP SIGNATURE-----

--wQ9MAR5Wn113tzvU--

