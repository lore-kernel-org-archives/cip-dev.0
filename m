Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C13C3CCF9E3
	for <webhook@archiver.kernel.org>; Tue,  4 Nov 2025 12:44:02 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.16688.1762260235988456944
 for <cip-dev@lists.cip-project.org>;
 Tue, 04 Nov 2025 04:43:56 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=RbhGTACQ;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 3D976103AF6ED;
	Tue,  4 Nov 2025 13:43:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1762260233; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=8+UKRpqILppl3CdwjZuYMMSKDOdqlmV6+BGS2TcOtWY=;
	b=RbhGTACQNqbBaiCazD+XnmeTAhSvJOSwnW0kvWoxxJ/QisiiDoARAo9NTimfS7ug/5HClX
	QrcbvwP09vkf88uGXfu3E/TaVVirs6f7fzEoGB8ZfXe13UbNWU/b6lmfX1SceWoq3MmkoR
	cy5PmNZlSaszn+mLxtYjmEjVDUTt52ZDkPwyiOZTOMs9CETjTqM4eA0iSqX6OssULYaZkz
	eirp8cstIUk4PsB1N1+xQTo2GlwpETZ9bWoKlVx7g7M7Uhk8A/ymPDm2EHbL3rjgjgZ08b
	tdVk8KmH7inLKv0A/iEhq6Ot0h20epRK8qMP+c6C2RyDT3Eh3AV35Sz0CcSfEw==
Date: Tue, 4 Nov 2025 13:43:49 +0100
From: Pavel Machek <pavel@denx.de>
To: John Madieu <john.madieu.xa@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Subject: Re: [PATCH 6.12.y-cip 01/22] soc: renesas: Add config option for
 RZ/V2N (R9A09G056) SoC
Message-ID: <aQn1BYvk7Z9aNAFc@duo.ucw.cz>
References: <20251103113817.36331-1-john.madieu.xa@bp.renesas.com>
 <20251103113817.36331-2-john.madieu.xa@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="u2itSfD/XhY4oXMq"
Content-Disposition: inline
In-Reply-To: <20251103113817.36331-2-john.madieu.xa@bp.renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 04 Nov 2025 12:44:02 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20348


--u2itSfD/XhY4oXMq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>=20
> [ Upstream commit 31d358e611b7cc21349da58dd2c9118c84b0859f ]
>=20
> Add a new Kconfig option, ARCH_R9A09G056, to enable ARM64 platform support
> for the Renesas RZ/V2N SoC. Default this option to "y" when
> ARCH_RENESAS is

I wonder if this one should be last in the series? We don't want to
offer option that does not work.

Best regards,
								Pavel

> +++ b/drivers/soc/renesas/Kconfig
> @@ -352,6 +352,12 @@ config ARCH_R9A09G047
>  	help
>  	  This enables support for the Renesas RZ/G3E SoC variants.
> =20
> +config ARCH_R9A09G056
> +	bool "ARM64 Platform support for RZ/V2N"
> +	default y if ARCH_RENESAS
> +	help
> +	  This enables support for the Renesas RZ/V2N SoC variants.
> +
>  config ARCH_R9A09G057
>  	bool "ARM64 Platform support for RZ/V2H(P)"
>  	select RENESAS_RZV2H_ICU

--=20
In cooperation with DENX Software Engineering GmbH, HRB 165235 Munich,
Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--u2itSfD/XhY4oXMq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaQn1BQAKCRAw5/Bqldv6
8mtjAJ0cCgnpAGvBC1n90K0LFqbjqpyDIgCeNL/Xw4xcIX+fk0SbO+JTd2WHAQU=
=TmWy
-----END PGP SIGNATURE-----

--u2itSfD/XhY4oXMq--

