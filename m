Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2DBEC433FE
	for <webhook@archiver.kernel.org>; Fri, 30 Sep 2022 08:41:17 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web08.3556.1664527266864096158
 for <cip-dev@lists.cip-project.org>;
 Fri, 30 Sep 2022 01:41:07 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 0287F1C0017; Fri, 30 Sep 2022 10:41:03 +0200 (CEST)
Date: Fri, 30 Sep 2022 10:41:02 +0200
From: Pavel Machek <pavel@denx.de>
To: nobuhiro1.iwamatsu@toshiba.co.jp
Cc: cip-dev@lists.cip-project.org, florian.bezdeka@siemens.com,
	pavel@denx.de, masami.ichikawa@cybertrust.co.jp,
	jan.kiszka@siemens.com, Chris.Paterson2@renesas.com, uli@fpond.eu
Subject: Re: [cip-dev] [ANNOUNCE] Release v4.19.259-cip82 and v5.10.145-cip17
Message-ID: <20220930084101.GA13099@amd>
References: 
 <TYWPR01MB9420C94EE9CFD1EF537FA50B92529@TYWPR01MB9420.jpnprd01.prod.outlook.com>
 <1f6e6c23574f42073aba6afe27386c500c44473f.camel@siemens.com>
 <20220926132359.GA21302@duo.ucw.cz>
 <TYWPR01MB9420DF3BE19B60B7CCFAA25792549@TYWPR01MB9420.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="cWoXeonUoKmBZSoM"
Content-Disposition: inline
In-Reply-To: 
 <TYWPR01MB9420DF3BE19B60B7CCFAA25792549@TYWPR01MB9420.jpnprd01.prod.outlook.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 30 Sep 2022 08:41:17 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9577


--cWoXeonUoKmBZSoM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > > > The linux-4.19.y-cip tree has been updated base version from
> > > > v4.19.257 to v4.19.259, and the linux-5.10.y-cip tree has been
> > > > updated base version from
> > > > v5.10.140 to v5.10.145.

=2E..

> Right, I forgot to push to repository...
> I pushed yesterday afternoon (14:00 JST), so it is updated.

I see the updates now.

There's good match of v5.10.145-cip17, v5.10.145-rt74, I'll likely get
advantage of that.

On 4.19 side, last -rt is Aug 13, Linux 4.19.255-rt113. I'd like
matchig -cip release when next 4.19-rt is released.

Thank you and best regards, =20
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--cWoXeonUoKmBZSoM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAmM2q50ACgkQMOfwapXb+vI7WACguuSeUVtaKXQtGS0hjEyd0aba
exIAoMEOMoII6IUHHjT4MFO5atSxLzhB
=kLPW
-----END PGP SIGNATURE-----

--cWoXeonUoKmBZSoM--

