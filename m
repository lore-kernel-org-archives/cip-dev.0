Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D013D2F7E1
	for <webhook@archiver.kernel.org>; Fri,  5 Dec 2025 11:33:50 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.3687.1764934422666223177
 for <cip-dev@lists.cip-project.org>;
 Fri, 05 Dec 2025 03:33:43 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=fl+vB5A9;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D330210092110;
	Fri,  5 Dec 2025 12:33:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1764934420; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=SWOZYQsGrDg1J3+vp6k1xOjTQVzMkymrElp5NN9507Q=;
	b=fl+vB5A9I85vOKR887p/wcdwM+2VHdnOl5KDfciiAp2AXkFJw989OeCc2NtYhW7GDEDdxs
	Mugx0zxVOn27TwyI7pSGf58IRmTRdDGm8qlzw7ZfOyz2yNhhNAtyTko6mH9Bp+cS+qsE+m
	X2Ka/0OPUxG9cy+v2j/XHCSb7CAtVbBjzHNK9pSDLW1lXxI13x/qWek+SMWBuORSjQkUO3
	jCcnZveRHM5cYiUk50is0voVAX4o/J8faZpy1s8V8Y2beE2qbFM2DRVOaiCtUAvY0LnkEl
	NErMw6R/lYCx/0WLdqfWza/STNE2T6WSTU8j4OudIIMfxZGKqdWzxQMjbefzIQ==
Date: Fri, 5 Dec 2025 12:33:38 +0100
From: Pavel Machek <pavel@denx.de>
To: ovidiu.panait.rb@renesas.com
Cc: cip-dev@lists.cip-project.org, nobuhiro.iwamatsu.x90@mail.toshiba
Subject: Re: [cip-dev] [PATCH 6.1.y-cip 00/12] Add initial support for RZ/V2N
 EVK
Message-ID: <aTLDEjd8nIFJZkr3@duo.ucw.cz>
References: <20251203153757.32977-1-ovidiu.panait.rb@renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="EQKhpJ6D0oFMcnDR"
Content-Disposition: inline
In-Reply-To: <20251203153757.32977-1-ovidiu.panait.rb@renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 05 Dec 2025 11:33:50 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20909


--EQKhpJ6D0oFMcnDR
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

Thank you, applied.

Best regards,
								Pavel
--=20
In cooperation with DENX Software Engineering GmbH, HRB 165235 Munich,
Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--EQKhpJ6D0oFMcnDR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaTLDEgAKCRAw5/Bqldv6
8jYTAJ0Ut2WyML+/E7ak4b1OK97Y7sKDVgCfUX9qCmqqOosmZPsOH99SsjT/jCs=
=Pv56
-----END PGP SIGNATURE-----

--EQKhpJ6D0oFMcnDR--

