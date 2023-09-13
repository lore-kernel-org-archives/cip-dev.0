Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BD5AEDEC73
	for <webhook@archiver.kernel.org>; Wed, 13 Sep 2023 15:17:40 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web11.1302.1694618255948750232
 for <cip-dev@lists.cip-project.org>;
 Wed, 13 Sep 2023 08:17:36 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 8898F1C001A; Wed, 13 Sep 2023 17:17:33 +0200 (CEST)
Date: Wed, 13 Sep 2023 17:17:33 +0200
From: Pavel Machek <pavel@denx.de>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: Pavel Machek <pavel@denx.de>,
	"cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: Re: [PATCH 6.1.y-cip 00/14] Enable Renesas PMIC RAA215300 and RTC
 builtin support
Message-ID: <ZQHSjW6BVwId1m9n@duo.ucw.cz>
References: <20230911162840.1115401-1-biju.das.jz@bp.renesas.com>
 <ZQDUzmyf4zQGd4fB@duo.ucw.cz>
 <OS0PR01MB59222D5B824F1694EDDA906486F0A@OS0PR01MB5922.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wROW4OkSmMgiIphM"
Content-Disposition: inline
In-Reply-To: <OS0PR01MB59222D5B824F1694EDDA906486F0A@OS0PR01MB5922.jpnprd01.prod.outlook.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 13 Sep 2023 15:17:40 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13101


--wROW4OkSmMgiIphM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > I'm happy to apply the rest (unless testing fails or someone objects). I
> > can take these two, too, if you tell me this is intentional.
>=20
> I missed to add this in cover letter. Sorry for that.
> Please take these patches as well.

Ok, testing passed, so I'm applying whole series. Thanks!

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--wROW4OkSmMgiIphM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZQHSjQAKCRAw5/Bqldv6
8g9UAJwM/c0tp2ZncEM2EwZvWxT0RSXyVgCgw8pEXTV/w+7d7Bk30qh2y578veY=
=CNsg
-----END PGP SIGNATURE-----

--wROW4OkSmMgiIphM--

