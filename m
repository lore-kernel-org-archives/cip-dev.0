Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98FC8C48292
	for <webhook@archiver.kernel.org>; Mon,  5 Feb 2024 18:22:18 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web11.1357.1707157329907542884
 for <cip-dev@lists.cip-project.org>;
 Mon, 05 Feb 2024 10:22:10 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id B1E591C0050; Mon,  5 Feb 2024 19:22:07 +0100 (CET)
Date: Mon, 5 Feb 2024 19:22:07 +0100
From: Pavel Machek <pavel@denx.de>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH 5.10.y-cip 0/6] Versa3 clk driver improvements
Message-ID: <ZcEnT/HpU/35UyZP@duo.ucw.cz>
References: <20240202122338.309435-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="hxV3XQCIs6A5df8N"
Content-Disposition: inline
In-Reply-To: <20240202122338.309435-1-biju.das.jz@bp.renesas.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 05 Feb 2024 18:22:18 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14754


--hxV3XQCIs6A5df8N
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This patch series aims to improve versa3 clock driver.
>=20
> All the patches are cherry-picked from the mainline.

Series looks ok to me, I can apply it if it passes testing and if
there are no other comments.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--hxV3XQCIs6A5df8N
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZcEnTwAKCRAw5/Bqldv6
8pfDAKC3FS7hTuqKpwntTHyXUHk6HZNxiwCfTZbeN6ppSzgo6mj1+ChX++dAYwM=
=XH0O
-----END PGP SIGNATURE-----

--hxV3XQCIs6A5df8N--

