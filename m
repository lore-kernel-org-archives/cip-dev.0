Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2AF5C05052
	for <webhook@archiver.kernel.org>; Fri, 18 Aug 2023 07:31:40 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web11.6640.1692343898657891261
 for <cip-dev@lists.cip-project.org>;
 Fri, 18 Aug 2023 00:31:39 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 2BED31C0004; Fri, 18 Aug 2023 09:31:37 +0200 (CEST)
Date: Fri, 18 Aug 2023 09:31:36 +0200
From: Pavel Machek <pavel@denx.de>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: Pavel Machek <pavel@denx.de>,
	"cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: Re: [PATCH 6.1.y-cip 02/13] regulator: Add Renesas PMIC RAA215300
 driver
Message-ID: <ZN8eWPfNz0Q/v2vg@duo.ucw.cz>
References: <20230816142458.147476-1-biju.das.jz@bp.renesas.com>
 <20230816142458.147476-3-biju.das.jz@bp.renesas.com>
 <ZN3/SjL50ls+3dnD@duo.ucw.cz>
 <OS0PR01MB5922BA551BDB1C3BDBA8EAC2861AA@OS0PR01MB5922.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Qr4eLJMuDvpHcb1a"
Content-Disposition: inline
In-Reply-To: <OS0PR01MB5922BA551BDB1C3BDBA8EAC2861AA@OS0PR01MB5922.jpnprd01.prod.outlook.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 18 Aug 2023 07:31:40 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12770


--Qr4eLJMuDvpHcb1a
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > > +	/*Clear the latched registers */
> >=20
> > "/* Clear". I would not mind checking errors from regmap here.
>=20
> OK, will fix it. I checked most of the drivers are not doing
> Checks for regmap in kernel. As you suggested will do it here.

Up to you really. I doubt regmap will fail in any real situation. I
just noticed because you do check errors on the first one.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--Qr4eLJMuDvpHcb1a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZN8eWAAKCRAw5/Bqldv6
8mJIAJ9BFmK7roVzaXmY/eqIHRRCnnYelQCfQlgfEp+wGB/Xk1KeqQ5z7toP+OY=
=x7wh
-----END PGP SIGNATURE-----

--Qr4eLJMuDvpHcb1a--

