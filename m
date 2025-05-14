Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8A2EC3ABDA
	for <webhook@archiver.kernel.org>; Wed, 14 May 2025 07:59:48 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.web11.97112.1747209578301038097
 for <cip-dev@lists.cip-project.org>;
 Wed, 14 May 2025 00:59:38 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=YDucOizp;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E826A101F54F9;
	Wed, 14 May 2025 09:59:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1747209576; h=from:subject:date:message-id:to:mime-version:content-type;
	bh=jO8n645pmk9Yh8ICg891QivtC0yeCXswgvwiwltFIbE=;
	b=YDucOizpN+ToAt3tP3sl3iLhABsPGUYl2cyY9igFUan2DRjNcWI2+bkp68uB7VSLhvJcZA
	6NsyablFVyl/VAqtxA8lObXbp5e1tHGsF53wkOV9GjyhMfhZbCgOEiRUuMbgHn7ZsyZ2ju
	Q6cFNzO5SpJWOdNmgFIA9SvG7WCKfVu7HJbOwETr6ElhfzDCjNjU/o8jXVBtHz4lEsQ1vB
	W8Mh5ZucPeq0+C98v3y0NgE5sIikW5fXprCMKdrPhvHU2/MzGLrc6qITFxOHhVd/zXU4yL
	hdOb9R7+7nHP93nax1but7v6ReaLVoUCT6/81aIeqYwomWCoyY1b0AmfLnS6jg==
Date: Wed, 14 May 2025 09:59:30 +0200
From: Pavel Machek <pavel@denx.de>
To: nobuhiro1.iwamatsu@toshiba.co.jp, cip-dev@lists.cip-project.org
Subject: 5.10.237-cip release
Message-ID: <aCRNYn3zxpNa9LzA@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="85+ViPSwD31/17x5"
Content-Disposition: inline
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 14 May 2025 07:59:48 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18902


--85+ViPSwD31/17x5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

5.10-cip-rt release is due soon, and 5.10.237-rt131 is available, so
5.10.237-cip release would be useful for me.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--85+ViPSwD31/17x5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaCRNYgAKCRAw5/Bqldv6
8t6aAJ0c1WijINKYslOPS/TuUzFPIGEkdgCggUlVTUMAXIMYQmvYTEuo+iB+bAY=
=i1DR
-----END PGP SIGNATURE-----

--85+ViPSwD31/17x5--

