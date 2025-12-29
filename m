Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4671DE92FE1
	for <webhook@archiver.kernel.org>; Mon, 29 Dec 2025 21:27:55 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.52061.1767043667273733144
 for <cip-dev@lists.cip-project.org>;
 Mon, 29 Dec 2025 13:27:47 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=WYXwOEms;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 21F93101E0E51;
	Mon, 29 Dec 2025 22:27:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1767043664; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=Wj7qjv5SVzJ8/JHefYW+X+++hX8T+WSbDUleO1HNRsw=;
	b=WYXwOEmsleeJKkLHEuSeTGjcWx5gjlNBj5RhOm2MUU6lNWDv2OGLSP4rMp8xSG165rZGGP
	eXjb7ZJwii5tlLn9WbqEv7sfg5eUpZ9ZGIyJdEAhpguFfmKZnPxKpHr9G12Yg17hiBIoYE
	CTczctiPaXKRO5O26AG2Ta95fNS2cczJhZDxS4uzICAaTfaSRhge4dIP+tRa7IHHu1WJw0
	71lHnLSVtDBqWNBCJ1+pVzmxlWz+K/9CmihlCFJICJZElZN5miRVYU1iRYfVYTdH38g5PM
	bS9OYg3gLMcEuL+UGpR9CZErvrlP8frWfAKJ6lQF1HTxN+a9m6CPcHZmVJAzww==
Date: Mon, 29 Dec 2025 22:27:39 +0100
From: Pavel Machek <pavel@denx.de>
To: Biju <biju.das.au@gmail.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH 6.1.y-cip 05/12] pinctrl: renesas: rzg2l: Fix ISEL
 restore on resume
Message-ID: <aVLyS0dkGgaOhh0H@duo.ucw.cz>
References: <20251218153219.228506-1-biju.das.jz@bp.renesas.com>
 <20251218153219.228506-6-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="aE3+aeMPzAwn+c8f"
Content-Disposition: inline
In-Reply-To: <20251218153219.228506-6-biju.das.jz@bp.renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 29 Dec 2025 21:27:55 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21256


--aE3+aeMPzAwn+c8f
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>=20

> As struct irq_chip::irq_enable needs now to lock to update the ISEL,
> convert the struct rzg2l_pinctrl::lock to a raw spinlock and replace the
> locking API calls with the raw variants. Otherwise the lockdep reports
> invalid wait context when probing the adv7511 module on RZ/G2L:

=2E...

>=20
> diff --git a/drivers/pinctrl/renesas/pinctrl-rzg2l.c b/drivers/pinctrl/re=
nesas/pinctrl-rzg2l.c
> index c7d6914098f8..7b22921e6840 100644
> --- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
> +++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
> @@ -2460,15 +2467,25 @@ static void rzg2l_gpio_irq_disable(struct irq_dat=
a *d)
>  	gpiochip_disable_irq(gc, hwirq);
>  }
> =20
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

Wow, conditional locking based on parameter. I'm not sure that's good
idea. Won't it cause problems with tools such as lockdep?

Having separate functions may be better here, even with the code
duplication.

Best regards,
								Pavel
--=20
In cooperation with DENX Software Engineering GmbH, HRB 165235 Munich,
Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--aE3+aeMPzAwn+c8f
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaVLySwAKCRAw5/Bqldv6
8pMkAKC+jQ4IkDBk2yLVZSyA7LDMrP15ngCfUfzc7v//OZ+6XEmLWnCe3S61Qb4=
=mcxf
-----END PGP SIGNATURE-----

--aE3+aeMPzAwn+c8f--

