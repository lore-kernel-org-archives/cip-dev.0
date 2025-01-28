Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 344D6C0218A
	for <webhook@archiver.kernel.org>; Tue, 28 Jan 2025 21:26:40 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.web10.8665.1738099595667764960
 for <cip-dev@lists.cip-project.org>;
 Tue, 28 Jan 2025 13:26:36 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=V4caky/o;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id EE4EA10382D08;
	Tue, 28 Jan 2025 22:26:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1738099593;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type;
	bh=lT1KRotfxxyxdaZ1nz8RdE88Uo93bIit/urNKp9Zomc=;
	b=V4caky/o7oxH6b+u+B2gLW8/oDOTe1eW9YU9jtzaQidEbd+qaVi6Z90a5ijBLcNq528Cqp
	MsazO+B+rfnL1KF/FRkllHWmhzmS1wtSzshcbprQW1+yHGwfEfAeMpjPNV9cHz3eJUbr9Q
	X55bBxD4Mc0uuNpGTxnzlecvzFx4mzOr844FEY/p/9xKy6FAxSuyWZ713Bq2HLA/b42m5W
	PtyCC3d09+5I34dM/C1DhaBnu1oi8Lkyoqb9AqqkMzwc/VE/O+GagAI9jt48eJnFRTEEX8
	iM+r6J75OsEbQ9Ul8tHlUyhRkBFKJjIhymSGFYjjhuvcWxQ39CSMWjsrRxkBvw==
Date: Tue, 28 Jan 2025 22:26:27 +0100
From: Pavel Machek <pavel@denx.de>
To: jan.kiszka@siemens.com, cip-dev@lists.cip-project.org,
	Chris.Paterson2@renesas.com
Subject: [ANNOUNCE] v5.10.233-cip56-rt24 (rt125)
Message-ID: <Z5lLg/sr8tdbQwFV@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PrqMoeCc8ygWHFFB"
Content-Disposition: inline
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 28 Jan 2025 21:26:40 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17673


--PrqMoeCc8ygWHFFB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

New realtime trees should be available at kernel.org.

Trees are available at

https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?h=3D=
linux-5.10.y-cip-rt
https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?h=3D=
linux-5.10.y-cip-rt-rebase

And their content should be identical. There are also tar archives, at:

https://mirrors.edge.kernel.org/pub/linux/kernel/projects/cip/

Best regards,
                                                                Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--PrqMoeCc8ygWHFFB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZ5lLgwAKCRAw5/Bqldv6
8nCdAKCn1I1iHwNsDv5aCDRI1CqEiRCxGQCfS+bWj5uYbra/0RTAJy7We9fViHw=
=YNnW
-----END PGP SIGNATURE-----

--PrqMoeCc8ygWHFFB--

