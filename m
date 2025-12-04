Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15FE4D1F9B4
	for <webhook@archiver.kernel.org>; Thu,  4 Dec 2025 11:04:55 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.40797.1764846290300103335
 for <cip-dev@lists.cip-project.org>;
 Thu, 04 Dec 2025 03:04:50 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=Z/+L16Ft;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 684FC106A9C52;
	Thu,  4 Dec 2025 12:04:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1764846288; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=IWudqGjI3qdahgDVXHxOx92W312EXkj4wq/ERAqr74w=;
	b=Z/+L16Ft05SPxR+cekGU26ozk9yaYbPqiDp0qtOVSo0ZqVCkToL6WWR/b6dGI/4fsIROHa
	A/PmUB7Y3DTgc7Wk3COKbnh1u+Dr45/on/O+NZNGk2SAcgrtePnyMU1NK5BydvRXWvVbjs
	/RKdFyhKIxXVPmPbkXaukRh9Kn5HAWVccCcQTki6pZdC6PmRAMPmtbv4hVztCElqCJXkHQ
	hv5/TdAxbWmKoFeOGkdhznnqjj6bekLP6+XGvmpaQ9N5USZlSQFL8SUsGwa3twfVeN88A/
	gGsNZBdw/sUFaF2zE2xNgQhJPAqQU+byP/sM7z9cuSA349UEaqlg7V7UagTImg==
Date: Thu, 4 Dec 2025 12:04:45 +0100
From: Pavel Machek <pavel@denx.de>
To: ovidiu.panait.rb@renesas.com
Cc: cip-dev@lists.cip-project.org, nobuhiro.iwamatsu.x90@mail.toshiba
Subject: Re: [cip-dev] [PATCH 6.1.y-cip 00/12] Add initial support for RZ/V2N
 EVK
Message-ID: <aTFqzRuoTeGnrZp9@duo.ucw.cz>
References: <20251203153757.32977-1-ovidiu.panait.rb@renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="YnIiCnObDduJr7j/"
Content-Disposition: inline
In-Reply-To: <20251203153757.32977-1-ovidiu.panait.rb@renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 04 Dec 2025 11:04:55 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20845


--YnIiCnObDduJr7j/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This series adds initial support for the Renesas RZ/V2N EVK platform. It
> provides the basic SoC and board dts files and enables the following core
> functionality:
>   - CPU (Cortex-A55 cores with operating points)
>   - External clocks (audio, qextal, rtxin)
>   - Pin controller (GPIO support)
>   - Clock Pulse Generator (CPG)
>   - System controller (SYS)
>   - Serial Communication Interface (SCIF)
>   - Secure Digital Host Interface and eMMC (SDHI)
>   - Generic Interrupt Controller (GIC)
>   - ARMv8 timer
>=20
> Note that the RZ/V2N SoC shares most functionality with the RZ/V2H SoC,
> which is already supported in the CIP kernels, so most of the required
> driver infrastructure is already available.

Similar to 6.12, I can apply this if there are no other comments and
it passes testing.

Best regards,
								Pavel
--=20
In cooperation with DENX Software Engineering GmbH, HRB 165235 Munich,
Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--YnIiCnObDduJr7j/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaTFqzQAKCRAw5/Bqldv6
8n+8AJ4p32Cy/MiDnd9xwgMZN/Y3zJTLUwCgo9FLObqySpZaraWMFljM2BOQoxs=
=3aaB
-----END PGP SIGNATURE-----

--YnIiCnObDduJr7j/--

