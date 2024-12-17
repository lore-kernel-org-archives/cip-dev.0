Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D6A5E7717F
	for <webhook@archiver.kernel.org>; Tue, 17 Dec 2024 20:30:50 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.web11.91342.1734467448298806071
 for <cip-dev@lists.cip-project.org>;
 Tue, 17 Dec 2024 12:30:48 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=GxfT9S8g;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 077771048AF6C;
	Tue, 17 Dec 2024 21:30:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1734467446;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=D08HG/rnw48/W/F32BWWTWkVKd5zP0869MYE6mL+PV4=;
	b=GxfT9S8g6Dh1V5lQ2sdqk+pJwOMLyQlFuP8xjIvmPI9j3d8tfog9RBpzu7jsKMBz9QIkl0
	RaQaQqZl9XCUfix5uLOa3GEWbXwt9PY2+ByC5KN0OvaTUGnbbtdZBKT+eTadNFO6AIchYr
	5JT1mT5fmJ14uTjv9diygJhSC5L9S6Mqm+3I3Fw+uzLJxZRXhm8qqPmBoXhI9ZiksqIEVx
	NAat+QJqEExdT6bf8v767IAxZf0zjkSIN/I5WX7mnFKt832FsyNzewDLHGAcu8E10Ezst9
	iaGcAYPHr2CDfpacVg9tAoV49U2Q9Ixvu7XhU7/ONuoFnRDSL8LZIMTkiEwtQA==
Date: Tue, 17 Dec 2024 21:30:44 +0100
From: Pavel Machek <pavel@denx.de>
To: Claudiu <claudiu.beznea@tuxon.dev>
Cc: nobuhiro1.iwamatsu@toshiba.co.jp, pavel@denx.de,
	cip-dev@lists.cip-project.org, biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com
Subject: Re: [cip dev][PATCH 5.10.y-cip 0/3] pinctrl: renesas: rzg2l: Fixes
 for suspend to RAM
Message-ID: <Z2HfdOjbrm9bDEij@duo.ucw.cz>
References: <20241216130700.321518-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4hzuB1+cctpifEsd"
Content-Disposition: inline
In-Reply-To: <20241216130700.321518-1-claudiu.beznea.uj@bp.renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 17 Dec 2024 20:30:50 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17441


--4hzuB1+cctpifEsd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This series backports suspend to RAM fixes for the rzgl2 pinctrl
> driver.
>=20
> Thank you,
> Claudiu Beznea
>=20
> Claudiu Beznea (3):
>   pinctrl: renesas: rzg2l: Execute atomically the interrupt
>     configuration
>   pinctrl: renesas: rzg2l: Configure the interrupt type on resume
>   pinctrl: renesas: rzg2l: Use spin_{lock,unlock}_irq{save,restore}

Thank you, applied and pushed out.

BR,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--4hzuB1+cctpifEsd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZ2HfdAAKCRAw5/Bqldv6
8hhKAKCaiyqh/pHABRztfbJMeZnNnDRz4ACfXNe3h1byqt+K+npdWkQv34t0DuY=
=/i7f
-----END PGP SIGNATURE-----

--4hzuB1+cctpifEsd--

