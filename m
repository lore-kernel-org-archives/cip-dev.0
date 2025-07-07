Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2770C83F07
	for <webhook@archiver.kernel.org>; Mon,  7 Jul 2025 09:38:08 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.web11.56559.1751881079318312335
 for <cip-dev@lists.cip-project.org>;
 Mon, 07 Jul 2025 02:37:59 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=ctBEVoGQ;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 02A24103972AC;
	Mon,  7 Jul 2025 11:37:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1751881077; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=dJeomlWDhHe6WOI2UtjI/TVe2zFjU64PqrTyoQu1onc=;
	b=ctBEVoGQEA7XSzMJQ8UJFp0e+rBy49HJqyTthbfNQRwme1eZ1Vz2cJAu39dMH6i5Dv53qe
	sIhh8rjuj65HqyeXt50TK8Kq4xe0IW80IRjjoJH1iTOMEvJlLsK6/VgN1xSe907qIZ86/0
	fWThrE3D81rjBUKzxE2tq22yPokfAL6YFBR4Gugp+X95xEm2gxNL/mDRF3C2AAOPwFuISV
	4uSNaBWItbk+AiqyH4V2CBr4DIbPjC47ecPTe1LgrLQadTzD5XZwbaLUyR5lcc5sJ69ITV
	+JbCc+yb7JP9zV1FGdZtRXqdfDdOZh0jCf1IIKJWLQs682b1CEX2NtPc5Hernw==
Date: Mon, 7 Jul 2025 11:37:53 +0200
From: Pavel Machek <pavel@denx.de>
To: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: Re: [PATCH 6.12.y-cip 05/18] irqchip: Add RZ/V2H(P) Interrupt
 Control Unit (ICU) driver
Message-ID: <aGuVcZ3Z/Ud5j9G1@duo.ucw.cz>
References: <20250704090724.669848-1-tommaso.merciai.xr@bp.renesas.com>
 <20250704090724.669848-6-tommaso.merciai.xr@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="S1u+bVrb5VHM1yTN"
Content-Disposition: inline
In-Reply-To: <20250704090724.669848-6-tommaso.merciai.xr@bp.renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 07 Jul 2025 09:38:08 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19382


--S1u+bVrb5VHM1yTN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> From: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
>=20
> commit 0d7605e75ac2d8620929148f932cde54746c485f upstream.
>=20
> Add driver for the Renesas RZ/V2H(P) Interrupt Control Unit (ICU).
>=20
> This driver supports the external interrupts NMI, IRQn, and TINTn.
>=20

> +++ b/drivers/irqchip/irq-renesas-rzv2h.c
> +static void rzv2h_clear_irq_int(struct rzv2h_icu_priv *priv, unsigned in=
t hwirq)
> +{
> +	unsigned int irq_nr =3D hwirq - ICU_IRQ_START;
> +	u32 isctr, iitsr, iitsel;
> +	u32 bit =3D BIT(irq_nr);
> +
> +	isctr =3D readl_relaxed(priv->base + ICU_ISCTR);
> +	iitsr =3D readl_relaxed(priv->base + ICU_IITSR);
> +	iitsel =3D ICU_IITSR_IITSEL_GET(iitsr, irq_nr);
> +
> +	/*
> +	 * When level sensing is used, the interrupt flag gets automatically cl=
eared when the
> +	 * interrupt signal is de-asserted by the source of the interrupt reque=
st, therefore clear
> +	 * the interrupt only for edge triggered interrupts.
> +	 */

I'd wrap this at 80 columns.

> +	titsel =3D ICU_TITSR_TITSEL_GET(titsr, titsel_n);
> +
> +	/*
> +	 * Writing 1 to the corresponding flag from register ICU_TSCTR only has=
 effect if
> +	 * TSTATn =3D 1b and if it's a rising edge or a falling edge interrupt.
> +	 */

And this.

> +	/*
> +	 * coccicheck complains about a missing put_device call before returnin=
g, but it's a false
> +	 * positive. We still need &pdev->dev after successfully returning from=
 this function.
> +	 */
> +	return 0;

cocci -> Cocci... but more seriously people are submitting stable
patches to silence checkers, so this may be worth finding some
workaround.

Best regards,
								Pavel
--=20
In cooperation with DENX Software Engineering GmbH, HRB 165235 Munich,
Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--S1u+bVrb5VHM1yTN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaGuVcQAKCRAw5/Bqldv6
8rnQAJ9noB8XVRvF2mH4LPYs8N8usZsPTACfR8t0rINN+0obH8aIY7OiwrIvtYs=
=RsEA
-----END PGP SIGNATURE-----

--S1u+bVrb5VHM1yTN--

