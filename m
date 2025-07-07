Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8DD0C83F07
	for <webhook@archiver.kernel.org>; Mon,  7 Jul 2025 09:35:18 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.web11.56524.1751880917944544003
 for <cip-dev@lists.cip-project.org>;
 Mon, 07 Jul 2025 02:35:18 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=aFpl2VOo;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 34B6810380104;
	Mon,  7 Jul 2025 11:35:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1751880914; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=RQvI1kQzm2cfOu21viYdsaGgAMCdDnejvMojIR6rt5M=;
	b=aFpl2VOoWpKc3JPy7BItW5dk3HfnEGhqRTv9aJJuVdHOCqTHo5yUS2BMfwlgCVfimCH22J
	VLBYyHYZTUp8xm0RsnMWL45s9tFAyQrma+Rrjoux6LgbqH+8YzscizE+ndSPK/8BUWVOML
	YTZggtdAb9EHqr3C+VzXiwrRLPwoAtB2nCZdkFxYOsSLKAxq+WAXQA/QafHxRAqigXT1O9
	IIp2QfEEVN7MET6TzI5te1iH+iyZifJjn5C6t5XDVnZr0qSkN+vPU26HZjQd5dgLG+k6cg
	ZCT9WObVIr0oge1TE9fXWCDdRmNgqf8Xe1yxt4h2MFaIQ1Tr0vArPtAhbINM1g==
Date: Mon, 7 Jul 2025 11:35:09 +0200
From: Pavel Machek <pavel@denx.de>
To: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: Re: [PATCH 6.12.y-cip 03/18] dt-bindings: interrupt-controller: Add
 Renesas RZ/V2H(P) Interrupt Controller
Message-ID: <aGuUzYXmn5LAxhN/@duo.ucw.cz>
References: <20250704090724.669848-1-tommaso.merciai.xr@bp.renesas.com>
 <20250704090724.669848-4-tommaso.merciai.xr@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="TQ1ee4PlG7daV8ER"
Content-Disposition: inline
In-Reply-To: <20250704090724.669848-4-tommaso.merciai.xr@bp.renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 07 Jul 2025 09:35:18 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19381


--TQ1ee4PlG7daV8ER
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> --- /dev/null
> +++ b/Documentation/devicetree/bindings/interrupt-controller/renesas,rzv2=
h-icu.yaml
> @@ -0,0 +1,278 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/interrupt-controller/renesas,rzv2h-ic=
u.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Renesas RZ/V2H(P) Interrupt Control Unit
> +
> +maintainers:
> +  - Fabrizio Castro <fabrizio.castro.jz@renesas.com>
> +  - Geert Uytterhoeven <geert+renesas@glider.be>
> +
> +allOf:
> +  - $ref: /schemas/interrupt-controller.yaml#
> +
> +description:
> +  The Interrupt Control Unit (ICU) handles external interrupts (NMI, IRQ=
, and
> +  TINT), error interrupts, DMAC requests, GPT interrupts, and internal
> +  interrupts.

I believe "," is not needed before and.

Best regards,
								Pavel

--=20
In cooperation with DENX Software Engineering GmbH, HRB 165235 Munich,
Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--TQ1ee4PlG7daV8ER
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaGuUzQAKCRAw5/Bqldv6
8tg6AJ9/layr7RnGBHhvAuqiQ8azFDFU6QCfVThc8/T5gqCZYcymUI3y88nBOfA=
=BwNV
-----END PGP SIGNATURE-----

--TQ1ee4PlG7daV8ER--

