Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67727C44501
	for <webhook@archiver.kernel.org>; Wed, 15 Jul 2026 09:30:29 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.2611.1784107825533531804
 for <cip-dev@lists.cip-project.org>;
 Wed, 15 Jul 2026 02:30:26 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=XN+4hXDd;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 0A4CB119B5D;
	Wed, 15 Jul 2026 11:30:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1784107823;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=tsP48LiXb47xS72tQKN73Szd+nTWAwcaLcQ6AlhzYwE=;
	b=XN+4hXDdcU3QDf4J9AWGPf0k8DFoGR6WUljHIIJ0qpDoUjphgDRKyBCXoj+e50IJ88LCwY
	ZV7uGua61aqm4+ddRGpP20xZg0rdKyuU+6ymnz/IBziwpaxwzb8yBklUdUmdAVyswi7lnZ
	fJZf9ys3qzk2FJ8LlupVLR1O23hOUZWmLySo/4hGztTcsfFE9jVVZa/M3HaOCI5PavtJFg
	moPerTZ/CpgT6RbW80XwrWe7v6MIYI778loVIp71q5vyMCLEuoh7dKpqdbGwIUWoDQjYAS
	yiWQsYwEuPxKL9KAkPmWikwj//XmgiYYdmhqsHTwU6KGHcJ7pgn1B8T/gM0vfQ==
Date: Wed, 15 Jul 2026 11:30:18 +0200
From: Pavel Machek <pavel@nabladev.com>
To: Biju <biju.das.au@gmail.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH 6.12.y-cip 0/3] arm64: dts: renesas: Add max-frequency to
 SDHI nodes
Message-ID: <aldTKivK4CXsKZNn@duo.ucw.cz>
References: <20260714101836.8039-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="KqfrAboDpDDccuek"
Content-Disposition: inline
In-Reply-To: <20260714101836.8039-1-biju.das.jz@bp.renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 15 Jul 2026 09:30:29 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23588


--KqfrAboDpDDccuek
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This patch series aims to add the max-frequency property set to
> 133333333 Hz (133.33 MHz) to both SDHI0 and SDHI1 MMC controller nodes in
> the RZ/G2{L,LC,UL}/RZ/V2L device tree.
>=20
> This change results in approximately 33% performance improvement as
> it sets the SD clk to 100 MHz instead of the max 133 MHz.
>=20
> All the patches in this series are cherry-picked from mainline.

Thank you, applied.

Best regards,
								Pavel

--KqfrAboDpDDccuek
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaldTKgAKCRAw5/Bqldv6
8gwiAKCpypngtz082dOYuX2Rl6H5p5k0nwCfWGWQREfxIiCdyh4RW/Zh+UbCgFs=
=g2Jo
-----END PGP SIGNATURE-----

--KqfrAboDpDDccuek--

