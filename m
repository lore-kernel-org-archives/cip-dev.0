Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 919F9C3DA7F
	for <webhook@archiver.kernel.org>; Wed, 31 Jul 2024 10:06:17 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web11.39649.1722420367354129043
 for <cip-dev@lists.cip-project.org>;
 Wed, 31 Jul 2024 03:06:07 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id CC4C61C0082; Wed, 31 Jul 2024 12:06:04 +0200 (CEST)
Date: Wed, 31 Jul 2024 12:06:04 +0200
From: Pavel Machek <pavel@denx.de>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: Pavel Machek <pavel@denx.de>,
	"cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH 5.10.y-cip 02/13] regulator: core: Add helper for allow
 HW access to enable/disable regulator
Message-ID: <ZqoMjD5bskPB3Qzq@duo.ucw.cz>
References: <20240729153504.510443-1-biju.das.jz@bp.renesas.com>
 <20240729153504.510443-3-biju.das.jz@bp.renesas.com>
 <ZqjcY1fp1uw+HW5q@duo.ucw.cz>
 <TY3PR01MB11346EB79E7AB9D5CECF88C4086B02@TY3PR01MB11346.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="p6/okJgQZgIHgSWS"
Content-Disposition: inline
In-Reply-To: <TY3PR01MB11346EB79E7AB9D5CECF88C4086B02@TY3PR01MB11346.jpnprd01.prod.outlook.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 31 Jul 2024 10:06:17 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16693


--p6/okJgQZgIHgSWS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > > +++ b/drivers/regulator/core.c
> > > @@ -3244,6 +3244,34 @@ int regulator_list_hardware_vsel(struct
> > > regulator *regulator,  }
> > > EXPORT_SYMBOL_GPL(regulator_list_hardware_vsel);
> > >
> > > +/**
> > > + * regulator_hardware_enable - access the HW for enable/disable
> > > +regulator
> > > + * @regulator: regulator source
> > > + * @enable: true for enable, false for disable
> > > + *
> > > + * Request that the regulator be enabled/disabled with the regulator
> > > +output at
> > > + * the predefined voltage or current value.
> >=20
> > "Unlinke other functions, this can be called ...".
> >=20
> > And fill in the blanks. "from interrupt context"? "with interrupts disa=
bled"? I'm not sure what real
> > limits are. Probably can't do that from NMI?
>=20
> From interrupt context provided the callback function does not uses any s=
leeping calls.

So the contexts allowed differ based on what low-level driver is used?
That's quite unfortunate...

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--p6/okJgQZgIHgSWS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZqoMjAAKCRAw5/Bqldv6
8t5xAJ9klmCZqnPfO3NVVWks0lrnkCBvTgCeIgJesUCPXqWsxCf0UJtJLR6NZdM=
=2YQ6
-----END PGP SIGNATURE-----

--p6/okJgQZgIHgSWS--

