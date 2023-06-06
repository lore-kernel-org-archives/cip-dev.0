Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AD25C7EE2C
	for <webhook@archiver.kernel.org>; Tue,  6 Jun 2023 09:36:10 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web10.4630.1686044160239211819
 for <cip-dev@lists.cip-project.org>;
 Tue, 06 Jun 2023 02:36:01 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id A76251C0CAF; Tue,  6 Jun 2023 11:35:57 +0200 (CEST)
Date: Tue, 6 Jun 2023 11:35:57 +0200
From: Pavel Machek <pavel@denx.de>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>,
	Chris Paterson <chris.paterson2@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH 6.1.y-cip 2/8] dt-bindings: timer: Document RZ/G2L MTU3a
 bindings
Message-ID: <ZH79/UjgYg+0Ruiu@duo.ucw.cz>
References: <20230606075235.183132-1-biju.das.jz@bp.renesas.com>
 <20230606075235.183132-3-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="QBr5nmNFjo8ks9zE"
Content-Disposition: inline
In-Reply-To: <20230606075235.183132-3-biju.das.jz@bp.renesas.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 06 Jun 2023 09:36:10 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11854


--QBr5nmNFjo8ks9zE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> commit 0a9d6b54297e216199cbfd08c5e6a35cce152477 upstream.
>=20
> The RZ/G2L multi-function timer pulse unit 3 (MTU3a) is embedded in
> the Renesas RZ/G2L family SoC's. It consists of eight 16-bit timer
> channels and one 32-bit timer channel. It supports the following
> functions
>  - Counter
>  - Timer
>  - PWM

Ok, some cleanups are possible here.

> +++ b/Documentation/devicetree/bindings/timer/renesas,rz-mtu3.yaml
> @@ -0,0 +1,302 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/timer/renesas,rz-mtu3.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Renesas RZ/G2L Multi-Function Timer Pulse Unit 3 (MTU3a)
> +
> +maintainers:
> +  - Biju Das <biju.das.jz@bp.renesas.com>
> +
> +description: |
> +  This hardware block consists of eight 16-bit timer channels and one
> +  32- bit timer channel. It supports the following specifications:

"32-bit".

> +    - Pulse input/output: 28 lines max.
> +    - Pulse input 3 lines

Lets get "." at the end of line consistent? Probably remove
them. (Please fix globally).

> +    - Count clock 11 clocks for each channel (14 clocks for MTU0, 12 clo=
cks
> +      for MTU2, and 10 clocks for MTU5, four clocks for MTU1-MTU2 combin=
ation
> +      (when LWA =3D 1))
> +    - Operating frequency Up to 100 MHz
> +    - Available operations [MTU0 to MTU4, MTU6, MTU7, and MTU8]
> +        - Waveform output on compare match
> +        - Input capture function (noise filter setting available)
> +        - Counter-clearing operation
> +        - Simultaneous writing to multiple timer counters (TCNT)
> +          (excluding MTU8).
> +        - Simultaneous clearing on compare match or input capture
> +          (excluding MTU8).
> +        - Simultaneous input and output to registers in synchronization =
with
> +          counter operations           (excluding MTU8).

"         " -> " ".

Thanks and best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--QBr5nmNFjo8ks9zE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZH79/QAKCRAw5/Bqldv6
8iMUAJ0V+OPXw5q4fEF7YSWJuJV+SXpITQCcCuu3LPz12E83iOyG1MgmUqVGoaI=
=WovO
-----END PGP SIGNATURE-----

--QBr5nmNFjo8ks9zE--

