Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ECC6C433EF
	for <webhook@archiver.kernel.org>; Tue, 26 Jul 2022 11:52:03 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web12.5587.1658836312906689357
 for <cip-dev@lists.cip-project.org>;
 Tue, 26 Jul 2022 04:51:53 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id B85671C000A; Tue, 26 Jul 2022 13:51:49 +0200 (CEST)
Date: Tue, 26 Jul 2022 13:51:49 +0200
From: Pavel Machek <pavel@denx.de>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: Pavel Machek <pavel@denx.de>,
	"cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Chris Paterson <Chris.Paterson2@renesas.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [cip-dev] [PATCH 5.10.y-cip 24/24] arm64: dts: renesas:
 rzg2l-smarc: Move pinctrl definitions
Message-ID: <20220726115149.GB31613@duo.ucw.cz>
References: <20220715072244.2298757-1-biju.das.jz@bp.renesas.com>
 <20220715072244.2298757-25-biju.das.jz@bp.renesas.com>
 <20220725205326.GA2302@duo.ucw.cz>
 <TYCPR01MB5933013757A576EECDA6DF8486949@TYCPR01MB5933.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="JP+T4n/bALQSJXh8"
Content-Disposition: inline
In-Reply-To: 
 <TYCPR01MB5933013757A576EECDA6DF8486949@TYCPR01MB5933.jpnprd01.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 26 Jul 2022 11:52:03 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8929


--JP+T4n/bALQSJXh8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > This really needs subsequent patches to be useful; plus, git complains
> > about blank line at EOF. Anyway, I believe we can still take it.
>=20
> Will send support for RZ/G2LC next week. Regarding blank line, Will fix i=
t in mainline.

Thank you. The blank line may be "too trivial" to fix in separate
patch.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--JP+T4n/bALQSJXh8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCYt/VVQAKCRAw5/Bqldv6
8sqbAKCM9kK1YgDQe1Ob5ZxcKSzkcWX7AwCdFiqVa/aLXpjrLMr7ntjlAYQxWJ8=
=x5qn
-----END PGP SIGNATURE-----

--JP+T4n/bALQSJXh8--

