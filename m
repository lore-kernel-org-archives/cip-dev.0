Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB480C43458
	for <webhook@archiver.kernel.org>; Tue,  7 Jul 2026 20:17:37 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.158.1783455454011989907
 for <cip-dev@lists.cip-project.org>;
 Tue, 07 Jul 2026 13:17:34 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=RMIJPKf0;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 7059F118FE8;
	Tue,  7 Jul 2026 22:17:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1783455451;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=dj7nGLQv+3yNErHyWe4lf1URYMDeb7BE7iCV4v+hhrA=;
	b=RMIJPKf0VvM/MDkUr47qIR2A69TRieZ7m7QrGUA4RMSAQ/gjZho7pzrAcTkj0hRgSAm8ru
	4XbYMwZ/h5eUjdlKgKa+qSx9tsHQpFHznALf3TrQHcscEjycSRcSSFCkRKqBu8yJiAO/QE
	J8L4Rzg7F7jPlSI+izi9l+UkJnyGirxLOoYn6Yb6tlCBfakuxtj4eYslvpmBmCTdIsTqyV
	JAfkViaEBq3M4Pw0DchSTpvQw3RqDBTD5saINYPQG899r77J9xYDQeEUL3U5Fb+RbYo0xW
	Nu6llUcT56qKqKCI8+TTXcsj2CaZ+JJ5Df+HbMLT8SlqTUpF9oFomBM+y4LQ4A==
Date: Tue, 7 Jul 2026 22:17:28 +0200
From: Pavel Machek <pavel@nabladev.com>
To: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>,
	Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [PATCH 6.12.y-cip v2 03/10] pinctrl: renesas: rzt2h: Allow
 .get_direction() for IRQ function GPIOs
Message-ID: <ak1e2EgPQdSVIf6A@duo.ucw.cz>
References: <20260702102349.23431-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260702102349.23431-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4ALlVXqYNBMFOJXm"
Content-Disposition: inline
In-Reply-To: <20260702102349.23431-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 07 Jul 2026 20:17:37 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23475


--4ALlVXqYNBMFOJXm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Hold the spinlock to ensure atomicity between reading the PMC register
> (which determines whether the pin is in GPIO mode or not) and reading
> the function of the pin when it is not in GPIO mode.

Ok, so according to this, two reads need to be protected.

> index 981a34dcc814e..f056e28f6a17e 100644
> --- a/drivers/pinctrl/renesas/pinctrl-rzt2h.c
> +++ b/drivers/pinctrl/renesas/pinctrl-rzt2h.c
> @@ -501,8 +503,25 @@ static int rzt2h_gpio_get_direction(struct gpio_chip=
 *chip, unsigned int offset)
>  	if (ret)
>  		return ret;
> =20
> -	if (rzt2h_pinctrl_readb(pctrl, port, PMC(port)) & BIT(bit))
> +	guard(spinlock_irqsave)(&pctrl->lock);
> +
> +	if (rzt2h_pinctrl_readb(pctrl, port, PMC(port)) & BIT(bit)) {
> +		/*
> +		 * When a GPIO is being requested as an IRQ, the pinctrl
> +		 * framework expects to be able to read the GPIO's direction.
> +		 * IRQ function is separate from GPIO, and enabling it takes the
> +		 * pin out of GPIO mode.
> +		 * At this point, .child_to_parent_hwirq() has already been
> +		 * called to enable the IRQ function.
> +		 * Default to input direction for IRQ function.
> +		 */
> +		reg64 =3D rzt2h_pinctrl_readq(pctrl, port, PFC(port));
> +		reg64 =3D (reg64 >> (bit * 8)) & PFC_MASK;
> +		if (reg64 =3D=3D PFC_FUNC_INTERRUPT)
> +			return GPIO_LINE_DIRECTION_IN;
> +
>  		return -EINVAL;
> +	}
> =20
>  	reg =3D rzt2h_pinctrl_readw(pctrl, port, PM(port));
>  	reg =3D (reg >> (bit * 2)) & PM_MASK;

But AFAICT here, whole rest of the function is running with spinlock
held/interrupts disabled. Is that neccessary?

Thanks and best regards,
								Pavel

--4ALlVXqYNBMFOJXm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCak1e2AAKCRAw5/Bqldv6
8tlCAJ98t4NIDUvErt88n7HkK8J04TVtCACgufGM4uwrg45eB6jQ2R7jA+cryng=
=t2Wl
-----END PGP SIGNATURE-----

--4ALlVXqYNBMFOJXm--

