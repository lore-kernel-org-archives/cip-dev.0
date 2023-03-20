Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09A6BC6FD1C
	for <webhook@archiver.kernel.org>; Mon, 20 Mar 2023 19:24:23 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web11.2706.1679340256808250548
 for <cip-dev@lists.cip-project.org>;
 Mon, 20 Mar 2023 12:24:17 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 4BED51C0DC0; Mon, 20 Mar 2023 20:24:13 +0100 (CET)
Date: Mon, 20 Mar 2023 20:24:12 +0100
From: Pavel Machek <pavel@denx.de>
To: nobuhiro1.iwamatsu@toshiba.co.jp
Cc: pavel@denx.de, cip-dev@lists.cip-project.org, jan.kiszka@siemens.com,
	uli@fpond.eu, Chris.Paterson2@renesas.com,
	masami.ichikawa@cybertrust.co.jp
Subject: Re: [ANNOUNCE] Release v4.19.276-cip93 and v5.10.173-cip28
Message-ID: <ZBiy3GCOwQHlBi3D@duo.ucw.cz>
References: <TYWPR01MB9420840010270BB35057B68892B99@TYWPR01MB9420.jpnprd01.prod.outlook.com>
 <ZBdAiL2EPlrQ02rd@duo.ucw.cz>
 <TYWPR01MB9420097CC9A29DF57C4005E392809@TYWPR01MB9420.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0XPTA0mu6BoRkFU2"
Content-Disposition: inline
In-Reply-To: <TYWPR01MB9420097CC9A29DF57C4005E392809@TYWPR01MB9420.jpnprd01.prod.outlook.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 20 Mar 2023 19:24:23 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11038


--0XPTA0mu6BoRkFU2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > > CIP kernel team has released Linux kernel v4.19.276-cip93 and
> > >  v5.10.173-cip28 The linux-4.19.y-cip tree has been updated base
> > > version from v4.19.273 to v4.19.276, and linux-5.10.y-cip tree has
> > > been updated base version from v5.10.168 to v5.10.173.
> >=20
> > What are the plans for 4.19?
> >=20
> > 4.19-rt is due around now. There's suitable -rt
> >=20
> > Date:   Thu Mar 16 08:05:18 2023 +0100
> >     Linux 4.19.277-rt122
> >=20
> > . Could I ask for matching -cip?
> >
>=20
> Yes, I will release -cip to match -rt.

Thank you. It looks like 5.10.175-cip would be useful, too.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--0XPTA0mu6BoRkFU2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZBiy3AAKCRAw5/Bqldv6
8nidAKClOPgBSgMMsB70k+jJ8jVDyAR0+gCghraKMtiWXYm0eaZpY8DettBlc0I=
=QTOX
-----END PGP SIGNATURE-----

--0XPTA0mu6BoRkFU2--

