Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20515C44501
	for <webhook@archiver.kernel.org>; Wed, 15 Jul 2026 10:27:50 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.3238.1784111267868191358
 for <cip-dev@lists.cip-project.org>;
 Wed, 15 Jul 2026 03:27:48 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=C4g/iYfK;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id DE71D119B5D;
	Wed, 15 Jul 2026 12:27:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1784111265;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=Z1lvTeEgL6FkQTbSR7sY3YnyF8Ap9LuzsREinRMRqpw=;
	b=C4g/iYfKAJ/G0UbE4485VTgbrQIEvo6CwcpM9Rdo4S5OeZ+4ge2377t7FkdPFaeETudjvn
	3qbv0s62xEmyHZbkwfHV3i8Xq5iOP9p9XiK1Deo1D0b58G/Ipn5vmOpiJ6s/zLGLppbIgS
	hl2IDIgy6yIhWSPVOzWBl2Xa6MaMaP4LmlXrhrdhf7AxyGYI4WWPqmsmQHTLARQujrSv1m
	kkRa9SzR7jpvtjPA26wwU060H8mffaPEZlMeXkiXuCEfy8wGXtOUoF9ClO+F5x5D+ZuuB3
	pJ3RjemW2+lWAc103JrzTOHGx99ENjX1OFOJcN7x1DgoE6s/rN4nXG5iDRO6Vg==
Date: Wed, 15 Jul 2026 12:27:43 +0200
From: Pavel Machek <pavel@nabladev.com>
To: Biju <biju.das.au@gmail.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH 6.1.y-cip 0/3] arm64: dts: renesas: Add max-frequency to
 SDHI nodes
Message-ID: <aldgn7ibyN0gVXuY@duo.ucw.cz>
References: <20260714090532.6843-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="w63ANaJQHhPu3Hme"
Content-Disposition: inline
In-Reply-To: <20260714090532.6843-1-biju.das.jz@bp.renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 15 Jul 2026 10:27:50 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23594


--w63ANaJQHhPu3Hme
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

--w63ANaJQHhPu3Hme
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaldgnwAKCRAw5/Bqldv6
8i5UAKCGKlKlFtAWnv78fa7O/pZMR9+0jgCfW+dhH47DAsVFjx1/lDM2ePHQpUU=
=dLhB
-----END PGP SIGNATURE-----

--w63ANaJQHhPu3Hme--

