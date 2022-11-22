Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A06BCC433FE
	for <webhook@archiver.kernel.org>; Tue, 22 Nov 2022 11:25:39 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web11.16513.1669116334944341471
 for <cip-dev@lists.cip-project.org>;
 Tue, 22 Nov 2022 03:25:36 -0800
Authentication-Results: mx.groups.io;
 dkim=missing; spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id B61CB1C09DB; Tue, 22 Nov 2022 12:25:31 +0100 (CET)
Date: Tue, 22 Nov 2022 12:25:31 +0100
From: Pavel Machek <pavel@denx.de>
To: cip-dev@lists.cip-project.org
Cc: nobuhiro1.iwamatsu@toshiba.co.jp
Subject: Re: [cip-dev] 4.4-cip release
Message-ID: <Y3yxqy2b2TPWI5U6@duo.ucw.cz>
References: <1729E043E4FFBD3F.31464@lists.cip-project.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mhqif8VSDEiYvGag"
Content-Disposition: inline
In-Reply-To: <1729E043E4FFBD3F.31464@lists.cip-project.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 22 Nov 2022 11:25:39 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10070


--mhqif8VSDEiYvGag
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> I have merged 4.4-st trees to 4.4-cip, so there should be good time to
> do 4.4-cip release. (Tests are still running, but there's good chance
> they'll be ready when you'll read this).

Testing went okay here:

https://gitlab.com/cip-project/cip-kernel/linux-cip/tree/ci/pavel/linux-test

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--mhqif8VSDEiYvGag
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCY3yxqwAKCRAw5/Bqldv6
8kE1AJ9I6RVwfQho71a0mutkJOqRWzCk1QCfeRzB+Ksqlf+XzosYLSl1Sfm+OnM=
=OFUH
-----END PGP SIGNATURE-----

--mhqif8VSDEiYvGag--

