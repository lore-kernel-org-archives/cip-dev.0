Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E724EB64D9
	for <webhook@archiver.kernel.org>; Mon, 19 Jun 2023 21:31:46 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web11.19649.1687210303568680639
 for <cip-dev@lists.cip-project.org>;
 Mon, 19 Jun 2023 14:31:44 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id B6AE91C0CA9; Mon, 19 Jun 2023 23:31:40 +0200 (CEST)
Date: Mon, 19 Jun 2023 23:31:40 +0200
From: Pavel Machek <pavel@denx.de>
To: iwamatsu@nigauri.org, cip-dev@lists.cip-project.org
Subject: v5.10.184 based -cip release?
Message-ID: <ZJDJPH2l/CgrP5XW@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="KjjxrfzOw4p20Oam"
Content-Disposition: inline
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 19 Jun 2023 21:31:46 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12082


--KjjxrfzOw4p20Oam
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

Could I ask for v5.10.184 based release? It would make -cip-rt relase
easier.

Thanks and best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--KjjxrfzOw4p20Oam
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZJDJPAAKCRAw5/Bqldv6
8hzaAJ9qmU89kb7L7b9vZlQ2BBZdnCSLiwCgqhMA3xCr1qK73QMWT5ajQnpKlTs=
=cDAJ
-----END PGP SIGNATURE-----

--KjjxrfzOw4p20Oam--

