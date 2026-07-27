Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F328AC531D0
	for <webhook@archiver.kernel.org>; Mon, 27 Jul 2026 12:34:30 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.30058.1785155662680921700
 for <cip-dev@lists.cip-project.org>;
 Mon, 27 Jul 2026 05:34:23 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=VZl2aGmc;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 09129118E6A;
	Mon, 27 Jul 2026 14:34:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1785155656;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=L/FXoi9i0DqbphZdnOWSKakMDdRUgDZoOVfg1hLAyus=;
	b=VZl2aGmc/cr/enaxrpIfNWN1cIjdsfxIUvcfoc1UVGhNWtGY2yqf7OxQ1BCLWcLZ56863x
	Hh46yaa3wDgC9QGUsMs5n97DI2UdNaWjrOA2gmn5SNkwxbiTwJBzamOkV+81MEAroYcFHS
	dRsS+PPatowkqdBdAVyJuEODkqXIShA2HH8eCKyWQM1i1lVB55H6XGwTHduK9lQlU+kw3x
	qCi41s6Q0Ao+njKhVg0rCXZnBMxuVBaSm5/ayqnnhIMFZkLSfVYhpCeGyMndk4TY9Q9LAW
	kOQrlLwBxRhHl1GyLh4ZW6CWGyJQSQLUvrdVICst0IV2GJ9faQ4DaT1DGAgErg==
Date: Mon, 27 Jul 2026 14:34:12 +0200
From: Pavel Machek <pavel@nabladev.com>
To: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Cc: nobuhiro.iwamatsu.x90@mail.toshiba, pavel@nabladev.com,
	cip-dev@lists.cip-project.org
Subject: Re: [PATCH 6.12.y-cip v2 01/17] reset: rzg2l-usbphy-ctrl: Add
 support for USB PWRRDY
Message-ID: <amdQRLUjIExW0mJ3@duo.ucw.cz>
References: <20260708081237.3882574-1-claudiu.beznea@tuxon.dev>
 <20260708081237.3882574-2-claudiu.beznea@tuxon.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PdUnmmLzFh1oz5jN"
Content-Disposition: inline
In-Reply-To: <20260708081237.3882574-2-claudiu.beznea@tuxon.dev>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 27 Jul 2026 12:34:30 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23758


--PdUnmmLzFh1oz5jN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>=20
> commit 78f2d64e484753bfede6a0e9eab0ef35830c34fb upstream.
>=20
> On the Renesas RZ/G3S SoC, the USB PHY block has an input signal called
> PWRRDY. This signal is managed by the system controller and must be
> de-asserted after powering on the area where USB PHY resides and asserted
> before powering it off.

> +++ b/drivers/reset/reset-rzg2l-usbphy-ctrl.c
> =20
> +static void rzg2l_usbphy_ctrl_set_pwrrdy(struct regmap_field *pwrrdy,
> +					 bool power_on)
> +{
> +	u32 val =3D power_on ? 0 : 1;

This probably should be !power_on... for readability.

> +	/* The initialization path guarantees that the mask is 1 bit long. */
> +	regmap_field_update_bits(pwrrdy, 1, val);
> +}

Best regards,
									Pavel

--PdUnmmLzFh1oz5jN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCamdQRAAKCRAw5/Bqldv6
8nMkAJ0au+2xSY1UZWvXNQuLHkRE0ODPiACfQYnXnCQOctDdoeQ9jzrUtUB1AOM=
=jBtK
-----END PGP SIGNATURE-----

--PdUnmmLzFh1oz5jN--

