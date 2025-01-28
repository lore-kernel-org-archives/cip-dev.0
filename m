Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 200EBC0218A
	for <webhook@archiver.kernel.org>; Tue, 28 Jan 2025 21:39:00 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.web10.8975.1738100334490400447
 for <cip-dev@lists.cip-project.org>;
 Tue, 28 Jan 2025 13:38:54 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=LHoGBCxw;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 4A12E10382D08;
	Tue, 28 Jan 2025 22:38:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1738100332;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type;
	bh=bMVW6qgC/vPgESrwL3BnwLe/GwxLWYYIiuQnqppsW5k=;
	b=LHoGBCxwzKiW+YrD5yUyiVf9npXs3X2252DzvUh6SK0NBl+2HoaAwSUEN1MLqBCttgpRuZ
	/8AS2RGaeCWMJin3t4LYugYq9Q+MzTNM34zlwQFST/sC0+RyqLzf28g4t5TkgK4ChFnrPC
	Xu1EvNnBSJ8qZu7XNn/6wbplvrHVKe7RXt1b7RaigieMvPlN3UfGm4cZo9MJmrzXxdmWIl
	i3xvbrzTux1BwDJiOFgnmmbyB2vMGQ+OwGXDikcVzwZL8nxXzXswpA4tluQY27JbfGS28H
	c6WmusSCPLKOM3BVfVLmZwYt3Rs6pvwrZAofqpG2EIAZxCi5IglL3kxHB9YLVA==
Date: Tue, 28 Jan 2025 22:38:48 +0100
From: Pavel Machek <pavel@denx.de>
To: cip-dev@lists.cip-project.org, nobuhiro1.iwamatsu@toshiba.co.jp
Subject: 6.1.127-rt48, corresponding -cip.
Message-ID: <Z5lOaPm5I/7AFDZU@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6EMNVUKMpvZHe6E6"
Content-Disposition: inline
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 28 Jan 2025 21:39:00 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17674


--6EMNVUKMpvZHe6E6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

6.1.127-rt48 was released. I plan to do 6.1.127-cip release and then
-cip-rt, unless someone tells me otherwise.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--6EMNVUKMpvZHe6E6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZ5lOaAAKCRAw5/Bqldv6
8i/SAJ9LvsYky9drpwTsRRtbqamwsskjlgCffJszbEh3QEnIGqkO/IVD57xTxkU=
=ERTZ
-----END PGP SIGNATURE-----

--6EMNVUKMpvZHe6E6--

