Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00D88E92FD5
	for <webhook@archiver.kernel.org>; Mon, 29 Dec 2025 20:22:05 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.50741.1767039716593960483
 for <cip-dev@lists.cip-project.org>;
 Mon, 29 Dec 2025 12:21:57 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=hi25sHbF;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 98D671006948B;
	Mon, 29 Dec 2025 21:21:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1767039714; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=tbyFX4ltVicDJWfyM1IGFQ5UPil/CEsZ/OWSpyVw/qQ=;
	b=hi25sHbFsKjME9A3zskk9Rl79rE43Laj5nkd/+uBdi9jZm3u2dP/pYxa+cly+zoqugsmMX
	qUVVwo4qIHywueSXCrYac93gU1a/98m1c6ZfbwH24J7crJCudx2J5HhEKK+H+MZtdeiXrm
	ai8t/s/KPkKI9w1dN7zy7vWBq2jWbPiEmGfNHk8JrnNGtaFzh8Za4BIRn4rRkQgyF3SKtx
	bQePbDxq/bEUHLfnjiSWqdnY5b5uroZNn+fLHa5TWT+NdwmWEhUI209ctitI8lgqzfxCHE
	EBsy38wru3FSYIE1o6lhOYCc0zQe7M/j3uv1/n/ZQJjqVV8cFDSS5rqzvaEksg==
Date: Mon, 29 Dec 2025 21:21:51 +0100
From: Pavel Machek <pavel@denx.de>
To: Claudiu <claudiu.beznea@tuxon.dev>
Cc: nobuhiro.iwamatsu.x90@mail.toshiba, cip-dev@lists.cip-project.org
Subject: Re: [PATCH 6.12.y-cip 3/6] thermal/drivers/renesas/rzg3s: Add
 thermal driver for the Renesas RZ/G3S SoC
Message-ID: <aVLi32qigJKR3NcP@duo.ucw.cz>
References: <20251217103222.4183089-1-claudiu.beznea.uj@bp.renesas.com>
 <20251217103222.4183089-4-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="si27lwi4JmVkcfbp"
Content-Disposition: inline
In-Reply-To: <20251217103222.4183089-4-claudiu.beznea.uj@bp.renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 29 Dec 2025 20:22:04 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21251


--si27lwi4JmVkcfbp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

I have some comments below.

> index 000000000000..d184dccc882f
> --- /dev/null
> +++ b/drivers/thermal/renesas/rzg3s_thermal.c
> +static int rzg3s_thermal_get_temp(struct thermal_zone_device *tz, int *t=
emp)
> +{
> +	struct rzg3s_thermal_priv *priv =3D thermal_zone_device_priv(tz);
> +	int ts_code_ave =3D 0;
> +
> +	if (priv->mode !=3D THERMAL_DEVICE_ENABLED)
> +		return -EAGAIN;

I'm pretty sure -EAGAIN is wrong error code here. -EBUSY or something?

> +	/*
> +	 * According to the HW manual (Rev.1.10, section 40.4.4 Procedure for M=
easuring the
> +	 * Temperature) the computation formula is as follows:
> +	 *
> +	 * Tj =3D (ts_code_ave - priv->calib1) * 165 / (priv->calib0 - priv->ca=
lib1) - 40
> +	 *
> +	 * Convert everything to milli Celsius before applying the formula to a=
void
> +	 * losing precision.
> +	 */
> +
> +	*temp =3D div_s64((s64)(ts_code_ave - MCELSIUS(priv->calib1)) * MCELSIU=
S(165),
> +			MCELSIUS(priv->calib0 - priv->calib1)) - MCELSIUS(40);
> +
> +	/* Report it in milli degrees Celsius and round it up to 0.5 degrees Ce=
lsius. */
> +	*temp =3D roundup(*temp, 500);

If we did the computation in high precision, and interface wants
millicelsius, is rounding good idea?

> +static void rzg3s_thermal_set_mode(struct rzg3s_thermal_priv *priv,
> +				   enum thermal_device_mode mode)
> +{
> +	struct device *dev =3D priv->dev;
> +	int ret;
> +
> +	ret =3D pm_runtime_resume_and_get(dev);
> +	if (ret)
> +		return;

Now caller does not know if we failed or not. Should this return errno?

Best regards,
								Pavel
--=20
In cooperation with DENX Software Engineering GmbH, HRB 165235 Munich,
Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--si27lwi4JmVkcfbp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaVLi3wAKCRAw5/Bqldv6
8un8AKDBY0nrB2BUYKrX2OJ4GRZe7uIxfgCeMWforIQgM5Wmw/+5aD1qg/dhMlY=
=NGe3
-----END PGP SIGNATURE-----

--si27lwi4JmVkcfbp--

