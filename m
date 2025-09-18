Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC1ECCAC597
	for <webhook@archiver.kernel.org>; Thu, 18 Sep 2025 19:08:55 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.web11.24089.1758222532327627959
 for <cip-dev@lists.cip-project.org>;
 Thu, 18 Sep 2025 12:08:52 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=XX2Tcofm;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 9C5241038C115;
	Thu, 18 Sep 2025 21:08:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1758222530; h=from:subject:date:message-id:to:mime-version:content-type;
	bh=ysLilsX3oh+/Rd8bJF9ezuTAyw9POz8V8TfvckU/pGc=;
	b=XX2TcofmZQR/oqoGepuEaNepkQDEwSX4MysJLaXc1JA83dd+9tUEpH99WqdHCPhxgTKnji
	vCp1tvRyfzHhtJ5MkZAYuYJRIx+Hg5kJiS/rJG6FxCWQlQk9clrXvySNQhXV5QJWGUKFIg
	YZRyUcG8S505Br26wFirqb6WVHzNmcVAQbDpImIFIaQ13gfnLpqDCKZQUAUwk2DrajAHM0
	ftu+jg5rPk3bQSTW58c1h+kyP1jr7+lNq68l27/JLBow3GCRZYxE0SD5MKwackL5wtCZY0
	aTlz3ru4nQu2ErGc0ry+YaqeUbuq/5pRXXTRvy4tbjosHQqFODNf2Yha2+pMsQ==
Date: Thu, 18 Sep 2025 21:08:45 +0200
From: Pavel Machek <pavel@denx.de>
To: jan.kiszka@siemens.com, cip-dev@lists.cip-project.org,
	Chris.Paterson2@renesas.com
Subject: [ANNOUNCE] v6.1.151-cip46-rt24 (rt54)
Message-ID: <aMxYvbS6cyITwsiG@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="F9t0eV9GCKeta+Z5"
Content-Disposition: inline
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 18 Sep 2025 19:08:55 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20086


--F9t0eV9GCKeta+Z5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

New realtime trees should be available at kernel.org.

Trees are available at

https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?h=3D=
linux-6.1.y-cip-rt
https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?h=3D=
linux-6.1.y-cip-rt-rebase

And their content should be identical. There are also tar archives, at:

https://mirrors.edge.kernel.org/pub/linux/kernel/projects/cip/

Best regards,
                                                                Pavel
--=20
In cooperation with DENX Software Engineering GmbH, HRB 165235 Munich,
Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--F9t0eV9GCKeta+Z5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaMxYvQAKCRAw5/Bqldv6
8tqHAJ4jINuHWBH41VzA5AaQ8GVrHxb8jACdFPm1Gi0g2VBQ0fUN2Khv9OQ+WFk=
=vzit
-----END PGP SIGNATURE-----

--F9t0eV9GCKeta+Z5--

