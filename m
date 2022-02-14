Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA5CDC433EF
	for <webhook@archiver.kernel.org>; Mon, 14 Feb 2022 21:34:58 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web10.1639.1644874497123163396
 for <cip-dev@lists.cip-project.org>;
 Mon, 14 Feb 2022 13:34:58 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id AAD0F1C0B78; Mon, 14 Feb 2022 22:34:52 +0100 (CET)
Date: Mon, 14 Feb 2022 22:34:52 +0100
From: Pavel Machek <pavel@denx.de>
To: Chris Paterson <Chris.Paterson2@renesas.com>
Cc: Pavel Machek <pavel@denx.de>,
	"cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"nobuhiro1.iwamatsu@toshiba.co.jp" <nobuhiro1.iwamatsu@toshiba.co.jp>
Subject: Re: [cip-dev] 4.4.302 is going to be last 4.4 release
Message-ID: <20220214213452.GA32388@duo.ucw.cz>
References: <20220201213254.GA3001@duo.ucw.cz>
 <TYAPR01MB625279122E073EFF486368C392289@TYAPR01MB6252.jpnprd01.prod.outlook.com>
 <1ac8ef07-4bba-71ef-83da-524c1a717be0@siemens.com>
 <OSZPR01MB68774ED2525BD5F8B8AE8414B72D9@OSZPR01MB6877.jpnprd01.prod.outlook.com>
 <20220208153601.GA5021@duo.ucw.cz>
 <OSZPR01MB687737C88D75FD8F450DAA7DB72E9@OSZPR01MB6877.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="XsQoSWH+UP9D9v3l"
Content-Disposition: inline
In-Reply-To: 
 <OSZPR01MB687737C88D75FD8F450DAA7DB72E9@OSZPR01MB6877.jpnprd01.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 14 Feb 2022 21:34:58 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7600


--XsQoSWH+UP9D9v3l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed 2022-02-09 11:05:44, Chris Paterson wrote:
> > From: Pavel Machek <pavel@denx.de>
> > Sent: 08 February 2022 15:36
> >=20
> > Hi!
> >=20
> > > > > BTW, do you have any future information about the RT kernel team?
> > > > > We may also need to check the RT patch.
> > > > > If you don't have the information, I'll ask the RT team about thi=
s.
> > > >
> > > > Why should 4.4-rt continue if its former upstream retired?
> > >
> > > Didn't CIP commit to maintaining a real-time version of each SLTS for=
 the 10
> > years?
> >=20
> > We did commit to maintaining 4.4-cip-rt, but upstream 4.4.X is going
> > to be discontinued, and so is 4.4.X-stable.
>=20
> So does CIP need to maintain the stable version of RT as well as the non-=
RT stable kernel?
> Is this achievable?

My understanding is that we are maintaining both 4.4-cip and
4.4-cip-rt going forward. I hope it is achievable.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--XsQoSWH+UP9D9v3l
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCYgrK/AAKCRAw5/Bqldv6
8sUGAJ90Yn9qX/tiSstqxnXii+c9/aT4JgCgqkZxNX9erivqiyuI6Z0azUdBfQs=
=koT2
-----END PGP SIGNATURE-----

--XsQoSWH+UP9D9v3l--

