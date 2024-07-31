Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 957B2C3DA64
	for <webhook@archiver.kernel.org>; Wed, 31 Jul 2024 07:59:36 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web11.38175.1722412767841198867
 for <cip-dev@lists.cip-project.org>;
 Wed, 31 Jul 2024 00:59:28 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 72E6E1C0082; Wed, 31 Jul 2024 09:59:25 +0200 (CEST)
Date: Wed, 31 Jul 2024 09:59:24 +0200
From: Pavel Machek <pavel@denx.de>
To: Paul Barker <paul.barker.ct@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>, Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH 5.10.y cip 00/11] Backport ravb driver improvements
Message-ID: <Zqnu3HiQm0CWX8wF@duo.ucw.cz>
References: <20240729143011.1920068-1-paul.barker.ct@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4ntcT6R5l2Ke+1Qr"
Content-Disposition: inline
In-Reply-To: <20240729143011.1920068-1-paul.barker.ct@bp.renesas.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 31 Jul 2024 07:59:36 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16692


--4ntcT6R5l2Ke+1Qr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This series includes all relevant fixes, tidy-ups and other improvements
> to the ravb driver present in Linux v6.10. This keeps the CIP 5.10
> series aligned with the backports made for CIP 6.1.

I can apply this if it passes testing and there are no other comments.

Best regards,
                                                                Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--4ntcT6R5l2Ke+1Qr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZqnu3AAKCRAw5/Bqldv6
8smfAKC9QcmHXQcEDZdET6gQXfxrDDYpZwCfZ6qd9RX9RQg5j6WfIk6nu5PLVT4=
=HDaN
-----END PGP SIGNATURE-----

--4ntcT6R5l2Ke+1Qr--

