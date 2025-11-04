Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D09DDCCF9E3
	for <webhook@archiver.kernel.org>; Tue,  4 Nov 2025 12:57:32 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.16902.1762261042573074707
 for <cip-dev@lists.cip-project.org>;
 Tue, 04 Nov 2025 04:57:23 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=X0FhCXmJ;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 9DC5910398810;
	Tue,  4 Nov 2025 13:57:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1762261040; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=yzP1yXbcVmJ83uRU9OyvHIRX4WInsFVEf8FWNWuHzgk=;
	b=X0FhCXmJ/5mophr8W4BLS5Pj1X2eeCtHXq1OYLvhyLe68QH2D1E5YxFxEeAOkGB5M6Dght
	fht1P1nak6xqMiLYvxbFF0ka0UBGbuox/KhNLfGZgpggIQeSB7yr4OuzqBuuIH4O29KWhn
	gw13ZAQrv4lXgdmUZab47vB9g6cUdO2wckXEt/35EUCMb024wSR+NC+0cPD79knaxHQ8B4
	aqP6z9mN+LDA6/dddzxC/oSj+nnkD6eUsbZL7iOpZC05ag33P+ckbRrr/x5xHjm3meSqyb
	7mI6HEYonpcR/fi2ajDyq5EkZtLQvbEfSI3zXymK1g6XPuKNUztXUjxkHrrsHg==
Date: Tue, 4 Nov 2025 13:57:17 +0100
From: Pavel Machek <pavel@denx.de>
To: John Madieu <john.madieu.xa@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Subject: Re: [PATCH 6.1.y-cip 20/25] net: stmmac: provide generic
 implementation for set_clk_tx_rate method
Message-ID: <aQn4LbAIUWBOFMFN@duo.ucw.cz>
References: <20251103113608.36240-1-john.madieu.xa@bp.renesas.com>
 <20251103113608.36240-21-john.madieu.xa@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="A1hzsOL1UTETiJJn"
Content-Disposition: inline
In-Reply-To: <20251103113608.36240-21-john.madieu.xa@bp.renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 04 Nov 2025 12:57:32 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20352


--A1hzsOL1UTETiJJn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> + * plat_data->clk_tx_i must be filled in.
> + */
> +int stmmac_set_clk_tx_rate(void *bsp_priv, struct clk *clk_tx_i,
> +			   phy_interface_t interface, int speed)
> +{
> +	long rate =3D rgmii_clock(speed);
> +
> +	/* Silently ignore unsupported speeds as rgmii_clock() only
> +	 * supports 10, 100 and 1000Mbps. We do not want to spit
> +	 * errors for 2500 and higher speeds here.
> +	 */
> +	if (rate < 0)
> +		return 0;
> +
> +	return clk_set_rate(clk_tx_i, rate);
> +}

Silently ignoring errors is ugly. Author clearly understood that, and
wrote a comment, but failed to explain why ignoring the errors is good
idea here. Maybe this should be WARN_ON? Better comment would be
certainly welcome.

Best regards,
								Pavel
--=20
In cooperation with DENX Software Engineering GmbH, HRB 165235 Munich,
Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--A1hzsOL1UTETiJJn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaQn4LQAKCRAw5/Bqldv6
8t9/AKDE9Q50AbyCYQ09Ur3tN6E8GHtEZQCfeFJFotB3su7pDEG0jUzV5aK4aoQ=
=tZa1
-----END PGP SIGNATURE-----

--A1hzsOL1UTETiJJn--

