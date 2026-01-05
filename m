Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A20DC2A09D
	for <webhook@archiver.kernel.org>; Mon,  5 Jan 2026 11:34:40 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.62129.1767612877708216169
 for <cip-dev@lists.cip-project.org>;
 Mon, 05 Jan 2026 03:34:38 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=BeiPxauv;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D5537105B77;
	Mon,  5 Jan 2026 12:34:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1767612876;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=Xtiyt8Mcvq5q7+VRpZkAkj2vPemWqZoA571RoUsP5Po=;
	b=BeiPxauvh/bCtJRRbORh51JzHxbpCMWziSQ9CL6mJt5d0yZpLIARm9XISj5W8w33uyXTm1
	NqPkZrTzdgBpzB6sqouHiDFMZkIK6LGXcXIRm4d9MQZg14FxRI3DZBd8PZ6kkAWvBAFKRw
	PTmFT/imY2gXPbk+iBV/MqjRZa1Nu5/Xh+h7O3iVnDFJx0ky0GbnKMPtaYjXMfa6Pt80zJ
	xYd0rUurVHzsmLkxRafZ1ELae4EVVnelUbtv4YFoFQYX06XuXghCegn5wUMgjxtGZ0jfNp
	JhLHKT41Ml+/To9EyLc9vMIIDvXJt/bw1gGaC+M1AUoUGursq90RGl60lM+DJg==
Date: Mon, 5 Jan 2026 12:34:34 +0100
From: Pavel Machek <pavel@nabladev.com>
To: prabhakar.mahadev-lad.rj@bp.renesas.com
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [cip-dev] [PATCH 6.12.y-cip 00/17] Add SDHI/eMMC and WDT support
 for RZ/T2H and RZ/N2H
Message-ID: <aVuhylgpbnIbUQyp@duo.ucw.cz>
References: <20251231170026.17006-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4yh+h2q1Cy+D3n6Q"
Content-Disposition: inline
In-Reply-To: <20251231170026.17006-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 05 Jan 2026 11:34:40 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21309


--4yh+h2q1Cy+D3n6Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This series of patches adds support for the SDHI/eMMC controller as well =
as
> the Watchdog Timer (WDT) found on the Renesas RZ/T2H (R9A09G077) and RZ/N=
2H
> (R9A09G087) SoCs. The series includes device tree bindings, clock control=
ler
> support, and device tree nodes for the respective peripherals.

I found a minor nit, but that should not block the merge.

This looks okay to me.

Reviewed-by: Pavel Machek <pavel@nabladev.com>

I can apply the series if it passes testing and there are no other
comments.

Best regards,
                                                                Pavel
--=20
In cooperation with Nabla.

--4yh+h2q1Cy+D3n6Q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaVuhygAKCRAw5/Bqldv6
8iqlAJ9KIrmTJdOwKHar3VKzeDP1kgZMLgCeNtMoMbFx0KuhzXzQgqqnyEaDXFY=
=HIUm
-----END PGP SIGNATURE-----

--4yh+h2q1Cy+D3n6Q--

