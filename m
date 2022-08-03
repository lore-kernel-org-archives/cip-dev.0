Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98FFBC19F28
	for <webhook@archiver.kernel.org>; Wed,  3 Aug 2022 13:51:03 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web10.8632.1659534654344070461
 for <cip-dev@lists.cip-project.org>;
 Wed, 03 Aug 2022 06:50:55 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id D89091C0004; Wed,  3 Aug 2022 15:50:52 +0200 (CEST)
Date: Wed, 3 Aug 2022 15:50:52 +0200
From: Pavel Machek <pavel@denx.de>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: Pavel Machek <pavel@denx.de>,
	"nobuhiro1.iwamatsu@toshiba.co.jp" <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	"cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Subject: Re: [PATCH 5.10.y-cip 10/24] clk: renesas: rzg2l-cpg: Add support
 for RZ/V2L SoC
Message-ID: <20220803135052.GB4038@duo.ucw.cz>
References: <20220802110850.1496057-1-biju.das.jz@bp.renesas.com>
 <20220802110850.1496057-11-biju.das.jz@bp.renesas.com>
 <20220802165407.GB9523@duo.ucw.cz>
 <OS0PR01MB5922C7909AE27C0EE5B1514C869C9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4bRzO86E/ozDv8r1"
Content-Disposition: inline
In-Reply-To: 
 <OS0PR01MB5922C7909AE27C0EE5B1514C869C9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 03 Aug 2022 13:51:03 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9048


--4bRzO86E/ozDv8r1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > If you enable CONFIG_CLK_R9A07G044, you get g044 support but not g054
> > support.
> >=20
> > If you enable CONFIG_CLK_R9A07G054, you get both g044 and g054 support,
> > you can't disable g044.
>=20
> This is not true, we can disable g044 still. see rzg2l_cpg.c, there is a =
guard
> for CONFIG_CLK_R9A07G044.
>=20
> In this case,We will get unused variable warning for r9a07g044_cpg_info.
>=20
> >=20
> > This is quite strange, but probably not a problem. For symmetry, I'd not
> > mind conditional compilation of g044 parts;=20
>=20
> OK, will send patch for adding guard for r9a07g044_cpg_info.

Thank you.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--4bRzO86E/ozDv8r1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCYup9PAAKCRAw5/Bqldv6
8hvCAJ0S6rGnmRa2P8X2O8FKpi6PlxeFhACfeBZ9jdqJn1yK1wnYSbU7+MkRuuI=
=8/C5
-----END PGP SIGNATURE-----

--4bRzO86E/ozDv8r1--

