Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2369C27C7A
	for <webhook@archiver.kernel.org>; Thu, 17 Aug 2023 11:11:18 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web11.184448.1692270671363331106
 for <cip-dev@lists.cip-project.org>;
 Thu, 17 Aug 2023 04:11:11 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 269D21C0004; Thu, 17 Aug 2023 13:11:09 +0200 (CEST)
Date: Thu, 17 Aug 2023 13:11:08 +0200
From: Pavel Machek <pavel@denx.de>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: Re: [PATCH 6.1.y-cip 04/13] dt-bindings: rtc: isl1208: Convert to
 json-schema
Message-ID: <ZN4ATB1T3/wkN+Vo@duo.ucw.cz>
References: <20230816142458.147476-1-biju.das.jz@bp.renesas.com>
 <20230816142458.147476-5-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="QjsXS1QpuyqZ85eq"
Content-Disposition: inline
In-Reply-To: <20230816142458.147476-5-biju.das.jz@bp.renesas.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 17 Aug 2023 11:11:18 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12757


--QjsXS1QpuyqZ85eq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> +++ b/Documentation/devicetree/bindings/rtc/isil,isl1208.yaml
> @@ -0,0 +1,89 @@
> +  isil,ev-evienb:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum: [ 0, 1 ]
> +    description: |
> +      Enable or disable internal pull on EVIN pin

Add "." at end of line.

> +      Default will leave the non-volatile configuration of the pullup

"By default driver will not touch the configuration of the pullup"?

> +      as is.
> +        <0> : Enables internal pull-up on evin pin
> +        <1> : Disables internal pull-up on evin pin

Too late to change this but logic seems inverted from what
"isil,ev-evienb" suggests. Other dts-es spell xxx-pull-up.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--QjsXS1QpuyqZ85eq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZN4ATAAKCRAw5/Bqldv6
8sraAJ9PJb0xTY4IuelaEA7cQUuM2DQVSQCeJD//yV1m/ip5T3KCvCSt/HyvIu4=
=lrv9
-----END PGP SIGNATURE-----

--QjsXS1QpuyqZ85eq--

