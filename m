Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3AE3C36005
	for <webhook@archiver.kernel.org>; Mon, 28 Apr 2025 06:16:45 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.web10.41739.1745820960069174732
 for <cip-dev@lists.cip-project.org>;
 Sun, 27 Apr 2025 23:16:00 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=FK0t32Ac;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 5163E10298342;
	Mon, 28 Apr 2025 08:15:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1745820958; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=ric/yZf4HJC1zx/xX2ARwEQlwO4Jtx9VV8DLJTM1iuY=;
	b=FK0t32AcjBOwykci0SMyaKgZPFgzue1AmKnsOIcZ/p+nfjJDz5TTnYuY20+0lk/z45rLIP
	D9WCqJGq/wrroJgrN3p7RpONoKqENlBpOOptZgNVes4i32em73maAZO5MObDE7tvkrZ/W3
	APzqn/2tNop6HmaGoTuG2XO6pO64o+idnWFouJ0vz8U+bJJDXcP4URe9pDoX1/rWtBsoHi
	K8J0aV66nOswwW96vdE6p5vkDeDiIjng2dmj5G/JFGBFC9rpV1jOgshZugr43jWoAgG8ZJ
	zGwPKuaD7mupGu0GKgZKYKgi/H6GLYiHW6PNtdF2d+hJm7JpUT+55Nqc9C9qHw==
Date: Mon, 28 Apr 2025 08:15:51 +0200
From: Pavel Machek <pavel@denx.de>
To: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Subject: Re: [PATCH 6.1.y-cip 08/16] arm64: dts: renesas: Add initial DTS for
 RZ/V2H EVK board
Message-ID: <aA8dFw5ZUz5KMd/I@duo.ucw.cz>
References: <20250427191548.130118-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20250427191548.130118-9-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="NlL8aYo5GP14BVMl"
Content-Disposition: inline
In-Reply-To: <20250427191548.130118-9-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 28 Apr 2025 06:16:45 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18678


--NlL8aYo5GP14BVMl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!


> +	chosen {
> +		bootargs =3D "ignore_loglevel";
> +		stdout-path =3D "serial0:115200n8";
> +	};

Having bootarg that affects policy such as "ignore_loglevel" is quite
strange. Why is it specifically needed on this board?

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--NlL8aYo5GP14BVMl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaA8dFwAKCRAw5/Bqldv6
8lauAJoCa/MffLNec6FXSOVGCn4JT9uV3QCgvAVTY/g52b7L8wSLn5B96nk6A6s=
=OPgU
-----END PGP SIGNATURE-----

--NlL8aYo5GP14BVMl--

