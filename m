Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECA79D1F9BA
	for <webhook@archiver.kernel.org>; Thu,  4 Dec 2025 11:03:44 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.40965.1764846217601177536
 for <cip-dev@lists.cip-project.org>;
 Thu, 04 Dec 2025 03:03:37 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=hUrDwb1V;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 6F97D103AF6C3;
	Thu,  4 Dec 2025 12:03:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1764846215; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=TxjN8wvr/5gvZqK21YlNnXZS7POFjGb5PLNd154KaLo=;
	b=hUrDwb1Vown96FmISnF68K9oVx8Z96P/sUcQb49yE0Pfy2P/YJDi9fozZ+O0cnPRty6sqH
	kMGVs0ou1+kuNH7eGQQFC1Fki/zjzPQLwjD0w47rTo7DyLUrGAdklOk4hV7FwcqP+vlfEQ
	HIzQk1sJUgBVMfsnN7qtAN/MxyhWiLRH8scGbv1KUizaW7MsyPzkAkNMY0dP556AtqUZu2
	4IEpTnJWv46Wrcd+NZ4tnsh6ADf3u44YUIJ1VYn7z55HY0BEPBMEhYufvvibGjK6qjrmUA
	6ts/eLJkZIA9SjqXufBYXzd2Rd1kTvD9D8rCHJjcPDXrrvuAP2eWVlhnQOAdwg==
Date: Thu, 4 Dec 2025 12:03:34 +0100
From: Pavel Machek <pavel@denx.de>
To: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
Cc: cip-dev@lists.cip-project.org, nobuhiro.iwamatsu.x90@mail.toshiba
Subject: Re: [PATCH 6.12.y-cip 00/11] Add initial support for RZ/V2N EVK
Message-ID: <aTFqhmjfi7fyZhEO@duo.ucw.cz>
References: <20251203154058.33022-1-ovidiu.panait.rb@renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="HtZZSQr4jZ5HA6zh"
Content-Disposition: inline
In-Reply-To: <20251203154058.33022-1-ovidiu.panait.rb@renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 04 Dec 2025 11:03:44 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20844


--HtZZSQr4jZ5HA6zh
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

While comments from 6.1 apply, I don't believe they should block
merge. So I can apply this if it passes testing and there are no other
comments.

Best regards,
								Pavel
--=20
In cooperation with DENX Software Engineering GmbH, HRB 165235 Munich,
Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--HtZZSQr4jZ5HA6zh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaTFqhgAKCRAw5/Bqldv6
8s4lAKCYtLBEdP2g+mkrGUZmIfEWs+CP5QCcC2DPvYF1l0M+htC361C+oFtCyoc=
=vg2T
-----END PGP SIGNATURE-----

--HtZZSQr4jZ5HA6zh--

