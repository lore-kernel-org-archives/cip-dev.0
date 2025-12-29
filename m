Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AD78E92FDF
	for <webhook@archiver.kernel.org>; Mon, 29 Dec 2025 21:12:15 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.51677.1767042733500839719
 for <cip-dev@lists.cip-project.org>;
 Mon, 29 Dec 2025 13:12:13 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=UpIGC1lZ;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E79EF1006949B;
	Mon, 29 Dec 2025 22:12:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1767042731; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=oncXSZVgz/2sWNA/rk8tRQggVMbOUnNffVSS9UF6GKA=;
	b=UpIGC1lZz9DelBudErIKSh0T5054Ub2UFZmzS2dzcYeAVM/iKtzJb/0HtLoJjMUoHuoZir
	aW2sY+TkR0jn31JgMR7QTJwHiwszk9rIjPaBJj2ytTcvBUFEiJ7SrJTswnj9QzXuJHQMFj
	wCaWDViYLCxQkxtK29TtWfTCmBAmG/4rg7dWf1d/MiTE1Jq5cJhAeBUClB2g0kmbTkbGk1
	HTdS126CMW1NRgaNfrfzUV6tRJ8WcmwVZDkGGmOlGlsr+6HB7SBgP2AK0fCybF89Ib2NtU
	7iL0lZC8bIcS9ZrG37TbpRSBAHAVxgdIUns6yDTlVPeJb6oJl3g9wm7KNMAa8A==
Date: Mon, 29 Dec 2025 22:12:05 +0100
From: Pavel Machek <pavel@denx.de>
To: Biju <biju.das.au@gmail.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH 6.12.y-cip 4/5] arm64: dts: renesas: r9a09g047e57-smarc:
 Add gpio keys
Message-ID: <aVLupTHC7bQtYEsn@duo.ucw.cz>
References: <20251219122916.129256-1-biju.das.jz@bp.renesas.com>
 <20251219122916.129256-5-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Q3WYOXkxl7gypwr3"
Content-Disposition: inline
In-Reply-To: <20251219122916.129256-5-biju.das.jz@bp.renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 29 Dec 2025 21:12:15 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21254


--Q3WYOXkxl7gypwr3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> From: Biju Das <biju.das.jz@bp.renesas.com>
>=20
> [ Upstram commit 9e95446b0cf93a91bc3b3b64c6d423f4024a6ff0 ]
>=20
> RZ/G3E SMARC EVK  has 3 user buttons called USER_SW1, USER_SW2 and
> USER_SW3 and SLEEP button with NMI support. Add a DT node in device tree
> to instantiate the gpio-keys driver for these buttons.
>=20
> The system can enter into STR state by pressing the sleep button and
> wakeup from STR is done by pressing power button. The USER_SW{1,2,3}
> configured as wakeup-source, so it can wakeup the system during
> s2idle.


> +++ b/arch/arm64/boot/dts/renesas/r9a09g047e57-smarc.dts
> @@ -8,6 +8,7 @@
>  /dts-v1/;
> =20
>  /* Switch selection settings */
> +#define SW_LCD_EN		0
>  #define SW_GPIO8_CAN0_STB	0
>  #define SW_GPIO9_CAN1_STB	0
>  #define SW_LCD_EN		0

SW_LCD_EN already exists, 3 lines below. This may confuse someone when
the defines get out of sync.

> +	keys: keys {
> +		compatible =3D "gpio-keys";
> +
> +		key-1 {
> +			interrupts-extended =3D <&pinctrl KEY_1_GPIO IRQ_TYPE_EDGE_FALLING>;
> +			linux,code =3D <KEY_1>;
> +			label =3D "USER_SW1";
> +			wakeup-source;
> +			debounce-interval =3D <20>;
> +		};

Are they buttons (they return to 0 when force is released) or switches
(you move them to 1 position, then you have to move them again into 0
position)?

If they are buttons, label is quite confusing. If they are switches,
more fixing may be needed.

Best regards,
								Pavel
--=20
In cooperation with DENX Software Engineering GmbH, HRB 165235 Munich,
Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--Q3WYOXkxl7gypwr3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaVLupQAKCRAw5/Bqldv6
8mveAJ44DA+noDwqrSRTYSj48vPjdtgvYACeNhM5TmUAUlm1WVV2jiReMN0RsuM=
=++zJ
-----END PGP SIGNATURE-----

--Q3WYOXkxl7gypwr3--

