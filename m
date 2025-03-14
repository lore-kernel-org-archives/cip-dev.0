Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0777CC282EC
	for <webhook@archiver.kernel.org>; Fri, 14 Mar 2025 10:08:44 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.web10.10443.1741946916951420866
 for <cip-dev@lists.cip-project.org>;
 Fri, 14 Mar 2025 03:08:37 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=DfiRg7bt;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A03C010382F1A;
	Fri, 14 Mar 2025 11:08:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1741946914; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=/ZAZo2PsnKJUTD17RfSz/sLW8cGNHCmP9oKy9g/CheQ=;
	b=DfiRg7btkpkriNEY2bLjAppx/SreItFD3BcA2PCd49y4T/nfp4YeXkr8p+iLqm9K7X+FRU
	fjmrDknyPJgWswK1hTdcQKvoCp4Fe3y0CQgGBPbd570BY7QQdlJdKz4fUWBbwszp1XEscZ
	hPIHUc6YSdCWI0Ar54N6+ZVpJVVShqR6rQz7Y6zVTDafUykFmI6pg0IqiNInJRYwuT289w
	msvADXyuHwGPWSWygeJZzk6rXQ9K5eHXLtbaeUbmELA/WwTcg58CxyTJYCF9p1vcbgmObx
	lsjdeOAPjILL10HWF3X/PbNBTFDmwt067bJ+94aoI3EdDUxN0g8WO6Ey8xnabw==
Date: Fri, 14 Mar 2025 11:08:31 +0100
From: Pavel Machek <pavel@denx.de>
To: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>, Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: Re: [PATCH 6.1.y-cip 04/85] dt-bindings: clock: renesas: Document
 RZ/G3E SoC CPG
Message-ID: <Z9QAHxYm2AUG/gvG@duo.ucw.cz>
References: <20250312112302.1605750-1-tommaso.merciai.xr@bp.renesas.com>
 <20250312112302.1605750-5-tommaso.merciai.xr@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="QpaNSMADiN7onE7B"
Content-Disposition: inline
In-Reply-To: <20250312112302.1605750-5-tommaso.merciai.xr@bp.renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 14 Mar 2025 10:08:44 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18208


--QpaNSMADiN7onE7B
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Document the device tree bindings for the Renesas RZ/G3E SoC
> Clock Pulse Generator (CPG).
>=20
> Also define constants for the core clocks of the RZ/G3E SoC.
>=20

> --- a/Documentation/devicetree/bindings/clock/renesas,rzv2h-cpg.yaml
> +++ b/Documentation/devicetree/bindings/clock/renesas,rzv2h-cpg.yaml
> @@ -4,19 +4,22 @@
>  $id: http://devicetree.org/schemas/clock/renesas,rzv2h-cpg.yaml#
>  $schema: http://devicetree.org/meta-schemas/core.yaml#
> =20
> -title: Renesas RZ/V2H(P) Clock Pulse Generator (CPG)
> +title: Renesas RZ/{G3E,V2H(P)} Clock Pulse Generator (CPG)
> =20
>  maintainers:
>    - Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> =20
>  description:
> -  On Renesas RZ/V2H(P) SoCs, the CPG (Clock Pulse Generator) handles gen=
eration
> -  and control of clock signals for the IP modules, generation and contro=
l of resets,
> -  and control over booting, low power consumption and power supply domai=
ns.
> +  On Renesas RZ/{G3E,V2H(P)} SoCs, the CPG (Clock Pulse Generator) handl=
es
> +  generation and control of clock signals for the IP modules, generation=
 and
> +  control of resets, and control over booting, low power consumption and=
 power

", and" -> ",".

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--QpaNSMADiN7onE7B
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZ9QAHwAKCRAw5/Bqldv6
8j1fAKCwxWaxPU83eBNA4WY9iilrDgCD8QCfSjW0hKE6d9QzUq4ARYqnRLH8llc=
=8fv5
-----END PGP SIGNATURE-----

--QpaNSMADiN7onE7B--

