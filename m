Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 505B5C43334
	for <webhook@archiver.kernel.org>; Mon, 25 Jul 2022 11:41:17 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web12.26968.1658749275026043931
 for <cip-dev@lists.cip-project.org>;
 Mon, 25 Jul 2022 04:41:15 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 76F501C0004; Mon, 25 Jul 2022 13:41:11 +0200 (CEST)
Date: Mon, 25 Jul 2022 13:41:10 +0200
From: Pavel Machek <pavel@denx.de>
To: nobuhiro1.iwamatsu@toshiba.co.jp
Cc: pavel@denx.de, biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	cip-dev@lists.cip-project.org
Subject: Re: [PATCH v2 5.10.y-cip 00/12] Add thermal driver and watchdog
 driver enhancements
Message-ID: <20220725114110.GA4516@duo.ucw.cz>
References: <20220718092430.382889-1-biju.das.jz@bp.renesas.com>
 <YtcJMyA+/T0z+FWS@pollux.denx.de>
 <TYWPR01MB9420BA71EAB56F360A3056EC92919@TYWPR01MB9420.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gKMricLos+KVdGMg"
Content-Disposition: inline
In-Reply-To: 
 <TYWPR01MB9420BA71EAB56F360A3056EC92919@TYWPR01MB9420.jpnprd01.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 25 Jul 2022 11:41:17 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8901


--gKMricLos+KVdGMg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > Thanks for the series and for the fixes headed for mainline. The patche=
s look
> > good to me (but I can't test/apply them due to poor network access at t=
he
> > moment).
>=20
> Sorry for the late review.
> I reviewed this patch series and found no pointout.
>=20
> > I can probably do that on Friday, but I suspect Iwamatsu may be
> > faster.
>=20
> Yeah, I will apply this series and push.

I applied the series, tested it, and pushed out the result. Hopefully
that is okay.

Thanks for the patches, Biju.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--gKMricLos+KVdGMg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCYt6BVgAKCRAw5/Bqldv6
8jKWAJ9fZEqc55/TpwMBMecxnKQO1dsUqACfSHvGDLLLtEIfDtdWx50fqJPeuXg=
=Xosh
-----END PGP SIGNATURE-----

--gKMricLos+KVdGMg--

