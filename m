Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66908C001DE
	for <webhook@archiver.kernel.org>; Tue, 25 Jul 2023 10:48:13 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web10.17344.1690282086888394564
 for <cip-dev@lists.cip-project.org>;
 Tue, 25 Jul 2023 03:48:07 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 2CAF01C0A95; Tue, 25 Jul 2023 12:48:03 +0200 (CEST)
Date: Tue, 25 Jul 2023 12:48:02 +0200
From: Pavel Machek <pavel@denx.de>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: Pavel Machek <pavel@denx.de>,
	"cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Subject: Re: [PATCH 5.10.y-cip] pinctrl: renesas: rzg2l: Handle non-unique
 subnode names
Message-ID: <ZL+oYtESDBDZIG4H@duo.ucw.cz>
References: <20230721095859.280864-1-biju.das.jz@bp.renesas.com>
 <ZLu+AAp7waAEQZzv@duo.ucw.cz>
 <OS0PR01MB5922F8F360A1121F8D680FFF863CA@OS0PR01MB5922.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="isPND3B0qn0Dr08e"
Content-Disposition: inline
In-Reply-To: <OS0PR01MB5922F8F360A1121F8D680FFF863CA@OS0PR01MB5922.jpnprd01.prod.outlook.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 25 Jul 2023 10:48:13 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12501


--isPND3B0qn0Dr08e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > I believe we want this for 6.1, too. I can apply it there, too.
>=20
> For 6.1, It will be taken care by stable, we just need to wait for it to =
hit 6.1 stable.

Aha, ok, thanks for explanation. Anyway, I applied the patch.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--isPND3B0qn0Dr08e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZL+oYgAKCRAw5/Bqldv6
8kAaAJ9+H0dp3EC3bum6USaFcGPNO84YTQCfaK8P+5NHeUHtcf5Lva7zBEsbvuo=
=V1n0
-----END PGP SIGNATURE-----

--isPND3B0qn0Dr08e--

