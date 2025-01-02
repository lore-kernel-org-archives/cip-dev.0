Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC77BE77188
	for <webhook@archiver.kernel.org>; Thu,  2 Jan 2025 12:09:38 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.web11.6633.1735819770536015297
 for <cip-dev@lists.cip-project.org>;
 Thu, 02 Jan 2025 04:09:30 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=Ih9bJEHw;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 2E51B104811CB
	for <cip-dev@lists.cip-project.org>; Thu,  2 Jan 2025 13:09:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1735819768;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type;
	bh=1uAJVuQ+T/IOYiuUg1jljuKNzOlt+g/jLtdQv340Qb8=;
	b=Ih9bJEHwZqYB68Owc/J7ov/lljqajxBNlBvxaHpb0ZBm5ynwejvb+jNNU4us0PCOzAi2EF
	pfDE4lDqFuWXbzHpy6RZs5fXBdCVVzs49D2cYe6wK3I964hQebeE21m3CC87j6EY3GZ+qj
	MP1GS3KxP3+gctS8WyC+DU6GX/c9FTsbX3doC1TY4NYtCtAQIHkbbpOKFTjebzkAF4z5aP
	c7HDvFmOMqzmDkv3+jTXgdpBY796dR7v7j0hAI3OU9talQeSy0WiXbYY2aK9AaLmoTK4rI
	wZW9OJdo+NSRCq58jgv5vNfB4fqepNioQnsmF7S3vtxt45RkSJm28kAtUS4KEA==
Date: Thu, 2 Jan 2025 13:09:25 +0100
From: Pavel Machek <pavel@denx.de>
To: cip-dev@lists.cip-project.org
Subject: CIP IRC weekly meeting today on libera.chat (in 50 minutes)
Message-ID: <Z3aB9VeF3D/UPId6@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Nxx/TNFf0u8P0G7z"
Content-Disposition: inline
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 02 Jan 2025 12:09:38 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17501


--Nxx/TNFf0u8P0G7z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi all,

Kindly be reminded to attend the weekly meeting through IRC to discuss
technical topics with CIP kernel today. Our channel is the following:

    irc:irc.libera.chat:6667/cip

The IRC meeting is scheduled to UTC (GMT) 13:00 (in 50 minutes).

Last meeting minutes:
https://ircbot.wl.linuxfoundation.org/meetings/cip/2024/12/cip.2024-12-26-1=
3.02.log.html

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--Nxx/TNFf0u8P0G7z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZ3aB9QAKCRAw5/Bqldv6
8rc2AKCcWE4Y7Az2PpRc4UOb8N5IQ4A+cACgprZpT0X7TNRZxIqY/Yv8M1Nq6yk=
=V2DB
-----END PGP SIGNATURE-----

--Nxx/TNFf0u8P0G7z--

