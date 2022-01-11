Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4613AC433EF
	for <webhook@archiver.kernel.org>; Tue, 11 Jan 2022 11:46:10 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web12.5886.1641901568479354416
 for <cip-dev@lists.cip-project.org>;
 Tue, 11 Jan 2022 03:46:09 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 1637C1C0B81; Tue, 11 Jan 2022 12:46:04 +0100 (CET)
Date: Tue, 11 Jan 2022 12:46:03 +0100
From: Pavel Machek <pavel@denx.de>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: Pavel Machek <pavel@denx.de>,
	"jan.kiszka@siemens.com" <jan.kiszka@siemens.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	"cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Subject: Re: Inserting patch into history was Re: [PATCH v2 5.10.y-cip 15/15]
 clk: renesas: r9a07g044: Mark IA55_CLK and DMAC_ACLK critical
Message-ID: <20220111114603.GC11620@duo.ucw.cz>
References: <20220110115348.14297-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220110115348.14297-16-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <OS0PR01MB5922EF302739734E1311CBF486509@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <20220110183329.GC3396@duo.ucw.cz>
 <OS0PR01MB5922CE45A48FB7AE84CFD0F786509@OS0PR01MB5922.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ALfTUftag+2gvp1h"
Content-Disposition: inline
In-Reply-To: 
 <OS0PR01MB5922CE45A48FB7AE84CFD0F786509@OS0PR01MB5922.jpnprd01.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 11 Jan 2022 11:46:10 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7443


--ALfTUftag+2gvp1h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > Subject: Inserting patch into history was Re: [PATCH v2 5.10.y-cip 15/1=
5]
> > clk: renesas: r9a07g044: Mark IA55_CLK and DMAC_ACLK critical
> >=20
> > Hi!
> >=20
> > > Is it possible to rearrange this patch before [1] and after [2]?
> > >
> > > [1]
> > > https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/comm
> > > it/?h=3Dlinux-5.10.y-cip&id=3Ddcbef66029571fbada7522b2db0790e5ff054c66
> > >
> > > [2]https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/c
> > > ommit/?h=3Dlinux-5.10.y-cip&id=3De2568c0c7de565a5688544907422ca470844=
df87
> > >
> >=20
> > Wow.
> >=20
> > It means changing history. We usually try to avoid that, as it will cau=
se
> > problems for people using git head. But we did not yet do a release with
> > those commits, so it is not completely out of question.
>=20
> I thought it is simple.
>=20
> Since we haven't made any release, history modification  and force pushin=
g is not required,
> as this patch will be part of upcoming release.

Ok, good. Patches passed testing (zynqmp board has problems but they
are not kernel related) and I have pushed them.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--ALfTUftag+2gvp1h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCYd1t+wAKCRAw5/Bqldv6
8jlNAJ9tQGFgerAuXU8u9tHkQVm+DwxfUACeIIwtiPQd+/IbxxNWCrwpzn190fc=
=QAqR
-----END PGP SIGNATURE-----

--ALfTUftag+2gvp1h--

