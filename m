Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD103C2FC0E
	for <webhook@archiver.kernel.org>; Thu, 17 Aug 2023 11:03:18 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web11.184353.1692270190483621473
 for <cip-dev@lists.cip-project.org>;
 Thu, 17 Aug 2023 04:03:11 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id CFC471C0004; Thu, 17 Aug 2023 13:03:08 +0200 (CEST)
Date: Thu, 17 Aug 2023 13:03:08 +0200
From: Pavel Machek <pavel@denx.de>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: Re: [PATCH 6.1.y-cip 01/13] regulator: dt-bindings: Add Renesas
 RAA215300 PMIC bindings
Message-ID: <ZN3+bE6uTfXf0QFL@duo.ucw.cz>
References: <20230816142458.147476-1-biju.das.jz@bp.renesas.com>
 <20230816142458.147476-2-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="9BCs3cf1N2ld0FX3"
Content-Disposition: inline
In-Reply-To: <20230816142458.147476-2-biju.das.jz@bp.renesas.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 17 Aug 2023 11:03:18 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12754


--9BCs3cf1N2ld0FX3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> +++ b/Documentation/devicetree/bindings/regulator/renesas,raa215300.yaml
> @@ -0,0 +1,85 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/regulator/renesas,raa215300.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Renesas RAA215300 Power Management Integrated Circuit (PMIC)
> +
> +maintainers:
> +  - Biju Das <biju.das.jz@bp.renesas.com>
> +
> +description: |
> +  The RAA215300 is a high-performance, low-cost 9-channel PMIC designed =
for
> +  32-bit and 64-bit MCU and MPU applications. It supports DDR3, DDR3L, D=
DR4,
> +  and LPDDR4 memory power requirements. The internally compensated regul=
ators,
> +  built-in Real-Time Clock (RTC), 32kHz crystal oscillator, and coin cell
> +  battery charger provide a highly integrated, small footprint power sol=
ution
> +  ideal for System-On-Module (SOM) applications. A spread spectrum featu=
re
> +  provides an ease-of-use solution for noise-sensitive audio or RF appli=
cations.

"an easy-to-use"?

> +    description: |
> +      The clocks are optional. The RTC is disabled, if no clocks are
> +      provided(either xin or clkin).

"If no clocks are provided (neither xin nor clkin), the RTC is
disabled"?

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--9BCs3cf1N2ld0FX3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZN3+bAAKCRAw5/Bqldv6
8jhAAJsGJBSy4/jESmKGd9wpGwhvwJUokgCbBiiR+jtyLdRTps1lrXJY+UOdhPg=
=2DuY
-----END PGP SIGNATURE-----

--9BCs3cf1N2ld0FX3--

