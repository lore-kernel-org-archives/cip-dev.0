Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4077D47CDE
	for <webhook@archiver.kernel.org>; Fri, 16 Jan 2026 11:09:35 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.3566.1768561774766723405
 for <cip-dev@lists.cip-project.org>;
 Fri, 16 Jan 2026 03:09:35 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=DW6FmRRB;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 7E5BF10E4C7;
	Fri, 16 Jan 2026 12:09:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1768561772;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=qAoMRcoJ3anugmWQvugvQR9xetDArHPn0FiQtNknUBo=;
	b=DW6FmRRBTgQUlryuPPs9TZVA60p7LNYmWSS/DC+Mr28uhHiXv7T+qllaB8LtZIAWSqBsBO
	t/PSnQRgI3u5WDGNJ1btppt4FpzxrqXTkxAMFKA8ax0hIrgb5riOYCk7uWl7o8OwKYeJhX
	i9t3wv58/OgSP25dfZATuBkyip3k3dkLUzo0ffJ8laKWgDEIgNB88BA8+R7kSEVYrWiZY2
	VMNOZ0JnTd+HCJ05PU+7ioiSh6+Qqgm7qdJHi//Kd8MIFaqCuC+wJDImWCDkhIZuYDCQ7R
	TTiQkBz6ZQjZdvalIQsnBCtviLj9BLLAwISYxKzUC06uGLiayx9IxOg4+el9dQ==
Date: Fri, 16 Jan 2026 12:09:28 +0100
From: Pavel Machek <pavel@nabladev.com>
To: Claudiu <claudiu.beznea@tuxon.dev>
Cc: pavel@nabladev.com, nobuhiro.iwamatsu.x90@mail.toshiba,
	cip-dev@lists.cip-project.org
Subject: Re: [PATCH 5.10.y-cip] pinctrl: renesas: rzg2l: Fix ISEL restore on
 resume
Message-ID: <aWocaN0FxCWNIDYa@duo.ucw.cz>
References: <20260115103710.133165-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="W5Nzr+ephBm8Qkba"
Content-Disposition: inline
In-Reply-To: <20260115103710.133165-1-claudiu.beznea.uj@bp.renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 16 Jan 2026 11:09:35 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21630


--W5Nzr+ephBm8Qkba
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> commit 44bf66122c12ef6d3382a9b84b9be1802e5f0e95 upstream.
>=20
> Commit 1d2da79708cb ("pinctrl: renesas: rzg2l: Avoid configuring ISEL in
> gpio_irq_{en,dis}able*()") dropped the configuration of ISEL from
> struct irq_chip::{irq_enable, irq_disable} APIs and moved it to
> struct gpio_chip::irq::{child_to_parent_hwirq,
> child_irq_domain_ops::free} APIs to fix spurious IRQs.
>=20
> After commit 1d2da79708cb ("pinctrl: renesas: rzg2l: Avoid configuring IS=
EL
> in gpio_irq_{en,dis}able*()"), ISEL was no longer configured properly on
> resume. This is because the pinctrl resume code used
> struct irq_chip::irq_enable  (called from rzg2l_gpio_irq_restore()) to
> reconfigure the wakeup interrupts. Some drivers (e.g. Ethernet) may also
> reconfigure non-wakeup interrupts on resume through their own code,
> eventually calling struct irq_chip::irq_enable.
>=20
> Fix this by adding ISEL configuration back into the
> struct irq_chip::irq_enable API and on resume path for wakeup interrupts.
>=20
> As struct irq_chip::irq_enable needs now to lock to update the ISEL,
> convert the struct rzg2l_pinctrl::lock to a raw spinlock and replace the
> locking API calls with the raw variants. Otherwise the lockdep reports
> invalid wait context when probing the adv7511 module on RZ/G2L:

> +++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
=2E..
> -static void rzg2l_gpio_irq_enable(struct irq_data *d)
> +static void __rzg2l_gpio_irq_enable(struct irq_data *d, bool lock)
>  {
>  	struct gpio_chip *gc =3D irq_data_get_irq_chip_data(d);
> +	struct rzg2l_pinctrl *pctrl =3D container_of(gc, struct rzg2l_pinctrl, =
gpio_chip);
>  	unsigned int hwirq =3D irqd_to_hwirq(d);
> =20
>  	gpiochip_enable_irq(gc, hwirq);
> +	if (lock)
> +		rzg2l_gpio_irq_endisable(pctrl, hwirq, true);
> +	else
> +		__rzg2l_gpio_irq_endisable(pctrl, hwirq, true);
>  	irq_chip_enable_parent(d);
>  }
>

Conditional locking. That's something that should normally be avoided.

Anyway, it is already in mainline, and patch looks good to me, so

Reviewed-by: Pavel Machek <pavel@nabladev.com>

I can apply this if it passes testing.

Best regards,
                                                                Pavel
--=20
In cooperation with Nabla.

--W5Nzr+ephBm8Qkba
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaWocaAAKCRAw5/Bqldv6
8mlXAJ41svurEAOYUreR+xD7r80lnfQETQCgjp7gP4E9ydD9tOl04+vEekO0Mlg=
=Bn7R
-----END PGP SIGNATURE-----

--W5Nzr+ephBm8Qkba--

