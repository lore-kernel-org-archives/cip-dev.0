Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2A41C433F5
	for <webhook@archiver.kernel.org>; Thu, 31 Mar 2022 10:22:25 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web11.5386.1648722144216906169
 for <cip-dev@lists.cip-project.org>;
 Thu, 31 Mar 2022 03:22:25 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id B108B1C0B98; Thu, 31 Mar 2022 12:22:22 +0200 (CEST)
Date: Thu, 31 Mar 2022 12:22:21 +0200
From: Pavel Machek <pavel@denx.de>
To: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>, Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [PATCH 5.10.y-cip 32/39] dt-bindings: Drop redundant
 minItems/maxItems
Message-ID: <20220331102221.GF21513@amd>
References: <20220330185454.10887-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220330185454.10887-33-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jkO+KyKz7TfD21mV"
Content-Disposition: inline
In-Reply-To: <20220330185454.10887-33-prabhakar.mahadev-lad.rj@bp.renesas.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 31 Mar 2022 10:22:25 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7900


--jkO+KyKz7TfD21mV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This condition is partially checked with the meta-schema already, but
> only if both 'minItems' and 'maxItems' are equal to the 'items' length.
> An improved meta-schema is pending.

Do we have the improved meta-scheme in 5.10.X? Are we actually running
the dts schema checks?

I guess it is not a big deal either way.

Best regards,
								Pavel

> +++ b/Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml
> @@ -74,7 +74,6 @@ properties:
> =20
>    clock-names:
>      minItems: 1
> -    maxItems: 2
>      items:
>        - const: core
>        - const: cd
> @@ -106,7 +105,6 @@ properties:
> =20
>    pinctrl-names:
>      minItems: 1
> -    maxItems: 2
>      items:
>        - const: default
>        - const: state_uhs

--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--jkO+KyKz7TfD21mV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAmJFgN0ACgkQMOfwapXb+vIITACgsnQk+jGUvulfnSHFfJevQj53
fAcAn37pYR5xLzW4Gw2iUXRVtIAWjTx4
=DsjZ
-----END PGP SIGNATURE-----

--jkO+KyKz7TfD21mV--

