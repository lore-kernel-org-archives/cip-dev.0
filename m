Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3192CFB457
	for <webhook@archiver.kernel.org>; Mon,  7 Oct 2024 19:25:08 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web11.560.1728329099574936357
 for <cip-dev@lists.cip-project.org>;
 Mon, 07 Oct 2024 12:24:59 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 203511C0082; Mon,  7 Oct 2024 21:24:57 +0200 (CEST)
Date: Mon, 7 Oct 2024 21:24:56 +0200
From: Pavel Machek <pavel@denx.de>
To: cip-dev@lists.cip-project.org
Cc: Pavel Machek <pavel@denx.de>,
	"nobuhiro1.iwamatsu@toshiba.co.jp" <nobuhiro1.iwamatsu@toshiba.co.jp>
Subject: Re: [cip-dev] -stable testing
Message-ID: <ZwQ1iAKODwEI7ReJ@duo.ucw.cz>
References: <Zv6TWPUWmre9eyXh@duo.ucw.cz>
 <OS9PR01MB123890EF41652A158A7413EB9B77D2@OS9PR01MB12389.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="IQvo+iVd2Id451UX"
Content-Disposition: inline
In-Reply-To: <OS9PR01MB123890EF41652A158A7413EB9B77D2@OS9PR01MB12389.jpnprd01.prod.outlook.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 07 Oct 2024 19:25:08 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17011


--IQvo+iVd2Id451UX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > I'd like to test 6.6.54-rc2, but it does not seem to be mirrored in
> > gitlab, at the moment.
>=20
> Our gitlab setup only checks for changes every 3 hours.
> It ran shortly after you email, but I assume you've seen this by now.

Could we make it 30 minutes, or so?

Alternatively, there's a button in the gitlab to manually trigger the
sync, right? Is it okay if I just push it when needed?

It is here, IIRC:

https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/pipeline_sc=
hedules

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--IQvo+iVd2Id451UX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZwQ1iAAKCRAw5/Bqldv6
8iNBAJ95xa3gMo5aD92kQDdW+5w6+oceggCbB/moARQiWkN0t3yWwR5Xu15oVQA=
=6sZg
-----END PGP SIGNATURE-----

--IQvo+iVd2Id451UX--

