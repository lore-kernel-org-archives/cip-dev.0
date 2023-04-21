Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D803C77B75
	for <webhook@archiver.kernel.org>; Fri, 21 Apr 2023 10:55:11 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web10.8554.1682074501659847089
 for <cip-dev@lists.cip-project.org>;
 Fri, 21 Apr 2023 03:55:02 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 3119D1C0DED; Fri, 21 Apr 2023 12:54:58 +0200 (CEST)
Date: Fri, 21 Apr 2023 12:54:57 +0200
From: Pavel Machek <pavel@denx.de>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>,
	Chris Paterson <chris.paterson2@renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Subject: Re: [PATCH 5.10.y-cip 00/33] Add RZ/V2M support
Message-ID: <ZEJrgRY3NwUu3j7D@duo.ucw.cz>
References: <20230421071729.130347-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="MDF/1olOtkgHVkFQ"
Content-Disposition: inline
In-Reply-To: <20230421071729.130347-1-biju.das.jz@bp.renesas.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 21 Apr 2023 10:55:11 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11308


--MDF/1olOtkgHVkFQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> All these patches are cherry-picked from the mainline.

Ok. Well likely need to backport these to 6.1.X, too, but I suppose
that will not be hard.

I went through the patches and submitted them to testing. I can apply
them if there are no other comments.

Thank you and best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--MDF/1olOtkgHVkFQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZEJrgQAKCRAw5/Bqldv6
8iU8AJ966bVqoDdVfPNS1n5UjZQxeYDiJgCfXgf+ZDoYVMLt7xbFzd9uVoben5g=
=1iD9
-----END PGP SIGNATURE-----

--MDF/1olOtkgHVkFQ--

