Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 699CFC3DA49
	for <webhook@archiver.kernel.org>; Tue, 30 Jul 2024 12:28:30 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web10.16169.1722342501591934328
 for <cip-dev@lists.cip-project.org>;
 Tue, 30 Jul 2024 05:28:21 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 1CCDF1C008E; Tue, 30 Jul 2024 14:28:20 +0200 (CEST)
Date: Tue, 30 Jul 2024 14:28:19 +0200
From: Pavel Machek <pavel@denx.de>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH 5.10.y-cip 02/13] regulator: core: Add helper for allow
 HW access to enable/disable regulator
Message-ID: <ZqjcY1fp1uw+HW5q@duo.ucw.cz>
References: <20240729153504.510443-1-biju.das.jz@bp.renesas.com>
 <20240729153504.510443-3-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Pj97QolJhJpSN5TH"
Content-Disposition: inline
In-Reply-To: <20240729153504.510443-3-biju.das.jz@bp.renesas.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 30 Jul 2024 12:28:30 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16684


--Pj97QolJhJpSN5TH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> commit 1cb7d29157603561af4c38535e936850ceb99f0f upstream.
>=20
> Add a helper function that allow regulator consumers to allow low-level
> HW access, in order to enable/disable regulator in atomic context.
>=20
> The use-case for RZ/G2L SoC is to enable VBUS selection register based
> on vbus detection that happens in interrupt context.
>=20
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> Link: https://patch.msgid.link/20240616105402.45211-4-biju.das.jz@bp.rene=
sas.com
> Signed-off-by: Mark Brown <broonie@kernel.org>
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> ---
>  Documentation/power/regulator/consumer.rst |  6 +++++
>  drivers/regulator/core.c                   | 28 ++++++++++++++++++++++
>  include/linux/regulator/consumer.h         |  7 ++++++
>  3 files changed, 41 insertions(+)
>=20
> diff --git a/Documentation/power/regulator/consumer.rst b/Documentation/p=
ower/regulator/consumer.rst
> index 0cd8cc1275a7..ebc4c8076711 100644
> --- a/Documentation/power/regulator/consumer.rst
> +++ b/Documentation/power/regulator/consumer.rst
> @@ -227,3 +227,9 @@ directly written to the voltage selector register, us=
e::
> =20
>  	int regulator_list_hardware_vsel(struct regulator *regulator,
>  					 unsigned selector);
> +
> +To access the hardware for enabling/disabling the regulator, consumers m=
ust
> +use regulator_get_exclusive(), as it can't work if there's more than one
> +consumer. To enable/disable regulator use::
> +
> +	int regulator_hardware_enable(struct regulator *regulator, bool enable);
> diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
> index 7082cffdd10e..c5b6979b2560 100644
> --- a/drivers/regulator/core.c
> +++ b/drivers/regulator/core.c
> @@ -3244,6 +3244,34 @@ int regulator_list_hardware_vsel(struct regulator =
*regulator,
>  }
>  EXPORT_SYMBOL_GPL(regulator_list_hardware_vsel);
> =20
> +/**
> + * regulator_hardware_enable - access the HW for enable/disable regulator
> + * @regulator: regulator source
> + * @enable: true for enable, false for disable
> + *
> + * Request that the regulator be enabled/disabled with the regulator out=
put at
> + * the predefined voltage or current value.

"Unlinke other functions, this can be called ...".

And fill in the blanks. "from interrupt context"? "with interrupts
disabled"? I'm not sure what real limits are. Probably can't do that
=66rom NMI?

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--Pj97QolJhJpSN5TH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZqjcYwAKCRAw5/Bqldv6
8rCgAKCZD+mWlUQKTCYTtbKJBXymiAtGFgCdHyM0We1aDRDCvAihX0SP6Gyo0OI=
=4ULR
-----END PGP SIGNATURE-----

--Pj97QolJhJpSN5TH--

