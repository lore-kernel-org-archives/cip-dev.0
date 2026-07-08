Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E957AC43458
	for <webhook@archiver.kernel.org>; Wed,  8 Jul 2026 20:26:15 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.17868.1783542372263001136
 for <cip-dev@lists.cip-project.org>;
 Wed, 08 Jul 2026 13:26:12 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=f0VxyTW1;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 69D021192DF;
	Wed,  8 Jul 2026 22:26:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1783542369;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=yYSGPuBED181KmBl81j5NoZngG1n/YbxxHLqQTa+yBU=;
	b=f0VxyTW1q/edJ/aE/tVGvW++z7/KmBlAkELypi3M7vjMsCyK89YaJWL3T0LJRnZA4z/9IT
	uJGKxJRA90eZT3n809vfbJr/WE4PMdeUscZAcpJh1XeM5k8i9jz4SOS1z7+wk2qhCGq/Wb
	tNgloxaIn+kiq692ES/89tzLPO9z8dIJPX/UbrH4njQQRD0/iMKi3tJJ3Su+QgeR6AkzH1
	frhq2O6J8Yg8/6H7Ipl3+aaAQN55E9h06TckTqYnB6vZJ2L4+T6zyuEM8fzMCFZm/sYoOd
	BMpwEUv7lTRbQJpjjjsymgvOq3KnvTdoUn0w/MMHnhRNWpV8JtsYFHv/RFTCtw==
Date: Wed, 8 Jul 2026 22:26:03 +0200
From: Pavel Machek <pavel@nabladev.com>
To: Biju <biju.das.au@gmail.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH 6.12.y-cip 00/26] Add RZ/G3L IA55 support
Message-ID: <ak6yWxbsPgT8X18c@duo.ucw.cz>
References: <20260703100756.238233-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="CUK9zRvMDu35KYMA"
Content-Disposition: inline
In-Reply-To: <20260703100756.238233-1-biju.das.jz@bp.renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 08 Jul 2026 20:26:15 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23547


--CUK9zRvMDu35KYMA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> The IRQC block on the RZ/G3L SoC is almost identical to the one found on
> the RZ/G2L SoC, with the following differences:
>=20
>  - The number of GPIO interrupts for TINT selection is 113 instead of 123.
>  - The pin index and TINT selection index are not in the 1:1 map.
>  - The number of external interrupts are 16 instead of 8, out of these
>    8 external interrupts are shared with TINT.

>  .../renesas,rzg2l-irqc.yaml                   | 157 ++---
>  drivers/irqchip/irq-renesas-rzg2l.c           | 627 ++++++++++++++----

This looks okay to me.

Reviewed-by: Pavel Machek <pavel@nabladev.com>

However... this is unused for the moment, right? I don't see dts
changes that would actually activate the support.

Best regards,
                                                                Pavel


--CUK9zRvMDu35KYMA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCak6yWwAKCRAw5/Bqldv6
8mMbAKCMMv3gTpQHcLK+h5MDzC6vUdWNnACfe0u9QQIxoM7U6OMdkKDHS4JnwWU=
=J2mw
-----END PGP SIGNATURE-----

--CUK9zRvMDu35KYMA--

