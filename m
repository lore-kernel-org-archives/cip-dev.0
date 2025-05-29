Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F206C54FB3
	for <webhook@archiver.kernel.org>; Thu, 29 May 2025 08:52:15 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.web10.16405.1748508730655108325
 for <cip-dev@lists.cip-project.org>;
 Thu, 29 May 2025 01:52:11 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=Zo0hNRFu;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B4C29103972A5
	for <cip-dev@lists.cip-project.org>; Thu, 29 May 2025 10:52:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1748508728; h=from:subject:date:message-id:to:mime-version:content-type;
	bh=j/nnqrBAnFPFFr05VMtcOJgeE7VXRx8GJ3BJUCYuQsU=;
	b=Zo0hNRFudDE2eyOXq+qhIqkHhBnCkc1W/CIUSdOf9tYBgiQ+9/uTaSsaZO00OOKnkMZcwh
	O7+47WXiTYSlTq2KXaSNGYSv4xHaDk/C8Km/XXAjm8O1UzLHzERtjmrfZBrrq4YPrSpnOe
	CBUZTodZJIHVY3TGQL0vNbBK91QQWK6hvsTXm2fLm2B8C95tIA895wlwRKJVTdfrtSDvj6
	JDfubxmisOcV2i/uJjpjTJpYBAyQs1dnAX9Mqxs9uM4pMM2QoupLbVTnK2Y9+JjumfcTiM
	ipAxp64xEtlDPqo7zge1OGhPCUBJz3HRChS6FleijVmpwB1MOzJR96BdW6PxXA==
Date: Thu, 29 May 2025 10:52:04 +0200
From: Pavel Machek <pavel@denx.de>
To: cip-dev@lists.cip-project.org
Subject: CIP IRC weekly meeting today on libera.chat
Message-ID: <aDggNAAp1mnSfQja@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="YcmuXlTbsAsEWwy4"
Content-Disposition: inline
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 29 May 2025 08:52:15 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18957


--YcmuXlTbsAsEWwy4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi all,

Kindly be reminded to attend the weekly meeting through IRC to discuss
technical topics with CIP kernel today. Our channel is the following:

    irc:irc.libera.chat:6667/cip

The IRC meeting is scheduled to UTC (GMT) 13:00, or in about 4 hours.

Last meeting minutes:
https://ircbot.wl.linuxfoundation.org/meetings/cip/2025/05/cip.2025-05-22-1=
3.01.log.html

* Action items
* Kernel maintenance updates
* Kernel release status [*]
* Kernel testing
* AOB

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--YcmuXlTbsAsEWwy4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaDggNAAKCRAw5/Bqldv6
8k9vAKDAcMGYW5An6mlVdjBAjbgFgPqHQwCgl3Q5pUxol98aZlmkWiczamAHsAk=
=D9Qc
-----END PGP SIGNATURE-----

--YcmuXlTbsAsEWwy4--

