Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0474DC3ABA3
	for <webhook@archiver.kernel.org>; Thu,  1 May 2025 08:24:51 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.web10.6869.1746087883836759283
 for <cip-dev@lists.cip-project.org>;
 Thu, 01 May 2025 01:24:44 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=TU1W61gJ;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 2EA2D10269597;
	Thu,  1 May 2025 10:24:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1746087882; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=8Ll3N83wiu2u2kwSTxZKa1ikoicssDHWovoDIiIfcXU=;
	b=TU1W61gJaSKW9N3oqOIBubzQlZYySoZixfu04RdtsGdmP7Xr//iDrQKNjUxNlZmaidkBe6
	FizTmzlWIep7XzrIkESNUrIDwz2KSAhkaOB0/X6xjrDUhqmZOjbxw1YjK7g1NY7hrjddyO
	xGNvszl0rKg6T4H1HgJHue1HivTebBZGb+DukBJwvJm5yRIvDrHPWyva7zZfjarACj7gIG
	la/yLI1XwiaF5DmqGttICKHNIyF9vrQYlQpPCfvwzOXEWgZFFIj3Cg70Pd4vYaUJ/SLHCa
	VB+ypSkGnwLyHVqbL4t2gTL9O8MPRvjaQwBAi/Y57VkzJpxwyi0jrGfZn1R9pw==
Date: Thu, 1 May 2025 10:24:38 +0200
From: Pavel Machek <pavel@denx.de>
To: Claudiu <claudiu.beznea@tuxon.dev>
Cc: nobuhiro1.iwamatsu@toshiba.co.jp, cip-dev@lists.cip-project.org
Subject: Re: [PATCH v5.10.y-cip 00/21] RZ/G3S: Backport I2C
Message-ID: <aBMvxq+o+EBL0Ay/@duo.ucw.cz>
References: <20250429134727.2429662-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/DwfJBCW7D6eGqsd"
Content-Disposition: inline
In-Reply-To: <20250429134727.2429662-1-claudiu.beznea.uj@bp.renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 01 May 2025 08:24:51 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18746


--/DwfJBCW7D6eGqsd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

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

Thank you, applied.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--/DwfJBCW7D6eGqsd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaBMvxgAKCRAw5/Bqldv6
8kRDAJ4y4GIR8pvcD41UGGvYOSz8EwXSjgCgr8BgKh4AjD/3vwzvpt+6ckRRtRk=
=5Qrn
-----END PGP SIGNATURE-----

--/DwfJBCW7D6eGqsd--

