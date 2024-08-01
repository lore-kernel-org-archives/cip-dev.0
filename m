Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CE6EC3DA4A
	for <webhook@archiver.kernel.org>; Thu,  1 Aug 2024 11:26:16 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web11.65849.1722511571530970014
 for <cip-dev@lists.cip-project.org>;
 Thu, 01 Aug 2024 04:26:11 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 2F2BD1C008E; Thu,  1 Aug 2024 13:26:08 +0200 (CEST)
Date: Thu, 1 Aug 2024 13:26:07 +0200
From: Pavel Machek <pavel@denx.de>
To: Pavel Machek <pavel@denx.de>
Cc: Paul Barker <paul.barker.ct@bp.renesas.com>,
	cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH 5.10.y cip 00/11] Backport ravb driver improvements
Message-ID: <Zqtwz8npuO9aU4V1@duo.ucw.cz>
References: <20240729143011.1920068-1-paul.barker.ct@bp.renesas.com>
 <Zqnu3HiQm0CWX8wF@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="YTsJSMJMwZJ+E1L6"
Content-Disposition: inline
In-Reply-To: <Zqnu3HiQm0CWX8wF@duo.ucw.cz>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 01 Aug 2024 11:26:16 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16703


--YTsJSMJMwZJ+E1L6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > This series includes all relevant fixes, tidy-ups and other improvements
> > to the ravb driver present in Linux v6.10. This keeps the CIP 5.10
> > series aligned with the backports made for CIP 6.1.
>=20
> I can apply this if it passes testing and there are no other
> comments.

Thank you, applied.

Best regards,
                                                                Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--YTsJSMJMwZJ+E1L6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZqtwzwAKCRAw5/Bqldv6
8m9UAJ9C86nRdgzUaaWs3bGTN+mq7citzwCgw8tbs2XcL+2ANrvX09WZc3DOdig=
=ic+5
-----END PGP SIGNATURE-----

--YTsJSMJMwZJ+E1L6--

