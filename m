Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7F6FC47258
	for <webhook@archiver.kernel.org>; Wed, 31 Jan 2024 09:58:06 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web10.10687.1706695085203702819
 for <cip-dev@lists.cip-project.org>;
 Wed, 31 Jan 2024 01:58:05 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 5041A1C0079; Wed, 31 Jan 2024 10:58:03 +0100 (CET)
Date: Wed, 31 Jan 2024 10:58:02 +0100
From: Pavel Machek <pavel@denx.de>
To: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>, Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [PATCH 5.10.y-cip 0/9] Update SSI interrupts for RZ/G2L family
 and Split out RZ/G2UL DTS/I
Message-ID: <ZboZqpdu5x6aEohp@duo.ucw.cz>
References: <20240130161555.85042-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="X8CU16ZiT5Zn8UGQ"
Content-Disposition: inline
In-Reply-To: <20240130161555.85042-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 31 Jan 2024 09:58:06 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14553


--X8CU16ZiT5Zn8UGQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This patch series does the below,
> - Updates SSI interrupts for RZ/G2L family
> - Splits up RZ/G2UL DTS/I for re-using for RZ/Five SoC
>=20
> Note, patch #5 has been newly added and rest of the patches have been
> cherry-picked from upstream kernel.

I'll take more detailed look but just to be sure: do you plan to
backport RISC-V changes to 5.10? If so, do you have some kind of WIP
series, just to get an idea how big changes that means?

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--X8CU16ZiT5Zn8UGQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZboZqgAKCRAw5/Bqldv6
8qQsAJ48364Y2qXP01j0fuS33hBaGE+Z1QCgqBQfScFFKB/AInxBD7nfJVSrkU0=
=Vp0u
-----END PGP SIGNATURE-----

--X8CU16ZiT5Zn8UGQ--

