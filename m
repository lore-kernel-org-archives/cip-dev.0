Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4D15D2F7DE
	for <webhook@archiver.kernel.org>; Fri,  5 Dec 2025 11:32:50 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.3508.1764934360853973700
 for <cip-dev@lists.cip-project.org>;
 Fri, 05 Dec 2025 03:32:41 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=DwQFBjXU;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 23B5D103AF6C3;
	Fri,  5 Dec 2025 12:32:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1764934358; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=AC70NO95rWV/H/XRn+UUxqxn08Crrfw3A1VqLP1yanc=;
	b=DwQFBjXU7UnKS21q/e8idYvNdqvCrMI72semDjC/eZ4EVx470AZQYPFdiJKZYYTarnng5Q
	kcGYV/pddywRSeixMruUz61sX6KPr3F9FV7ZXOzVtdS/mImrFVn2SHk1iXak8A5a/Ebew+
	CYFKWc6fNnBIEiQTY/h4GSh1lxI/abIlqTRFnqghH5uNKcrI1GQJehDT74WsHhZs0Gu0Ak
	3DvyjKu4XGnxu9tYH4J4j8d02bCgKVvoQKqV372oYVGvPusZWYfUP93zFE5tgmT62wO9dh
	e8KLJzp8cuelzr9vNG7eF4PCpGXxb4Ol41KVEQqhjBwFn5w5mZxRcOrnevxX2Q==
Date: Fri, 5 Dec 2025 12:32:33 +0100
From: Pavel Machek <pavel@denx.de>
To: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
Cc: cip-dev@lists.cip-project.org, nobuhiro.iwamatsu.x90@mail.toshiba
Subject: Re: [PATCH 6.12.y-cip 00/11] Add initial support for RZ/V2N EVK
Message-ID: <aTLC0VMAhf77pn8s@duo.ucw.cz>
References: <20251203154058.33022-1-ovidiu.panait.rb@renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="MHjGR06TidXtn9Zz"
Content-Disposition: inline
In-Reply-To: <20251203154058.33022-1-ovidiu.panait.rb@renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 05 Dec 2025 11:32:50 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20908


--MHjGR06TidXtn9Zz
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

--MHjGR06TidXtn9Zz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaTLC0QAKCRAw5/Bqldv6
8uJKAKCHSpoa6GI/QcvkrouU7YWHSvszOQCfbVw4m+EfL/Q4DN5lELFbrdOVC8c=
=6ydA
-----END PGP SIGNATURE-----

--MHjGR06TidXtn9Zz--

