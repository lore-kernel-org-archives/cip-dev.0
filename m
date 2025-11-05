Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C4CACCFA05
	for <webhook@archiver.kernel.org>; Wed,  5 Nov 2025 12:18:46 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.8160.1762345120291892807
 for <cip-dev@lists.cip-project.org>;
 Wed, 05 Nov 2025 04:18:40 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=WVVStxfG;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id ED895103CF29C
	for <cip-dev@lists.cip-project.org>; Wed,  5 Nov 2025 13:18:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1762345118; h=from:subject:date:message-id:to:mime-version:content-type;
	bh=vt8I8OGetxNZJgfCoLHdcbL0S0eUVOia6qOX+8aff8E=;
	b=WVVStxfG/T0w+ZgdOjaqsKX6EeNPGnHi1bF+PFp2hcVmF09QLgZjxnn8KGOqoKv1oqAsYC
	eilYvKrUqvfv2CPYh3pCNCrF4fNq8kTqOQXMOpIAZg/+DUZnq2hpt1iiOlRInkrh3F7QXE
	Z61YhBHVhXcLGVY7sh2N5eyVHLJwL2UoG+Z4blURUA4LsEiaNGVdXYJYzFzU22ZjunGqFT
	V72+pteM4RA1aozDICBiHC64ZutAVjfyriPmb0Qg+GJQ1Xs4gYwWvWHlhWl8v0CdELU/eU
	PFF6oGXBtgGrU6rXSIYoMr86Ubm/Y47qf9+O6Rn1LGOKvao7VPEUmF70IjDGBw==
Date: Wed, 5 Nov 2025 13:18:35 +0100
From: Pavel Machek <pavel@denx.de>
To: cip-dev@lists.cip-project.org
Subject: -rt plans: 6.1.157-rt57 based -cip-rt release
Message-ID: <aQtAm6KXR14NK1qU@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="JUNJXoXLXhv87spZ"
Content-Disposition: inline
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 05 Nov 2025 12:18:46 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20364


--JUNJXoXLXhv87spZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

My plan is to update to -cip to 6.1.157, so that I can do 6.1.157-rt57
based release.

When 5.10-rt becomes available, I plan to do -cip-rt release based on
that.

Best regards,
								Pavel
--=20
In cooperation with DENX Software Engineering GmbH, HRB 165235 Munich,
Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--JUNJXoXLXhv87spZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaQtAmwAKCRAw5/Bqldv6
8n9RAJ9wIFBNa9Z7npbfoSQFny8P+niLogCgofwkPopZQ7mjNLpx7VoIoI2ID5Q=
=ihli
-----END PGP SIGNATURE-----

--JUNJXoXLXhv87spZ--

