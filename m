Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 635C9C44515
	for <webhook@archiver.kernel.org>; Mon, 20 Jul 2026 20:16:04 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.6789.1784578559415730044
 for <cip-dev@lists.cip-project.org>;
 Mon, 20 Jul 2026 13:15:59 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=AFgf2VcH;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 58572116D5B;
	Mon, 20 Jul 2026 22:15:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1784578557;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=zHgYzpuf3pZcWmHMiYlw38fBgg9UFEHEj7y4S6GaswA=;
	b=AFgf2VcHR851F7PDP8YLA5JCiS4k3q983RMKmAavSMr6Sq1GpzThMQObxf6eytT9ecXPl2
	EucZLNIKlJ6caXjYIg6CxM/qbpL5FV+XTVZuq34tEXZ4ym11KTSCg5WRw2Ce/AVvwv5f2S
	/RZA9WlkTpNVjZ5iHmj7w+kke/UQiHQLvN10J/sfIQ6TqOEoE9YaD+KVh17ezUUa4/6XrQ
	+VgggM+WBMcrM/b+tRysW0YlwuoVBsckPG//9RAHQ/+gIukX6U4UJr7lGlOGFPFlhVDzDY
	HUXlEdJdPtVTlByBZjeKoWfYo5Nbk6J/DKspcOZ4JMNTXQ93WgoGF5nplgOECg==
Date: Mon, 20 Jul 2026 22:15:56 +0200
From: Pavel Machek <pavel@nabladev.com>
To: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@nabladev.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: Re: [PATCH 6.1.y-cip 02/23] dt-bindings: hwmon: ti,tmp108: Add
 nxp,p3t1085 compatible string
Message-ID: <al6B_ELxChTW5J0y@duo.ucw.cz>
References: <20260717131241.2233788-1-tommaso.merciai.xr@bp.renesas.com>
 <20260717131241.2233788-3-tommaso.merciai.xr@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="siBmR1QBTzlmVI/c"
Content-Disposition: inline
In-Reply-To: <20260717131241.2233788-3-tommaso.merciai.xr@bp.renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 20 Jul 2026 20:16:04 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23688


--siBmR1QBTzlmVI/c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> From: Frank Li <Frank.Li@nxp.com>
>=20
> commit 4585580781d69d8627e15f027873e46282ea3787 upstream.
>=20
> The register layout of P3T1085 is the same as ti,tmp108. Add compatible
> string nxp,p3t1085 for it. The difference of P3T1085 is support I3C.

> +++ b/Documentation/devicetree/bindings/hwmon/ti,tmp108.yaml
> @@ -4,22 +4,26 @@
>  $id: http://devicetree.org/schemas/hwmon/ti,tmp108.yaml#
>  $schema: http://devicetree.org/meta-schemas/core.yaml#
> =20
> -title: TMP108 temperature sensor
> +title: TMP108/P3T1085(NXP) temperature sensor
> =20
>  maintainers:
>    - Krzysztof Kozlowski <krzk@kernel.org>
> =20
>  description: |
> -  The TMP108 is a digital-output temperature sensor with a
> +  The TMP108/P3T1085(NXP) is a digital-output temperature sensor with a
>    dynamically-programmable limit window, and under- and overtemperature
>    alert functions.
> =20
> +  P3T1085(NXP) support I3C.

I believe this should be "supports".

Best regards,
									Pavel

--siBmR1QBTzlmVI/c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCal6B/AAKCRAw5/Bqldv6
8upEAKCOMKPJcGAWZOSzBJahRZPflfhL6QCdHwMTnRSFY4eZid6fWHYd7j1Z2iE=
=D77z
-----END PGP SIGNATURE-----

--siBmR1QBTzlmVI/c--

