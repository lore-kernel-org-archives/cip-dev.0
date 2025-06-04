Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48C5BC5B543
	for <webhook@archiver.kernel.org>; Wed,  4 Jun 2025 16:12:44 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.web11.20704.1749053559889840804
 for <cip-dev@lists.cip-project.org>;
 Wed, 04 Jun 2025 09:12:40 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=EFCHnRHr;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 5DF7310397298;
	Wed,  4 Jun 2025 18:12:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1749053557; h=from:subject:date:message-id:to:mime-version:content-type;
	bh=RRTykeA/B30LNX+OPkDFTpMD/wgAnLxhHOWWTg1zKh0=;
	b=EFCHnRHrxUkH4/qFLpggkfGDh27AMwnJmpZ9IGzKMHncEMNttDkBq+R3/nqLAxUPbppcI6
	DvWseIMwPt//MDKdatlXImuJK2cIz4TU38O0ILjjoBvdLmBjzd4HZ1s2jotNnlO5brqbqc
	ZOJNZDU8GvBmBViV5dKBq7GR9nmNT88h58OhV5GG3l4Ai011V/9NVP5ZKyMIFKKBbUmFgY
	UplbmMQebPIaPMfkdArFL7adrSvm4r+Xk2Tt6pnDJueVE928LjLYk+zt2QJJq29zQpR7fa
	RutGA+mLM5ZPu/hAo6yOsjaYgscWTlpYzZRHoHEnXjALcnHjwZ+UupMv8PZ6Xg==
Date: Wed, 4 Jun 2025 18:12:32 +0200
From: Pavel Machek <pavel@denx.de>
To: Chris.Paterson2@renesas.com, cip-dev@lists.cip-project.org,
	nobuhiro1.iwamatsu@toshiba.co.jp
Subject: renesas_rzfive offline causing test problems?
Message-ID: <aEBwcLjrsmOD8/ZT@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5dDJcWVp3zvklynv"
Content-Disposition: inline
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 04 Jun 2025 16:12:44 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19010


--5dDJcWVp3zvklynv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

We are trying to test latest SCIF patches, but apparently rzfive
target is offline:

https://gitlab.com/cip-project/cip-kernel/linux-cip/-/pipelines/1852365220

(I hit retry, but I doubt it will help).

Any ideas?

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--5dDJcWVp3zvklynv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaEBwcAAKCRAw5/Bqldv6
8qS7AJ92DiTHqQWPeD17Qb0CSIAYOzYxLgCfegMhtoN0/DoLGx/IPKQsq9PUzeI=
=azgx
-----END PGP SIGNATURE-----

--5dDJcWVp3zvklynv--

