Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5FB6CAC599
	for <webhook@archiver.kernel.org>; Wed, 17 Sep 2025 12:59:42 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.web11.22216.1758113975595762811
 for <cip-dev@lists.cip-project.org>;
 Wed, 17 Sep 2025 05:59:36 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=NdjiwRF2;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 255DE1038C113;
	Wed, 17 Sep 2025 14:59:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1758113973; h=from:subject:date:message-id:to:mime-version:content-type;
	bh=sv1yGCgcDszBzwVzTaWi103cxRRS5LdaMRYXUQ+Nfwc=;
	b=NdjiwRF2/++UtrJP9YsjwckQeW59jvlORCtiOCvmIdXa5QB7F20GP9tz+im+EoUxJla0oZ
	UtUtPvghiNpTlyfM3J0AqoXq4D16GDqx6J0xMwc5SKy16XQdABe+3BcQUxtQ1e1BYJs33H
	w0St3tVjr80AJi+j0OtQjEpaSx4hIArO7JexCrRLJGt/i5tadosmt3fte2P7PeFPNmGOsA
	g8SMa9IWFdlOGgz3xL85OlTpjINHXbDeRy1PYl0EdmO6yS6UvSpVfQFvgLdTvrUN0IY71d
	1GMIl5bPnJJnyANrKA+EIQ0hGAuM52Xsd0Fs0oO2vMD72c5cOH+pPnY6dcYqyg==
Date: Wed, 17 Sep 2025 14:59:27 +0200
From: Pavel Machek <pavel@denx.de>
To: jan.kiszka@siemens.com, cip-dev@lists.cip-project.org,
	Chris.Paterson2@renesas.com, nobuhiro1.iwamatsu@toshiba.co.jp
Subject: [ANNOUNCE] v6.1.151-cip46
Message-ID: <aMqwr1VqB/7padmD@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="LoGxfHHWJxUG2o4Q"
Content-Disposition: inline
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 17 Sep 2025 12:59:42 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20079


--LoGxfHHWJxUG2o4Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

New -cip release should be available at kernel.org.

Trees are available at

https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?h=3D=
linux-6.1.y-cip
https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?h=3D=
linux-6.1.y-cip-rebase

And their content should be identical.

There are also tar archives, at:

https://mirrors.edge.kernel.org/pub/linux/kernel/projects/cip/

Best regards,
                                                                Pavel
--=20
In cooperation with DENX Software Engineering GmbH, HRB 165235 Munich,
Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--LoGxfHHWJxUG2o4Q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaMqwrwAKCRAw5/Bqldv6
8t4zAJ9fWlM4WGRe5VEJMsLe6bKi5b24NACfW5ChH8okJli40wqsbRMZfR8Ygu0=
=22Mn
-----END PGP SIGNATURE-----

--LoGxfHHWJxUG2o4Q--

