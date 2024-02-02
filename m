Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8660BC47DB3
	for <webhook@archiver.kernel.org>; Fri,  2 Feb 2024 11:47:28 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web11.20823.1706874443368793347
 for <cip-dev@lists.cip-project.org>;
 Fri, 02 Feb 2024 03:47:23 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id BE7451C0075; Fri,  2 Feb 2024 12:47:21 +0100 (CET)
Date: Fri, 2 Feb 2024 12:47:21 +0100
From: Pavel Machek <pavel@denx.de>
To: cip-dev@lists.cip-project.org
Cc: nobuhiro1.iwamatsu@toshiba.co.jp
Subject: 5.10/6.1-cip was Re: [cip-dev] 6.1.75-cip-rt
Message-ID: <ZbzWSRdxVGZLSQ32@duo.ucw.cz>
References: <17AF367A08806988.24874@lists.cip-project.org>
 <17AF81A441E06ADF.11150@lists.cip-project.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Di4uGxImy6Zjwulr"
Content-Disposition: inline
In-Reply-To: <17AF81A441E06ADF.11150@lists.cip-project.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 02 Feb 2024 11:47:28 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14623


--Di4uGxImy6Zjwulr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > 6.1.75-rt is out, could I ask for 6.1.75-cip?
>=20
> And v5.10.209-cip... It looks like v5.10.209-rt101-rc1 is going to be
> out "soon".

If it would help, I believe I can do 6.1.75-cip and 5.10.209-cip
releases. I need them for -rt releases.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--Di4uGxImy6Zjwulr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZbzWSQAKCRAw5/Bqldv6
8uotAJ95/hb3dR935x7wCiakzSMfviMxdwCeKUaO3RYrk22bTYjS5w9vMCkvUkI=
=wU0N
-----END PGP SIGNATURE-----

--Di4uGxImy6Zjwulr--

