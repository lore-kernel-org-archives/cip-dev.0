Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7867AC36014
	for <webhook@archiver.kernel.org>; Tue,  1 Apr 2025 10:31:11 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.web10.15657.1743503460943069018
 for <cip-dev@lists.cip-project.org>;
 Tue, 01 Apr 2025 03:31:01 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=IcqrWLvB;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E7CA9101CF7E2;
	Tue,  1 Apr 2025 12:30:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1743503459; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=osv7tyxWrH/Bk9LlCr0D9IMjPgXWei94L+dRkrYrpBw=;
	b=IcqrWLvBh2tTrfJrMaXvCZ6pKzNcBVcdHST3y08/PS28OrC833UmG2UMfV1+QWFspHLVC4
	DMK1tvKqui6GWkRmLdpbpb/ei7lPMXhUb4GeR54h6/DU+CDew626gA5NzNGJmwvQh7Dsw5
	Yiaf+/ulLVFn09mWqM8A0/73khG7td6tMKsSoJQBVmKythIjBS/ostE+d6Ug63rGWtKRHE
	cBGfqjpnULL2eysG8OlKQ9IoJbeNtJjZgHL6UbWXlOn8RoNye3vZPfca/ykhN9bhNhCFt7
	/wEGL8NUH/lA5c12ypfLI2ce1U59BkUFYr3WmHp/mbkMbJ1bdTM2dnDzOETsnA==
Date: Tue, 1 Apr 2025 12:30:54 +0200
From: Pavel Machek <pavel@denx.de>
To: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: Re: [PATCH 6.1.y-cip 15/43] pinctrl: renesas: rzg2l: Add support for
 pull-up/down
Message-ID: <Z+vAXjvxSu1RSqqY@duo.ucw.cz>
References: <20250331104514.79090-1-tommaso.merciai.xr@bp.renesas.com>
 <20250331104514.79090-16-tommaso.merciai.xr@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="dLynT8AZb4dO+0kd"
Content-Disposition: inline
In-Reply-To: <20250331104514.79090-16-tommaso.merciai.xr@bp.renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 01 Apr 2025 10:31:11 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18448


--dLynT8AZb4dO+0kd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> commit 19d4bce9ce876ad0ee4240ebd849b730b3dc3763 upstream.
>=20
> Add support to configure bias-disable, bias-pull-up, and bias-pull-down
> properties of the pin.
>=20
> Two new function pointers, hw_to_bias_param() and bias_param_to_hw(),
> are introduced in the struct rzg2l_pinctrl_data to configure bias
> settings, as the values in the PUPD register differ when compared to the
> RZ/G2L family and the RZ/V2H(P) SoC.
>=20
> Value | RZ/G2L        | RZ/V2H
> ---------------------------------
> 00b:  | Bias Disabled | Pull up/down disabled
> 01b:  | Pull-up       | Pull up/down disabled
> 10b:  | Pull-down     | Pull-down
> 11b:  | Prohibited    | Pull-up
>=20
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Link: https://lore.kernel.org/r/20240530173857.164073-12-prabhakar.mahade=
v-lad.rj@bp.renesas.com
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
> ---
>  drivers/pinctrl/renesas/pinctrl-rzg2l.c | 72 +++++++++++++++++++++++++
>  1 file changed, 72 insertions(+)
>=20
> diff --git a/drivers/pinctrl/renesas/pinctrl-rzg2l.c b/drivers/pinctrl/re=
nesas/pinctrl-rzg2l.c
> index 596e101f5b2d4..33c96661092bf 100644
> --- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
> +++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
> @@ -1000,6 +1004,38 @@ static int rzg2l_write_oen(struct rzg2l_pinctrl *p=
ctrl, u32 caps, u32 offset, u8
>  	return 0;
>  }
> =20
> +static int rzg2l_hw_to_bias_param(unsigned int bias)
> +{
> +	switch (bias) {
> +	case 0:
> +		return PIN_CONFIG_BIAS_DISABLE;
> +	case 1:
> +		return PIN_CONFIG_BIAS_PULL_UP;
> +	case 2:
> +		return PIN_CONFIG_BIAS_PULL_DOWN;
> +	default:
> +		break;
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +static int rzg2l_bias_param_to_hw(enum pin_config_param param)
> +{
> +	switch (param) {
> +	case PIN_CONFIG_BIAS_DISABLE:
> +		return 0;
> +	case PIN_CONFIG_BIAS_PULL_UP:
> +		return 1;
> +	case PIN_CONFIG_BIAS_PULL_DOWN:
> +		return 2;
> +	default:
> +		break;
> +	}
> +
> +	return -EINVAL;
> +}

I'd prefer direct return -EINVAL in both cases.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--dLynT8AZb4dO+0kd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZ+vAXgAKCRAw5/Bqldv6
8jhrAJ4lroXb57nqEm4nsQoHIL8fipnYEQCeNXhA/I32KhziuO4cBs82CF9YNVU=
=1M8L
-----END PGP SIGNATURE-----

--dLynT8AZb4dO+0kd--

