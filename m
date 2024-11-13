Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CB6CD41C17
	for <webhook@archiver.kernel.org>; Wed, 13 Nov 2024 08:22:40 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web11.7110.1731486150970400166
 for <cip-dev@lists.cip-project.org>;
 Wed, 13 Nov 2024 00:22:31 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=fail (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 4042C1C00A0; Wed, 13 Nov 2024 09:22:29 +0100 (CET)
Date: Wed, 13 Nov 2024 09:22:28 +0100
From: Pavel Machek <pavel@denx.de>
To: cip-dev@lists.cip-project.org
Cc: nobuhiro1.iwamatsu@toshiba.co.jp, jan.kiszka@siemens.com, pavel@denx.de,
	uli@fpond.eu, masami.ichikawa@cybertrust.co.jp,
	Chris.Paterson2@renesas.com
Subject: Re: [cip-dev] [ANNOUNCE] Release v4.19.323-cip114 and v5.10.226-cip54
Message-ID: <ZzRhxEmkMK+9S6aQ@duo.ucw.cz>
References: <OS3PR01MB6391DAC4B6A1B643A7D2218D925A2@OS3PR01MB6391.jpnprd01.prod.outlook.com>
 <180779152CF0DBD4.27286@lists.cip-project.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jf5skbMeg9vDM0Zw"
Content-Disposition: inline
In-Reply-To: <180779152CF0DBD4.27286@lists.cip-project.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 13 Nov 2024 08:22:40 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17245


--jf5skbMeg9vDM0Zw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > CIP kernel team has released Linux kernel v4.19.323-cip114 and v5.10.22=
6-cip54.
> ...
> > the linux-5.10.y-cip tree has been updated base version from v5.10.226 =
to v5.10.226.
> >
>=20
> Ok, so according to this, base version did not change,

So I believe announcement is wrong -- it is v5.10.229-cip54, but
release is okay and tags are correct, too. -rebase branch seems to be
ok, too.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--jf5skbMeg9vDM0Zw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZzRhxAAKCRAw5/Bqldv6
8gyDAKCJtSjQQxdwknc3CDuHaADrSoYUbwCgwgc3BsekkwDdvsCjEd5tR6lVF44=
=+GeK
-----END PGP SIGNATURE-----

--jf5skbMeg9vDM0Zw--

