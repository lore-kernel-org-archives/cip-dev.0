Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D8E2C36010
	for <webhook@archiver.kernel.org>; Fri,  4 Apr 2025 10:47:53 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.web11.7980.1743763663849559415
 for <cip-dev@lists.cip-project.org>;
 Fri, 04 Apr 2025 03:47:44 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=Fi5lCpMI;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A87DD1029836A;
	Fri,  4 Apr 2025 12:47:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1743763661; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=f/ojPbXAOQH6mXohAm7lCP4Tz2cFxJc1EnXK/bBJwq8=;
	b=Fi5lCpMIlTpkuDulWO3kxzrITKiFLjus5WFYJ402ry636OJpW3e9otC2J7alKg7We7teok
	d2yT5120DW2IGGwHiJzqSc9Hf57LejCbQ1sUiUOMMv0FwMZkuC1TP+UL5/mWxOdf4MmfX0
	/vDxX55wpnAsKvsk2WNdeGVWL7IGcpQWUU4GfjixRZkNHRE80xNxtBEHp4aaTh3kkK0O7T
	FXYDxmWwaZICrlRWeUOKTAwx2bt6Qb7ofGLyL+kpe1AWt/RpyJemNL2diKl1UoTj6vzV6n
	/d8BK825HO8fgg6SGkXJUxe770Z376buxUiXVo5FY+2pzxV9gNdV3Irb+dg8jA==
Date: Fri, 4 Apr 2025 12:47:34 +0200
From: Pavel Machek <pavel@denx.de>
To: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: Re: [PATCH 6.1.y-cip 8/9] i2c: riic: Add support for R9A09G057 SoC
Message-ID: <Z++4xs9HFKVAbicJ@duo.ucw.cz>
References: <20250404073819.173272-1-tommaso.merciai.xr@bp.renesas.com>
 <20250404073819.173272-9-tommaso.merciai.xr@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tOATq/MfLHn9q60+"
Content-Disposition: inline
In-Reply-To: <20250404073819.173272-9-tommaso.merciai.xr@bp.renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 04 Apr 2025 10:47:53 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18480


--tOATq/MfLHn9q60+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>=20
> commit a45f95d7480544fdaa9d566cb4956d0ca5d0dc33 upstream.
>=20
> Extend the RIIC driver to support the RZ/V2H(P) ("R9A09G057") SoC. It
> accomplishes this by appending the compatible string list and passing
> the RZ/V2H-specific OF data.
>=20
> +++ b/drivers/i2c/busses/i2c-riic.c
> @@ -526,8 +526,25 @@ static const struct riic_of_data riic_rz_a_info =3D {
>  	},
>  };
> =20
> +static const struct riic_of_data riic_rz_v2h_info =3D {
> +	.regs =3D {
> +		[RIIC_ICCR1] =3D 0x00,
> +		[RIIC_ICCR2] =3D 0x01,
> +		[RIIC_ICMR1] =3D 0x02,
> +		[RIIC_ICMR3] =3D 0x04,
> +		[RIIC_ICSER] =3D 0x06,
> +		[RIIC_ICIER] =3D 0x07,
> +		[RIIC_ICSR2] =3D 0x09,
> +		[RIIC_ICBRL] =3D 0x10,
> +		[RIIC_ICBRH] =3D 0x11,
> +		[RIIC_ICDRT] =3D 0x12,
> +		[RIIC_ICDRR] =3D 0x13,
> +	},
> +};

Word-size registers one byte apart? How does that work?

Ok, never mind, just curious.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--tOATq/MfLHn9q60+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZ++4xgAKCRAw5/Bqldv6
8li6AJ4sH//d5gcwWyRE0v3sd4wrRu+MzACeLFxb3u3LAht7o9k73/knnEOCK7c=
=Yesk
-----END PGP SIGNATURE-----

--tOATq/MfLHn9q60+--

