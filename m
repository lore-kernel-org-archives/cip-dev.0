Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28058C88E53
	for <webhook@archiver.kernel.org>; Tue, 15 Sep 2026 13:41:45 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.23433.1789479694931386440
 for <cip-dev@lists.cip-project.org>;
 Tue, 15 Sep 2026 06:41:35 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=O00YmgXS;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id CF3921040EE;
	Tue, 15 Sep 2026 15:41:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1789479689;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=+mzr7XrQCvE5fj7hmr5wSGWqQpbhnqYwmrIe4ktbW28=;
	b=O00YmgXSm1Xn8wkxcY92dBe+hgS6Ep9oJtaM9v0d/rPKXmkvwTETWb0AOQQerygbpjGGJD
	4TjOGv152+4uzLPyNej0XoFMvfUJaL6MlGL8FhLUyNDH4VzWpNmBm+qMJtF2gufzhosPQp
	yosDmHHsr/WcBcUUdKqg5mHbjy4gnyy4n70rQ+IiJPh3xZADmaeSk8E20DwylfxD4Xeb5s
	S0Q464WpUqJAqsqEQd1IAdGeiFVAQk2H5g/KzWApy2CCchEqLc/UID9ym9BOBVOtsiAWVn
	z0ehWjuYJ79M2RC1NqC3azc2j5H6SzEao3S78zKxrKdanWzCs96CuijvFs5WOw==
Date: Tue, 15 Sep 2026 15:41:27 +0200
From: Pavel Machek <pavel@nabladev.com>
To: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Cc: nobuhiro.iwamatsu.x90@mail.toshiba, pavel@nabladev.com,
	cip-dev@lists.cip-project.org
Subject: Re: [PATCH linux-6.12.y-cip] pinctrl: renesas: rzg2l: Populate
 struct gpio_chip::set_config
Message-ID: <aqlLB4blKkpNfSCx@duo.ucw.cz>
References: <20260915122343.2531425-1-claudiu.beznea@tuxon.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="IeAGdVCZNIKX6zg2"
Content-Disposition: inline
In-Reply-To: <20260915122343.2531425-1-claudiu.beznea@tuxon.dev>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 15 Sep 2026 13:41:45 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24190


--IeAGdVCZNIKX6zg2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>=20
> commit 60a19a68779b1f24e3160c8e4317d0334a397687 upstream.
>=20
> Populate struct gpio_chip::set_config to allow various GPIO
> settings.

This looks okay to me.

Reviewed-by: Pavel Machek <pavel@nabladev.com>

I can apply it if it passes testing and there are no other comments.

Best regards,
                                                                Pavel

--IeAGdVCZNIKX6zg2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaqlLBwAKCRAw5/Bqldv6
8r35AJ43h6Wc005kDJpzgYhaekQpHfHeOwCgghAebbJOPX3cPCXkbHJvhEN+81g=
=sNVk
-----END PGP SIGNATURE-----

--IeAGdVCZNIKX6zg2--

