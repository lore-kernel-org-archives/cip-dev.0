Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB1D7C43458
	for <webhook@archiver.kernel.org>; Mon, 13 Jul 2026 21:09:24 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.6281.1783976958796260607
 for <cip-dev@lists.cip-project.org>;
 Mon, 13 Jul 2026 14:09:19 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=izh6LEPR;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E7D2D1196C5;
	Mon, 13 Jul 2026 23:09:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1783976956;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=Uv4eto/Mb8MPR4pLbuBVbwt9eo6q40Wen5HrjU9c0HY=;
	b=izh6LEPRdJIxplCGe5N0ecSZhcrJ6haUXHTWtuJDf+HHhv8vKTAxJCGDyXCMdgbYHyWZEt
	Ruyuk05J28pskiTL7o6BCVRqjXUz0rqPH1FJO80usTpe7JePNqpJHk2jqQDYzxIv6j5T5O
	FsoVgR2LOhV8pFq/acBCSrZKqdQZuEYFZTu5FrVgK7+NlQc03Mp2T8dZA6ZAH8/T0KxcXL
	R62m3VeXcrIku0aOncLzXjK0iHlyNi+uGwQ7cjt7qp3UueSFcxGCry+tGlcQzHS2GCw9zz
	22Y8v1BFKzx2MPnUcL3g7FUIsh5OGSoWuGhnnjKFuk/UO9ZyOCkZYDnqRgPEcQ==
Date: Mon, 13 Jul 2026 23:09:14 +0200
From: Pavel Machek <pavel@nabladev.com>
To: Biju <biju.das.au@gmail.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH 5.10.y-cip 0/4] arm64: dts: renesas: Add max-frequency to
 SDHI nodes
Message-ID: <alVT-m89Z6_dQcF4@duo.ucw.cz>
References: <20260713120354.29288-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="CvKk+OtILY/JkVG2"
Content-Disposition: inline
In-Reply-To: <20260713120354.29288-1-biju.das.jz@bp.renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 13 Jul 2026 21:09:24 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23568


--CvKk+OtILY/JkVG2
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

Ok, so as I understand it, we don't need this for 6.1-cip and others,
because it is already in mainline 6.1, so no backport is needed.

Best regards,
								Pavel

--CvKk+OtILY/JkVG2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCalVT+gAKCRAw5/Bqldv6
8qaYAKCgcvJ52a311C91HxlCJcYvMIjUEwCgwsTjgy4XXYfoZ1GS2qVDspvXBQk=
=tsqC
-----END PGP SIGNATURE-----

--CvKk+OtILY/JkVG2--

