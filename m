Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66BFAC32771
	for <webhook@archiver.kernel.org>; Mon, 26 Sep 2022 13:24:08 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web09.28527.1664198643615003494
 for <cip-dev@lists.cip-project.org>;
 Mon, 26 Sep 2022 06:24:04 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 190C51C0016; Mon, 26 Sep 2022 15:24:00 +0200 (CEST)
Date: Mon, 26 Sep 2022 15:23:59 +0200
From: Pavel Machek <pavel@denx.de>
To: "Bezdeka, Florian" <florian.bezdeka@siemens.com>
Cc: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"pavel@denx.de" <pavel@denx.de>,
	"masami.ichikawa@cybertrust.co.jp" <masami.ichikawa@cybertrust.co.jp>,
	"jan.kiszka@siemens.com" <jan.kiszka@siemens.com>,
	"Chris.Paterson2@renesas.com" <Chris.Paterson2@renesas.com>,
	"uli@fpond.eu" <uli@fpond.eu>
Subject: Re: [cip-dev] [ANNOUNCE] Release v4.19.259-cip82 and v5.10.145-cip17
Message-ID: <20220926132359.GA21302@duo.ucw.cz>
References: 
 <TYWPR01MB9420C94EE9CFD1EF537FA50B92529@TYWPR01MB9420.jpnprd01.prod.outlook.com>
 <1f6e6c23574f42073aba6afe27386c500c44473f.camel@siemens.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ZPt4rx8FFjLCG7dd"
Content-Disposition: inline
In-Reply-To: <1f6e6c23574f42073aba6afe27386c500c44473f.camel@siemens.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 26 Sep 2022 13:24:08 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9546


--ZPt4rx8FFjLCG7dd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > CIP kernel team has released Linux kernel v4.19.259-cip82 v5.10.145-cip=
17.
> > The linux-4.19.y-cip tree has been updated base version from v4.19.257 =
to
> > v4.19.259, and the linux-5.10.y-cip tree has been updated base version =
=66rom
> > v5.10.140 to v5.10.145.
> >=20
> > You can get this release via the git tree at:
> >=20
> >   v4.19.259-cip82:
> >     repository:
> >       https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
>=20
> Nope. The git tree hasn't been updated yet, or is this kind of delay
> expected (mirroring)?

That would be a bit long for a delay, I guess this is a case of missed
push.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--ZPt4rx8FFjLCG7dd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCYzGn7wAKCRAw5/Bqldv6
8nWNAJ4/Qj22kPE3aoIxbaRvkxDWjseeWQCgwMhE74TwTmBh+1fcc8/cSuvkh9c=
=Mf0v
-----END PGP SIGNATURE-----

--ZPt4rx8FFjLCG7dd--

