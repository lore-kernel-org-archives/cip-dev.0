Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5B3DCCF9E3
	for <webhook@archiver.kernel.org>; Tue,  4 Nov 2025 12:45:32 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.16715.1762260327015411973
 for <cip-dev@lists.cip-project.org>;
 Tue, 04 Nov 2025 04:45:27 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=UqkdKwXX;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 18B46103AF6ED;
	Tue,  4 Nov 2025 13:45:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1762260325; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=BPvW28IZZR6+4u4T/wpFLpdYOZfNeKgVfJNf15/TfDI=;
	b=UqkdKwXXdhSPaSnpizHzI28rvdrVjZyS0Ako3e9ydIL0yRTDakxeDUMws2R9QlTTpHFyT/
	KzyClZ97da8j/5d4/gh/VK41FI+4GYLJOFmSBZMzc6sARdZxvgPXiVQkApFxqTjUnADueG
	hwwDbdz4puhKbJ5zlnE/3z6C6N2+fPITUZNq44kucNWV1mC6S6oZ5PWwppHrNzfuWQ+zkx
	vrlvpyRxTHMfCGw/rRmSHb/GYM7u+zIsO6UGGBq3ExPq7BUd9UYgKQGEPKtl4YfYVqXliZ
	mDxroCt4j+7xNAE/O9FNHP4WI9p7/m/G5p+ZzmTKhiNe55SKULyna+4UTGEvSw==
Date: Tue, 4 Nov 2025 13:45:22 +0100
From: Pavel Machek <pavel@denx.de>
To: John Madieu <john.madieu.xa@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Subject: Re: [PATCH 6.12.y-cip 19/22] net: stmmac: Add DWMAC glue layer for
 Renesas GBETH
Message-ID: <aQn1YhAeLQvfPwKU@duo.ucw.cz>
References: <20251103113817.36331-1-john.madieu.xa@bp.renesas.com>
 <20251103113817.36331-20-john.madieu.xa@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wIOTORtb+cjwJu71"
Content-Disposition: inline
In-Reply-To: <20251103113817.36331-20-john.madieu.xa@bp.renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 04 Nov 2025 12:45:32 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20349


--wIOTORtb+cjwJu71
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> [ Upstream commit 461f6529e5946d98ef91bf115d5ced61d8439a6a ]
>=20
> Add the DWMAC glue layer for the GBETH IP found in the Renesas RZ/V2H(P)
> SoC.

> @@ -131,6 +131,17 @@ config DWMAC_QCOM_ETHQOS
>  	  This selects the Qualcomm ETHQOS glue layer support for the
>  	  stmmac device driver.
> =20
> +config DWMAC_RENESAS_GBETH
> +	tristate "Renesas RZ/V2H(P) GBETH support"
> +	default ARCH_RENESAS
> +	depends on OF && (ARCH_RENESAS || COMPILE_TEST)
> +	help
> +	  Support for Gigabit Ethernet Interface (GBETH) on Renesas
> +	  RZ/V2H(P) SoCs.
> +
> +	  This selects the Renesas RZ/V2H(P) Soc specific glue layer support
> +	  for the stmmac device driver.
> +

I believe "Soc specific" -> "SoC specific" should be done for
consistency.

Best regards,
								Pavel
--=20
In cooperation with DENX Software Engineering GmbH, HRB 165235 Munich,
Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--wIOTORtb+cjwJu71
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaQn1YgAKCRAw5/Bqldv6
8ijSAJ9gtXFtEA6Nlqx/zyW/l69dv4lCWgCfbOO/nR/14mb6VGeoa7e2qp40wdo=
=VOYW
-----END PGP SIGNATURE-----

--wIOTORtb+cjwJu71--

