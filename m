Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4E48C3DA7F
	for <webhook@archiver.kernel.org>; Tue, 30 Jul 2024 10:31:09 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web11.14706.1722335467485070771
 for <cip-dev@lists.cip-project.org>;
 Tue, 30 Jul 2024 03:31:07 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 0D8A11C008E; Tue, 30 Jul 2024 12:31:05 +0200 (CEST)
Date: Tue, 30 Jul 2024 12:31:04 +0200
From: Pavel Machek <pavel@denx.de>
To: cip-dev@lists.cip-project.org
Cc: "nobuhiro1.iwamatsu@toshiba.co.jp" <nobuhiro1.iwamatsu@toshiba.co.jp>
Subject: Re: [cip-dev] Adding tests for 6.10.x
Message-ID: <ZqjA6DzjBALgiwlR@duo.ucw.cz>
References: <ZqPp4nE4f1jOnJJI@duo.ucw.cz>
 <OS0PR01MB6388F7B33E56D44B35FA2B6792B62@OS0PR01MB6388.jpnprd01.prod.outlook.com>
 <TYYPR01MB1240224190BB552D4C5507154B7B72@TYYPR01MB12402.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qF2Ml/dkaQvcEZNG"
Content-Disposition: inline
In-Reply-To: <TYYPR01MB1240224190BB552D4C5507154B7B72@TYYPR01MB12402.jpnprd01.prod.outlook.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 30 Jul 2024 10:31:09 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16682


--qF2Ml/dkaQvcEZNG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > From: nobuhiro1.iwamatsu@toshiba.co.jp <nobuhiro1.iwamatsu@toshiba.co.j=
p>
> > Sent: Monday, July 29, 2024 12:59 AM
> >=20
> > Hi Pavel,
> >=20
> > I sent MR for tests for 6.10.y tree.
> >   https://gitlab.com/cip-project/cip-testing/linux-cip-pipelines/-
> > /merge_requests/59
>=20
> Thank you for this Iwamatsu-san.
> I've tested it, including updating our build docker images.
>=20
> I've also now enabled 5.10 testing in our Linux-stable-rc-ci repo.
> Here's the first run: https://gitlab.com/cip-project/cip-testing/linux-st=
able-rc-ci/-/pipelines/1391918486
>

Seems to work ok, thank you!

Best regards,
									Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--qF2Ml/dkaQvcEZNG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZqjA6AAKCRAw5/Bqldv6
8ryXAKCxdU1YnFB4Q3/MC8JTju3p+TotEwCdENevjWJMm9d7GHL3oAEm3CQ/Y0E=
=Y3+w
-----END PGP SIGNATURE-----

--qF2Ml/dkaQvcEZNG--

