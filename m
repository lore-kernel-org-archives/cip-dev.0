Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AF9EC2FC0E
	for <webhook@archiver.kernel.org>; Thu, 17 Aug 2023 10:32:18 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web10.184173.1692268329532774243
 for <cip-dev@lists.cip-project.org>;
 Thu, 17 Aug 2023 03:32:10 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 106D41C000B; Thu, 17 Aug 2023 12:32:08 +0200 (CEST)
Date: Thu, 17 Aug 2023 12:32:07 +0200
From: Pavel Machek <pavel@denx.de>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: Pavel Machek <pavel@denx.de>,
	"cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: Re: [PATCH 6.1.y-cip 0/2] Enable PMU support for RZ/{G2L,G2LC,V2L}
 SoCs
Message-ID: <ZN33J6KkXpxtf3w9@duo.ucw.cz>
References: <20230816071239.3310-1-biju.das.jz@bp.renesas.com>
 <ZNyhaqoh6F7UKe4n@duo.ucw.cz>
 <OS0PR01MB5922F41AB4AD16AA614B5A268615A@OS0PR01MB5922.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vU/R2BaTSanpcsZh"
Content-Disposition: inline
In-Reply-To: <OS0PR01MB5922F41AB4AD16AA614B5A268615A@OS0PR01MB5922.jpnprd01.prod.outlook.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 17 Aug 2023 10:32:18 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12751


--vU/R2BaTSanpcsZh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > Subject: Re: [PATCH 6.1.y-cip 0/2] Enable PMU support for RZ/{G2L,G2LC,=
V2L}
> > SoCs
> >=20
> > Hi!
> >=20
> > > This patch series aims to enable PMU support for RZ/{G2L,G2LC,V2L}
> > > SoCs.
> > >
> > > All the patches are cherry-picked from the mainline.
> > >
> > > Lad Prabhakar (2):
> > >   arm64: dts: renesas: r9a07g044: Add Cortex-A55 PMU node
> > >   arm64: dts: renesas: r9a07g054: Add Cortex-A55 PMU node
> >=20
> > This looks okay and passes testing, so I can apply it if there are no o=
ther
> > comments. 5.10 version looks okay, too. Consider sending both
> > 5.10 and 6.1 versions in one email in cases like this :-).
>=20
> Sure.

Thanks for the patches. I applied them to 5.10 and 6.1 branches.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--vU/R2BaTSanpcsZh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZN33JwAKCRAw5/Bqldv6
8qSYAJ9xQEivRrDuoffWwDhCC4edSyU47wCfRZbVXf33oBwElgEip9OKh/cCL8Y=
=CCwu
-----END PGP SIGNATURE-----

--vU/R2BaTSanpcsZh--

