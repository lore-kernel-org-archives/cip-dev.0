Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92D98C36017
	for <webhook@archiver.kernel.org>; Tue,  1 Apr 2025 10:34:41 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.web10.15697.1743503659021523088
 for <cip-dev@lists.cip-project.org>;
 Tue, 01 Apr 2025 03:34:19 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=haY+O1aJ;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 34A0210167186;
	Tue,  1 Apr 2025 12:34:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1743503656; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=ybCx5VvFbIzyOKU06QdZ/pOIYOA0rZX72E2Da3EOSA0=;
	b=haY+O1aJUKD2nEOBkMkuyW0X7OSFjgCwzy1wtj8FQA1clOrn8hGa/CxHvH/PCtDwDiNXqJ
	PByAPmhxXLb6HLJTwmeBvmYKRdjimcsApNh1OvZAScfCVya0L+gfhuIgyq3sSKX9cYnY0D
	SDgl+bP/Bv8bML0e6/tx6/1DtZ30Vg9bO7M+20fojd4vy9577Z7V0oLsCZZPixCrmBCBQo
	S9OcyAH2coLzcgvNsAoCaLsZOJPIvgPmFdlF0yxCMT36q423QB1uQP+u19InqCkVII8Pe/
	VIXQZhMyx8/+Ekay47sbBNf7Nwwf1JTPQJYqLPPnGHavwF6TQlmrN4Bo2+8WCw==
Date: Tue, 1 Apr 2025 12:34:11 +0200
From: Pavel Machek <pavel@denx.de>
To: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: Re: [PATCH 6.1.y-cip 19/43] pinctrl: renesas: rzg2l: Add support for
 RZ/V2H SoC
Message-ID: <Z+vBI87WfQCmFafK@duo.ucw.cz>
References: <20250331104514.79090-1-tommaso.merciai.xr@bp.renesas.com>
 <20250331104514.79090-20-tommaso.merciai.xr@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="t+Taw+1O/zIJ1V9i"
Content-Disposition: inline
In-Reply-To: <20250331104514.79090-20-tommaso.merciai.xr@bp.renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 01 Apr 2025 10:34:41 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18449


--t+Taw+1O/zIJ1V9i
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> commit 9bd95ac86e700ab8b1a6c225685e0e5afe426b4e upstream.
>=20
> Add pinctrl driver support for RZ/V2H(P) SoC.
>=20
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Link: https://lore.kernel.org/r/20240530173857.164073-16-prabhakar.mahade=
v-lad.rj@bp.renesas.com
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
> ---
>  drivers/pinctrl/renesas/pinctrl-rzg2l.c | 374 +++++++++++++++++++++++-
>  1 file changed, 371 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/pinctrl/renesas/pinctrl-rzg2l.c b/drivers/pinctrl/re=
nesas/pinctrl-rzg2l.c
> index d42ce90af83ac..8c29c8d3c5743 100644
> --- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
> +++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
> @@ -1041,14 +1086,104 @@ static int rzg2l_bias_param_to_hw(enum pin_confi=
g_param param)
>  	return -EINVAL;
>  }
> =20
> +static int rzv2h_hw_to_bias_param(unsigned int bias)
> +{
> +	switch (bias) {
> +	case 0:
> +	case 1:
> +		return PIN_CONFIG_BIAS_DISABLE;
> +	case 2:
> +		return PIN_CONFIG_BIAS_PULL_DOWN;
> +	case 3:
> +		return PIN_CONFIG_BIAS_PULL_UP;
> +	default:
> +		break;
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +static int rzv2h_bias_param_to_hw(enum pin_config_param param)
> +{
> +	switch (param) {
> +	case PIN_CONFIG_BIAS_DISABLE:
> +		return 0;
> +	case PIN_CONFIG_BIAS_PULL_DOWN:
> +		return 2;
> +	case PIN_CONFIG_BIAS_PULL_UP:
> +		return 3;
> +	default:
> +		break;
> +	}
> +
> +	return -EINVAL;
> +}

Again, direct return might be better here.

> +static u8 rzv2h_pin_to_oen_bit(struct rzg2l_pinctrl *pctrl, u32 offset)
> +{
> +	static const char * const pin_names[] =3D { "ET0_TXC_TXCLK", "ET1_TXC_T=
XCLK",
> +						  "XSPI0_RESET0N", "XSPI0_CS0N",
> +						  "XSPI0_CKN", "XSPI0_CKP" };
> +	const struct pinctrl_pin_desc *pin_desc =3D &pctrl->desc.pins[offset];
> +	unsigned int i;
> +
> +	for (i =3D 0; i < ARRAY_SIZE(pin_names); i++) {
> +		if (!strcmp(pin_desc->name, pin_names[i]))
> +			return i;
> +	}
> +
> +	/* Should not happen. */
> +	return 0;
> +}

Should we have WARN() here?

>  static int rzg2l_pinctrl_pinconf_get(struct pinctrl_dev *pctldev,
>  				     unsigned int _pin,
>  				     unsigned long *config)
>  {
>  	struct rzg2l_pinctrl *pctrl =3D pinctrl_dev_get_drvdata(pctldev);
> -	enum pin_config_param param =3D pinconf_to_config_param(*config);
>  	const struct rzg2l_hwcfg *hwcfg =3D pctrl->data->hwcfg;
>  	const struct pinctrl_pin_desc *pin =3D &pctrl->desc.pins[_pin];
> +	u32 param =3D pinconf_to_config_param(*config);
>  	u64 *pin_data =3D pin->drv_data;
>  	unsigned int arg =3D 0;
>  	u32 off;

I wonder what is going on here. param changed types, but I don't see
corresponding change to pinconf_to_config_param() prototype.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--t+Taw+1O/zIJ1V9i
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZ+vBIwAKCRAw5/Bqldv6
8iPPAJ42/Ho07vY2IXAY2G/DQfElE5svnQCfSFb3pxoBrRjf/bYp8j/v+qgVGRo=
=Dqpl
-----END PGP SIGNATURE-----

--t+Taw+1O/zIJ1V9i--

