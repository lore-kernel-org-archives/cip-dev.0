Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1CF1C9EC91
	for <webhook@archiver.kernel.org>; Mon, 12 Jan 2026 13:45:13 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.32932.1768225504562296916
 for <cip-dev@lists.cip-project.org>;
 Mon, 12 Jan 2026 05:45:05 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=IIEwJ6/l;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 797AA10B7C2;
	Mon, 12 Jan 2026 14:44:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1768225502;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=qm8tFw11WKbozFyhuXRz5o9fIdZHaSNm2CnB1JxBvzM=;
	b=IIEwJ6/lMy381JueLrQYOVb+gHgnnFu8FFjqykOLjOmEeIQtBhIeQyiDwDIwNKGwru+Ay/
	w9J4ghuDE7sjmrmzA9Bkyot9TWajyG76iHcNBNNfPwz4tB5wfAXwfAU/SRmJEqY+j3KMte
	sahnwBx1AThXS41NwK2mWUh5R7YoM+GRnADixwf/+jxADKIG7EwpQnz5VIo8jbBEFmOtXT
	rlxmWSGk7V0Rh7ltF6j+zVHGZkcB27t0UdH4xB26dVOh/I+SqPWvOe4VvDazCXBymOCMkp
	hJEwJ2nrQ60v7YRpN2ovg2y13fqXOngkWUlWebrFnZAXRmpNJ04P8et4i9X6lw==
Date: Mon, 12 Jan 2026 14:44:57 +0100
From: Pavel Machek <pavel@nabladev.com>
To: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
Cc: cip-dev@lists.cip-project.org, pavel@nabladev.com,
	nobuhiro.iwamatsu.x90@mail.toshiba
Subject: Re: [PATCH 6.12.y-cip 0/8] Add RZ/V2H RTC support
Message-ID: <aWT62f7ZAIK4BzGY@duo.ucw.cz>
References: <20260109121718.46056-1-ovidiu.panait.rb@renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1j2b9d7JpW4KlzOg"
Content-Disposition: inline
In-Reply-To: <20260109121718.46056-1-ovidiu.panait.rb@renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 12 Jan 2026 13:45:13 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21531


--1j2b9d7JpW4KlzOg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This patch series adds RTC support for the Renesas RZ/V2H SoC.
>=20
> Patches were cherry-picked from mainline kernel.

Thank you, applied and pushed out.

Best regards,
								Pavel
--=20
In cooperation with Nabla.

--1j2b9d7JpW4KlzOg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaWT62QAKCRAw5/Bqldv6
8m57AJ9ej5d3W9hHLSB1VISRC3+oCdHe8ACeNN/1UjRpaGTC8Ub/Yr12G3jsOEY=
=pTAW
-----END PGP SIGNATURE-----

--1j2b9d7JpW4KlzOg--

