Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A03D4C4828F
	for <webhook@archiver.kernel.org>; Sun,  4 Feb 2024 12:20:58 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web10.37370.1707049249288832458
 for <cip-dev@lists.cip-project.org>;
 Sun, 04 Feb 2024 04:20:49 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 104491C0050; Sun,  4 Feb 2024 13:20:47 +0100 (CET)
Date: Sun, 4 Feb 2024 13:20:46 +0100
From: Pavel Machek <pavel@denx.de>
To: cip-dev@lists.cip-project.org
Cc: jan.kiszka@siemens.com, Chris.Paterson2@renesas.com,
	nobuhiro1.iwamatsu@toshiba.co.jp
Subject: Re: [cip-dev] [ANNOUNCE] 6.1.75-cip14-rt8 (rt23)
Message-ID: <Zb+BHomVksw/FJtW@duo.ucw.cz>
References: <17B0A71DF7AB7000.8798@lists.cip-project.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2wg25Qmnmub2491c"
Content-Disposition: inline
In-Reply-To: <17B0A71DF7AB7000.8798@lists.cip-project.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sun, 04 Feb 2024 12:20:58 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14654


--2wg25Qmnmub2491c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> New realtime trees should be available at kernel.org.
>=20
> Trees are available at
>=20
> https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?h=
=3Dlinux-6.1.y-cip-rt
> https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?h=
=3Dlinux-6.1.y-cip-rt-rebase
>=20
> And their content should be identical.
>=20
> There are also tar archives, at:
>=20
> https://mirrors.edge.kernel.org/pub/linux/kernel/projects/cip/

I managed to push wrong tags at the server. I believe I've undone the
mistake by now, and everything should be okay, but be extra careful
this time.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--2wg25Qmnmub2491c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZb+BHgAKCRAw5/Bqldv6
8oucAJ0ct+CZuCkDnC6Rt3yhnp9DIixQQACgmmschldN3ABugAR22FzgjxFkBi8=
=ZnbY
-----END PGP SIGNATURE-----

--2wg25Qmnmub2491c--

