Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E206C6FD18
	for <webhook@archiver.kernel.org>; Tue, 25 Apr 2023 09:13:17 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web10.75092.1682413995596293948
 for <cip-dev@lists.cip-project.org>;
 Tue, 25 Apr 2023 02:13:16 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id D3CAE1C0ABB; Tue, 25 Apr 2023 11:13:11 +0200 (CEST)
Date: Tue, 25 Apr 2023 11:13:11 +0200
From: Pavel Machek <pavel@denx.de>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: Pavel Machek <pavel@denx.de>,
	"cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Chris Paterson <Chris.Paterson2@renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Subject: Re: [PATCH 5.10.y-cip 00/33] Add RZ/V2M support
Message-ID: <ZEeZpxoHPG6uDVqN@duo.ucw.cz>
References: <20230421071729.130347-1-biju.das.jz@bp.renesas.com>
 <ZEJrgRY3NwUu3j7D@duo.ucw.cz>
 <OS0PR01MB5922F02A188EA782155E706386609@OS0PR01MB5922.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vfO866K6YFAxVxU7"
Content-Disposition: inline
In-Reply-To: <OS0PR01MB5922F02A188EA782155E706386609@OS0PR01MB5922.jpnprd01.prod.outlook.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 25 Apr 2023 09:13:17 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11338


--vfO866K6YFAxVxU7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > > All these patches are cherry-picked from the mainline.
> >=20
> > Ok. Well likely need to backport these to 6.1.X, too, but I suppose that
> > will not be hard.
>=20
> OK, we will look into it when CIP publishes a 6.1 branch.

Thank you, applied.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--vfO866K6YFAxVxU7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZEeZpwAKCRAw5/Bqldv6
8ovcAKC9tQG+x3vTr63uhc967gfD+fwXYwCgns8EsnkYJedFAFeTFMNPZsPzk2o=
=/cUZ
-----END PGP SIGNATURE-----

--vfO866K6YFAxVxU7--

