Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 807F6C3DA61
	for <webhook@archiver.kernel.org>; Wed, 24 Jul 2024 17:40:21 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web10.17012.1721842820055137349
 for <cip-dev@lists.cip-project.org>;
 Wed, 24 Jul 2024 10:40:20 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 080C61C009D; Wed, 24 Jul 2024 19:40:17 +0200 (CEST)
Date: Wed, 24 Jul 2024 19:40:16 +0200
From: Pavel Machek <pavel@denx.de>
To: Paul Barker <paul.barker.ct@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>, Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH 6.1.y-cip 00/11] Backport ravb driver improvements
Message-ID: <ZqE8gLGPCc93dZFz@duo.ucw.cz>
References: <20240724080046.1500825-1-paul.barker.ct@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bqx9JyTCOeZfKtdS"
Content-Disposition: inline
In-Reply-To: <20240724080046.1500825-1-paul.barker.ct@bp.renesas.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 24 Jul 2024 17:40:21 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16614


--bqx9JyTCOeZfKtdS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This series includes all relevant fixes, tidy-ups and other improvements
> to the ravb driver present in Linux v6.10. Backporting these patches is
> a prerequisite so that we can backport the GbEth performance improvement
> patches which will be included in Linux v6.11 [1].

Series looks good, so I can apply it if it passes testing and there
are no other comments.

I see extra blank lines before final sign-off. That's unusual/wrong, but I
can remove them while applying.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--bqx9JyTCOeZfKtdS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZqE8gAAKCRAw5/Bqldv6
8qg2AJ9k+wXLB45UeZ6mRW9NhLY+y59TpQCgq1J7ckmGyAdb/M1O6aFPouks/Ks=
=BLe+
-----END PGP SIGNATURE-----

--bqx9JyTCOeZfKtdS--

