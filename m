Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1520D1F9B0
	for <webhook@archiver.kernel.org>; Thu,  4 Dec 2025 10:41:34 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.40646.1764844877301854302
 for <cip-dev@lists.cip-project.org>;
 Thu, 04 Dec 2025 02:41:17 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=TuD95oAB;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 26E801002C619;
	Thu,  4 Dec 2025 11:41:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1764844875; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=wjRDPd+ksC4BmkYeAn7bHAQ2wSNLRCy9WoN+B2/OFDI=;
	b=TuD95oABq5g2bzQVcimktwNwzhi4OxS36irxnY/J2UNLaVGRrI5HanSHEDArq4cUR4avQz
	TWYWZg5opKysbzJYGdxeimL0igLDCuc2wg0ipArBfWmxdp25MoNOOTAmjUsC03E95mdevF
	ZUjP9J0nKRLaeOvDZwVzpzBGWetjAp3l94+2kZMU6XSrA3naVZ7i2JEdyYtr7ErqXOfdYk
	Oi6b5AvgZDBB1lNXMG69Q6YVmvNXSjJ/vBr/83RUVyzksO+l2v1/JRotU8TiHMklcL+mmS
	xdaDzcy6YxwtS0mEEjaapd1nLuVFdC2Hr/KchWpD7nysfQGddyEEgfWYt0xMOw==
Date: Thu, 4 Dec 2025 11:41:04 +0100
From: Pavel Machek <pavel@denx.de>
To: ovidiu.panait.rb@renesas.com
Cc: cip-dev@lists.cip-project.org, nobuhiro.iwamatsu.x90@mail.toshiba
Subject: Re: [cip-dev] [PATCH 6.1.y-cip 03/12] soc: renesas: Add config
 option for RZ/V2N (R9A09G056) SoC
Message-ID: <aTFlQK+eW3bob1p4@duo.ucw.cz>
References: <20251203153757.32977-1-ovidiu.panait.rb@renesas.com>
 <20251203153757.32977-4-ovidiu.panait.rb@renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PBhNrGSvaSlaHfSY"
Content-Disposition: inline
In-Reply-To: <20251203153757.32977-4-ovidiu.panait.rb@renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 04 Dec 2025 10:41:34 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20840


--PBhNrGSvaSlaHfSY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>=20
> commit 31d358e611b7cc21349da58dd2c9118c84b0859f upstream.
>=20
> Add a new Kconfig option, ARCH_R9A09G056, to enable ARM64 platform support
> for the Renesas RZ/V2N SoC. Default this option to "y" when ARCH_RENESAS =
is
> enabled, ensuring that support for the RZ/V2N SoC is automatically
> included.

This adds no-op option, as far as I can tell, so people can enable it
and then nothing happen. I'd not mind this to be last.

Best regards,
								Pavel
--=20
In cooperation with DENX Software Engineering GmbH, HRB 165235 Munich,
Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--PBhNrGSvaSlaHfSY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaTFlQAAKCRAw5/Bqldv6
8msOAKC+dcCZqziGvZdEbQfmutsa+V+k3ACeJ+BbWzg1AiClzrMe94qkpWdRJnE=
=3yoI
-----END PGP SIGNATURE-----

--PBhNrGSvaSlaHfSY--

