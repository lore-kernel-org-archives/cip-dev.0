Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 108A5C3DA42
	for <webhook@archiver.kernel.org>; Wed, 17 Jul 2024 11:10:14 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web10.12725.1721214612230532146
 for <cip-dev@lists.cip-project.org>;
 Wed, 17 Jul 2024 04:10:12 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id BF3021C009C; Wed, 17 Jul 2024 13:10:09 +0200 (CEST)
Date: Wed, 17 Jul 2024 13:10:09 +0200
From: Pavel Machek <pavel@denx.de>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH 5.10.y-cip 23/31] dt-bindings: watchdog: da9062-wdt:
 convert txt to yaml
Message-ID: <ZpemkYsK6zQgGCF2@duo.ucw.cz>
References: <20240716082255.56551-1-biju.das.jz@bp.renesas.com>
 <20240716082255.56551-24-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="j0DNaiDyau8s0gjV"
Content-Disposition: inline
In-Reply-To: <20240716082255.56551-24-biju.das.jz@bp.renesas.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 17 Jul 2024 11:10:14 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16563


--j0DNaiDyau8s0gjV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

Its really nit-picking, but git complains about trailing space here:

> --- /dev/null
> +++ b/Documentation/devicetree/bindings/watchdog/dlg,da9062-watchdog.yaml
> +      Only use this option if you can't use the watchdog automatic suspe=
nd
> +      function during a suspend (see register CONTROL_B).
> + =20
> +  dlg,wdt-sd:
> +    $ref: /schemas/types.yaml#/definitions/uint32

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--j0DNaiDyau8s0gjV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZpemkQAKCRAw5/Bqldv6
8s5LAJ4ueCkETUZYhabHnVwqcq+ZmS+7EgCfY6uJc9+MRnW6SwlN+HwOF3ealYc=
=ykLS
-----END PGP SIGNATURE-----

--j0DNaiDyau8s0gjV--

