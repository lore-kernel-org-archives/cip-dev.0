Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A74ADCE7AB8
	for <webhook@archiver.kernel.org>; Fri,  6 Sep 2024 07:33:03 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web10.29951.1725607975902415757
 for <cip-dev@lists.cip-project.org>;
 Fri, 06 Sep 2024 00:32:56 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 8A4401C009B; Fri,  6 Sep 2024 09:32:53 +0200 (CEST)
Date: Fri, 6 Sep 2024 09:32:53 +0200
From: Pavel Machek <pavel@denx.de>
To: nobuhiro1.iwamatsu@toshiba.co.jp, cip-dev@lists.cip-project.org
Subject: 6.1.107-cip release
Message-ID: <ZtqwJfVY1s49vSdo@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wGa7nQwlfELQ96dR"
Content-Disposition: inline
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 06 Sep 2024 07:33:03 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16856


--wGa7nQwlfELQ96dR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

I took a look at -rt releases, and...

4.19 -- no suitable -rt

v5.10.224-rt116-rc1 -- just wait for release, then do corresponding
-cip.

v6.1.107-rt39 -- can I ask for corresponding -cip, or do the release
myself?

Thanks and best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--wGa7nQwlfELQ96dR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZtqwJQAKCRAw5/Bqldv6
8qumAJ93YTctfsleGviKZp/7R2MkBgPqSwCfUXoxghtEkQ/vIDRUZ11c7WsDVqU=
=OAdb
-----END PGP SIGNATURE-----

--wGa7nQwlfELQ96dR--

