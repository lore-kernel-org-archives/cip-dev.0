Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCF7DC4332F
	for <webhook@archiver.kernel.org>; Thu,  3 Nov 2022 08:16:20 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web10.16779.1667463377985977324
 for <cip-dev@lists.cip-project.org>;
 Thu, 03 Nov 2022 01:16:19 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 4863A1C09DB; Thu,  3 Nov 2022 09:16:15 +0100 (CET)
Date: Thu, 3 Nov 2022 09:16:14 +0100
From: Pavel Machek <pavel@denx.de>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: Pavel Machek <pavel@denx.de>,
	"cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Chris Paterson <Chris.Paterson2@renesas.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH 5.10.y-cip] can: rcar_canfd: fix channel specific IRQ
 handling for RZ/G2L
Message-ID: <20221103081614.GC12403@duo.ucw.cz>
References: <20221102190200.1166569-1-biju.das.jz@bp.renesas.com>
 <20221103074354.GA12403@duo.ucw.cz>
 <OS0PR01MB59224E2B90A0FD095A1AC8B186389@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <20221103075947.GB12403@duo.ucw.cz>
 <OS0PR01MB5922ED582C321250F2BDB24686389@OS0PR01MB5922.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="9Ek0hoCL9XbhcSqy"
Content-Disposition: inline
In-Reply-To: <OS0PR01MB5922ED582C321250F2BDB24686389@OS0PR01MB5922.jpnprd01.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 03 Nov 2022 08:16:20 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9901


--9Ek0hoCL9XbhcSqy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > > For eg: if ch0 IRQ is triggered you are checking for ch1 IRQ status
> > as
> > > well. Similarly, if ch1 IRQ is triggered, then you are checking ch0
> > > IRQ status.
> >=20
> > Understood, but checking ch1 status on ch0 IRQ is not going to cause
> > any problems, right?
>=20
> IRQ processing should be fast as possible. You are improving latency of=
=20
> the system by avoiding unnecessary checks and by calling an unwanted func=
tion call.
>=20
> If it is shared IRQ, then it make sense you don't have any other alternat=
ive.
> Since you have dedicated handler, make use of it and don't call any
> Unnecessary function and checks in IRQ routine.

I understand it is just a performance tweak. Correct me if I'm wrong.

If there are no other comments and if testing passes I can apply the
patch.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--9Ek0hoCL9XbhcSqy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCY2N4zgAKCRAw5/Bqldv6
8lFXAJ4izuxXPnVqMVqPLskmKjLOCVZ3wQCeOK8wgh3G02QbnsGFwOOXsZCZcGo=
=LiYT
-----END PGP SIGNATURE-----

--9Ek0hoCL9XbhcSqy--

