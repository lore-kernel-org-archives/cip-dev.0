Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3719BC282DE
	for <webhook@archiver.kernel.org>; Thu, 13 Mar 2025 12:35:01 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.web10.13570.1741869296268435872
 for <cip-dev@lists.cip-project.org>;
 Thu, 13 Mar 2025 05:34:56 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=V5XW3q3t;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id DB7E51020999D
	for <cip-dev@lists.cip-project.org>; Thu, 13 Mar 2025 13:34:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1741869294; h=from:subject:date:message-id:to:mime-version:content-type;
	bh=tglDkfR1+kAF4CFTFJY9FaoyLUiMIwKv4JFZ0tRzR1o=;
	b=V5XW3q3tQW661EFaM6JTYNS0daWzkKyzhogVl6+wc7M0vdMOX4EiW+Eim11QlIpdGGv16H
	te3fAIi7w0Kk+BOUp6Yp/x31zAv760FLdeAvLOHxqJfI0XKPh/VR1iz4ughd700+BEbtrW
	e/6aTuUIwsQjrKxsTtq8dcj88nfPGGO66geLXYFnO/21HmPy1jErHIta5t4g6WH3FtNXAD
	+T2mzi61OorA3rlqUl8DrbLJsc5qmoAM07AzL6kzPX73wUxWCR92GBXKV+PybW94531ASd
	PfYDIbGzIY68pnbvyRlpGJLGv01K7LcRkeiJQ4VpA7ez+swzHqRyaKTieRAuAg==
Date: Thu, 13 Mar 2025 13:34:50 +0100
From: Pavel Machek <pavel@denx.de>
To: cip-dev@lists.cip-project.org
Subject: Mailing list inventing addresses for people
Message-ID: <Z9LQ6u3m4LRFTCPM@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="EYAXBkuwwGG2lwNR"
Content-Disposition: inline
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 13 Mar 2025 12:35:01 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18189


--EYAXBkuwwGG2lwNR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

Mailing list is doing something ugly with From: addresses. I'm sending
this email from @denx.de account, but it will forge From address to be
something else. Why is it doing that and who can fix it?

It is annoying as it will break signatures, and it makes communication
difficult. Plus, it forged my email address and invented fake one.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--EYAXBkuwwGG2lwNR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZ9LQ6gAKCRAw5/Bqldv6
8mEWAKCVlqNQIxunCU4IM8JNi6SYCUulvQCgsnHnXgMWmgKdmwz0Dl58Dqmb/78=
=bxLB
-----END PGP SIGNATURE-----

--EYAXBkuwwGG2lwNR--

