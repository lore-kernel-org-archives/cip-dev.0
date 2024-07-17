Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE931C3DA4B
	for <webhook@archiver.kernel.org>; Wed, 17 Jul 2024 09:03:43 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web10.11039.1721207015649320741
 for <cip-dev@lists.cip-project.org>;
 Wed, 17 Jul 2024 02:03:35 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 30C381C009C; Wed, 17 Jul 2024 11:03:34 +0200 (CEST)
Date: Wed, 17 Jul 2024 11:03:33 +0200
From: Pavel Machek <pavel@denx.de>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH 6.1.y-cip 00/23] Add PMIC DA9062 support
Message-ID: <ZpeI5YXmFbX1nZyX@duo.ucw.cz>
References: <20240716075641.32177-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="LapVLAHETlh4jFw6"
Content-Disposition: inline
In-Reply-To: <20240716075641.32177-1-biju.das.jz@bp.renesas.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 17 Jul 2024 09:03:43 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16562


--LapVLAHETlh4jFw6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This patch series aims to add PMIC DA9062 support for SMARC RZ/{G2UL,Five}
> EVK platforms.

Thanks, it looks okay to me. Comments from 5.10 will apply, but this
can be applied if it passes testing and there are no other comments.

Best regards,
                                                                Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--LapVLAHETlh4jFw6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZpeI5QAKCRAw5/Bqldv6
8rD0AJ0XUM87TddMOud1k9wnKP7lIxDQ6wCdGpN5Y76dEWjowsKJOpja4GTF/D8=
=4ln1
-----END PGP SIGNATURE-----

--LapVLAHETlh4jFw6--

