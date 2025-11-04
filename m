Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC2C7CCFA04
	for <webhook@archiver.kernel.org>; Tue,  4 Nov 2025 12:50:52 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.16827.1762260646105258227
 for <cip-dev@lists.cip-project.org>;
 Tue, 04 Nov 2025 04:50:46 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=HA42V1My;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 1157E10398810;
	Tue,  4 Nov 2025 13:50:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1762260643; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=LD6p474mw/UfxlvKLSpNha3hjPOowY7EWztgZz2/c1Q=;
	b=HA42V1MyymSjQjnVwxq40YM0/JiwdORqpSAPl9yEUrPqAHjEEIVu69xV004IoJouR1q6ez
	Rkx2S1JTa0pGk6HAx+s4N0aS/+jwSp3a8kkGa6aLxhpZf8ZuDlQFUiopPsLEr1A7oFyxje
	gWZZQotYlKI2+jYCfzfV/wg+pjhXANsZ7bj7vc6I4MuJcDfujy00GQbc/GoixkJaHmQCMc
	DoDAwjbKSa9vJ/sk4jJNrLWBUONF1sDzPv8Kf0HL3M+PYCg/gx5WDAK7s16x2mZk6baung
	qG+z7Vdge2OKgeuPjNeFhcmFFgutdDKNOpXv3r6urej8g4DbNohTzgrEM4DpTA==
Date: Tue, 4 Nov 2025 13:50:39 +0100
From: Pavel Machek <pavel@denx.de>
To: John Madieu <john.madieu.xa@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Subject: Re: [PATCH 6.1.y-cip 07/25] pinctrl: renesas: rzg2l: Unify OEN
 access by making pin-to-bit mapping configurable
Message-ID: <aQn2n2gbzfxfr7KY@duo.ucw.cz>
References: <20251103113608.36240-1-john.madieu.xa@bp.renesas.com>
 <20251103113608.36240-8-john.madieu.xa@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="t8T0aC9lWa6xxcUa"
Content-Disposition: inline
In-Reply-To: <20251103113608.36240-8-john.madieu.xa@bp.renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 04 Nov 2025 12:50:52 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20350


--t8T0aC9lWa6xxcUa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Refactor the RZG2L pinctrl driver to support reuse of the common
> rzg2l_read_oen() and rzg2l_write_oen() helpers across SoCs with
> different output-enable (OEN) bit mappings.
>=20
> Introduce a new `pin_to_oen_bit` callback in `struct rzg2l_pinctrl_data`
> to allow SoCs to provide custom logic for mapping a pin to its OEN bit.
> Update the generic OEN read/write paths to use this callback when
> present.

> +++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
> @@ -1063,7 +1064,10 @@ static u32 rzg2l_read_oen(struct rzg2l_pinctrl *pc=
trl, unsigned int _pin)
>  {
>  	int bit;
> =20
> -	bit =3D rzg2l_pin_to_oen_bit(pctrl, _pin);
> +	if (!pctrl->data->pin_to_oen_bit)
> +		return 0;
> +
> +	bit =3D pctrl->data->pin_to_oen_bit(pctrl, _pin);
>  	if (bit < 0)
>  		return 0;
>

Returning success on failure... is strange, but I believe that is
changed in later patches.

> @@ -1077,9 +1081,12 @@ static int rzg2l_write_oen(struct rzg2l_pinctrl *p=
ctrl, unsigned int _pin, u8 oe
>  	int bit;
>  	u8 val;
> =20
> -	bit =3D rzg2l_pin_to_oen_bit(pctrl, _pin);
> +	if (!pctrl->data->pin_to_oen_bit)
> +		return -EINVAL;
> +
> +	bit =3D pctrl->data->pin_to_oen_bit(pctrl, _pin);
>  	if (bit < 0)
> -		return bit;
> +		return -EINVAL;
> =20
>  	spin_lock_irqsave(&pctrl->lock, flags);
>  	val =3D readb(pctrl->base + oen_offset);

But his one is ugly. Any error return is converted to -EINVAL here.

Best regards,
								Pavel
--=20
In cooperation with DENX Software Engineering GmbH, HRB 165235 Munich,
Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--t8T0aC9lWa6xxcUa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaQn2nwAKCRAw5/Bqldv6
8u8tAJsEheMCbXzJLaRlgOtJ/nXypf+s7ACeNjpg53Uy4+LvaQ+/1sTifOd7GiQ=
=7wd6
-----END PGP SIGNATURE-----

--t8T0aC9lWa6xxcUa--

