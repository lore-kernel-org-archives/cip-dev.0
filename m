Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13FA1C369DC
	for <webhook@archiver.kernel.org>; Wed, 30 Apr 2025 07:28:09 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.web11.11544.1745998079016105522
 for <cip-dev@lists.cip-project.org>;
 Wed, 30 Apr 2025 00:27:59 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=RrS+Icvc;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 942931026CE8F;
	Wed, 30 Apr 2025 09:27:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1745998077; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=56XbP430xhUenPh7vpfutl8z1QQQUKYDcjfzxWl5hag=;
	b=RrS+IcvcP7JftrEhZ35eLft0l1r69/N6eXh7U1OFMEXw0yf0qIGF2NBF6O8SwlYuLttKNU
	EJ3R9ueT2P6IoquryKokMBSvaWpx5uppiDTsf1AMWLDUhiMLRmsIPWz9XCYsYVgBrZr1wK
	kQhjXzYM+IY1wrEc3lOm3wDyMvkXa+fCzP/3vkmY38/KWLE547nNiZK7WMpUe/ZKRYwz3S
	Y0D97uHbHtJ+AJdIDYrkmhishRqB3SiEBhA1bZafIUuRvFc4ZTGkSFmI8zkMTCcTw+lwCu
	zpARPbYtEBVtnz0oDwN05SCHnkKMQKqTJ+LXd4C4b4mT2+zHcRhUGioZ/iWCng==
Date: Wed, 30 Apr 2025 09:27:54 +0200
From: Pavel Machek <pavel@denx.de>
To: Claudiu <claudiu.beznea@tuxon.dev>
Cc: nobuhiro1.iwamatsu@toshiba.co.jp, cip-dev@lists.cip-project.org
Subject: Re: [PATCH v5.10.y-cip 00/21] RZ/G3S: Backport I2C
Message-ID: <aBHQ+pQOxKRZuuLd@duo.ucw.cz>
References: <20250429134727.2429662-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="zBBjrBTByidrisL/"
Content-Disposition: inline
In-Reply-To: <20250429134727.2429662-1-claudiu.beznea.uj@bp.renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 30 Apr 2025 07:28:09 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18742


--zBBjrBTByidrisL/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!
>=20
> Series backports the Renesas RZ/G3S I2C support to v5.10.y CIP.
>=20
> For v6.1 CIP only the following patches need to be backported (everything
> else is already integrated):
>=20
>   clk: renesas: r9a08g045: Add clock, reset and power domain support for
>     I2C
>   arm64: dts: renesas: r9a08g045: Add I2C nodes
>   arm64: dts: renesas: rzg3s-smarc: Enable I2C0 node
>   arm64: dts: renesas: rzg3s-smarc-som: Enable I2C1 node
>=20
> For v6.12 CIP none of these patches need to be backported. Everything is
> already integrated.

Thank you, series looks	good and I can apply it	if it passes testing
and there are no objections.

Best regards,
     								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--zBBjrBTByidrisL/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaBHQ+gAKCRAw5/Bqldv6
8q3rAKCq4XM9PfA/MbbBaSraFEReYGxA/gCggrSGBNnmomFCa6VcXPb//Q3+Dts=
=a5Vp
-----END PGP SIGNATURE-----

--zBBjrBTByidrisL/--

