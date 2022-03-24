Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6272C433F5
	for <webhook@archiver.kernel.org>; Thu, 24 Mar 2022 19:05:42 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web11.15251.1648148741114748253
 for <cip-dev@lists.cip-project.org>;
 Thu, 24 Mar 2022 12:05:42 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id DA8771C0B87; Thu, 24 Mar 2022 20:05:35 +0100 (CET)
Date: Thu, 24 Mar 2022 20:05:35 +0100
From: Pavel Machek <pavel@denx.de>
To: nobuhiro1.iwamatsu@toshiba.co.jp
Cc: pavel@denx.de, cip-dev@lists.cip-project.org
Subject: Re: Doing 4.4-cip release
Message-ID: <20220324190535.GA6144@duo.ucw.cz>
References: <20220321083518.GA18233@amd>
 <TYAPR01MB62522189BBBBAE46DEA125DD92199@TYAPR01MB6252.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="pf9I7BMVVzbSWLtt"
Content-Disposition: inline
In-Reply-To: 
 <TYAPR01MB62522189BBBBAE46DEA125DD92199@TYAPR01MB6252.jpnprd01.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 24 Mar 2022 19:05:42 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7821


--pf9I7BMVVzbSWLtt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > linux-4.4.y-cip tree should be up-to-date with changes from 4.9.305 and=
 older.
> >=20
> > I believe it may be good time to do 4.4.x release; last release of 4.4.=
y-cip was at
> > Feb 14, and 4.9.306 contains speculation fixes that are rather intrusiv=
e... so it
> > may be good time to test that we did a good job on the easy changes.=09
>=20
> I see.
> BTW, linux-4.4.y-st tree, do you have any idea to have a git tag? When me=
rging into cip tree,
> I think the tags make it easier to manage. For example, create a tag the =
string contained in
> localversion-st file.

Good idea. I pushed the tag, v4.4-st5 . (I plan to keep the tag in
sync with 4.9: 4.9.30X should correspond to v4.4-stX).

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--pf9I7BMVVzbSWLtt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCYjzA/wAKCRAw5/Bqldv6
8glsAJsGbOHrDlX83MdPwxzeY9MiTOUhXgCgoY7q7cjz822clPbBk9xeYsfJchE=
=sQq2
-----END PGP SIGNATURE-----

--pf9I7BMVVzbSWLtt--

