Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F4DDC282EC
	for <webhook@archiver.kernel.org>; Fri, 14 Mar 2025 10:07:54 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.web11.10569.1741946861748021163
 for <cip-dev@lists.cip-project.org>;
 Fri, 14 Mar 2025 03:07:42 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=Km+RaQKo;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 2E3F310382F09;
	Fri, 14 Mar 2025 11:07:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1741946859; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=LP2j17niAfb3UNYaF2K5aRkCMNA9P7Md5TI9oXc+FIQ=;
	b=Km+RaQKotpm8rtoC8oWNYNTe2sct1WHonlN/OVqZMAPv02tr2hNfTbyQKLAdhsJH/2Rt6X
	XO0/dGNz8VQ/epHT+RHhdoa0TAWjzGDQb4HBtSCijblY8L5bA1z1b31WCLeulRQOfm6GyK
	kO3BTNFcFNIlYsIfpNTBlxuKXaRzfjUfqHepHlf0FHxIWvp4iPybyE3UVPCba8PsXTPKkH
	BVWAGrXLW+q0WmBNiES59lH0xLfvCgE2rGLhDesX7NwAEr0bIvdQwbT1P3Ivdu6V4XZKOy
	DBWlHLECG/5Ky1gHbkiEjNonGFbjx0h1Z915Hda9SY4TdmThdYAeD+UaogPltw==
Date: Fri, 14 Mar 2025 11:07:35 +0100
From: Pavel Machek <pavel@denx.de>
To: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>, Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: Re: [PATCH 6.1.y-cip 03/85] dt-bindings: clock: renesas: Document
 RZ/V2H(P) SoC CPG
Message-ID: <Z9P/51qOlq2B46FK@duo.ucw.cz>
References: <20250312112302.1605750-1-tommaso.merciai.xr@bp.renesas.com>
 <20250312112302.1605750-4-tommaso.merciai.xr@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="9znjFRJkv/CR/HuD"
Content-Disposition: inline
In-Reply-To: <20250312112302.1605750-4-tommaso.merciai.xr@bp.renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 14 Mar 2025 10:07:54 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18207


--9znjFRJkv/CR/HuD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>=20
> commit afec1aba08607b18cfd00fdcd6525aeca0e187bf upstream.
>=20
> Document the device tree bindings for the Renesas RZ/V2H(P) SoC
> Clock Pulse Generator (CPG).
>=20
> CPG block handles the below operations:
> - Generation and control of clock signals for the IP modules
> - Generation and control of resets
> - Control over booting
> - Low power consumption and power supply domains
>=20
> Also define constants for the core clocks of the RZ/V2H(P) SoC. Note the
> core clocks are a subset of the ones which are listed as part of section
> 4.4.2 of HW manual Rev.1.01 which cannot be controlled by CLKON register.
>=20
> Signed-off-by: Lad Prabhakar
> <prabhakar.mahadev-lad.rj@bp.renesas.com>

> +description:
> +  On Renesas RZ/V2H(P) SoCs, the CPG (Clock Pulse Generator) handles gen=
eration
> +  and control of clock signals for the IP modules, generation and contro=
l of resets,
> +  and control over booting, low power consumption and power supply domai=
ns.

", and" -- probably delete and.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--9znjFRJkv/CR/HuD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZ9P/5wAKCRAw5/Bqldv6
8qq0AKCezyxgAWgpZZBKxTsU/NVhO25X3ACggDYaKoPUp30RSdzIlEqqLiFkka0=
=nNkc
-----END PGP SIGNATURE-----

--9znjFRJkv/CR/HuD--

