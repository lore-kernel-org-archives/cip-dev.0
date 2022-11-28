Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABE9DC4321E
	for <webhook@archiver.kernel.org>; Mon, 28 Nov 2022 17:49:11 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web10.124915.1669657749367334374
 for <cip-dev@lists.cip-project.org>;
 Mon, 28 Nov 2022 09:49:10 -0800
Authentication-Results: mx.groups.io;
 dkim=missing; spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 3BE421C09F6; Mon, 28 Nov 2022 18:49:06 +0100 (CET)
Date: Mon, 28 Nov 2022 18:49:05 +0100
From: Pavel Machek <pavel@denx.de>
To: nobuhiro1.iwamatsu@toshiba.co.jp
Cc: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com, pavel@denx.de,
	uli@fpond.eu, Chris.Paterson2@renesas.com,
	masami.ichikawa@cybertrust.co.jp
Subject: Re: [ANNOUNCE] Release v4.19.266-cip86 and v5.10.155-cip21
Message-ID: <Y4T0kfkdeWj/UmF4@duo.ucw.cz>
References: <TYWPR01MB9420817574A7EE194819701E92119@TYWPR01MB9420.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="fRFnebeg+9WZPrfp"
Content-Disposition: inline
In-Reply-To: <TYWPR01MB9420817574A7EE194819701E92119@TYWPR01MB9420.jpnprd01.prod.outlook.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 28 Nov 2022 17:49:11 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10126


--fRFnebeg+9WZPrfp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> CIP kernel team has released Linux kernel v4.19.266-cip86 and v5.10.155-c=
ip21.
> The linux-4.19.y-cip tree has been updated base version from v4.19.265 to=
 v4.19.266,=20
> and the linux-5.10.y-cip tree has been updated base version from
> v5.10.154 to v5.10.155.

Thank you. Is there plan for 4.4, too?

Best regards,
									Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--fRFnebeg+9WZPrfp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCY4T0kQAKCRAw5/Bqldv6
8o9xAJ9IqI3jZ2Ov5MrxQiElICpqPAFw6QCdG/yLn9HkcbR50O8u7z7MrSqf8Mw=
=quxa
-----END PGP SIGNATURE-----

--fRFnebeg+9WZPrfp--

