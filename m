Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70511CF8873
	for <webhook@archiver.kernel.org>; Sat,  5 Oct 2024 08:14:16 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web10.7673.1728116048483501532
 for <cip-dev@lists.cip-project.org>;
 Sat, 05 Oct 2024 01:14:08 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id BDB6A1C0082; Sat,  5 Oct 2024 10:14:05 +0200 (CEST)
Date: Sat, 5 Oct 2024 10:14:05 +0200
From: Pavel Machek <pavel@denx.de>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH 6.1.y-cip 0/3] Add HDMI audio support
Message-ID: <ZwD1Ta/PRmSy4LcU@duo.ucw.cz>
References: <20241004102326.73157-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="fQqP6Cfr7XLLpRRM"
Content-Disposition: inline
In-Reply-To: <20241004102326.73157-1-biju.das.jz@bp.renesas.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 05 Oct 2024 08:14:16 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17008


--fQqP6Cfr7XLLpRRM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Add HDMI audio support for RZ/{G2L,G2L,V2L} SMARC EVKs
> All the patches are cherry-picked from the mainline.

Thank you, applied.

Best regards,
							Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--fQqP6Cfr7XLLpRRM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZwD1TQAKCRAw5/Bqldv6
8nPDAKC0xfO8VcsZQtIN46P0eI0OFk2iNwCaAgbgeEtlZz3yRC7qGo4BOTwLNqs=
=i8ZB
-----END PGP SIGNATURE-----

--fQqP6Cfr7XLLpRRM--

