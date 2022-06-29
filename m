Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04FB1C43334
	for <webhook@archiver.kernel.org>; Wed, 29 Jun 2022 15:45:25 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web12.13245.1656517522347653129
 for <cip-dev@lists.cip-project.org>;
 Wed, 29 Jun 2022 08:45:23 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 3C0791C0B8F; Wed, 29 Jun 2022 17:45:19 +0200 (CEST)
Date: Wed, 29 Jun 2022 17:45:18 +0200
From: Pavel Machek <pavel@denx.de>
To: nobuhiro1.iwamatsu@toshiba.co.jp
Cc: cip-dev@lists.cip-project.org, pavel@denx.de, uli@fpond.eu,
	masami.ichikawa@cybertrust.co.jp, jan.kiszka@siemens.com,
	Chris.Paterson2@renesas.com
Subject: Re: [ANNOUNCE] Release v4.19.249-cip76 and v5.10.125-cip10
Message-ID: <20220629154518.GA32481@duo.ucw.cz>
References: 
 <TYWPR01MB9420A4CEE36E4B536184CBA992B89@TYWPR01MB9420.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="cNdxnHkX5QqsyA0e"
Content-Disposition: inline
In-Reply-To: 
 <TYWPR01MB9420A4CEE36E4B536184CBA992B89@TYWPR01MB9420.jpnprd01.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 29 Jun 2022 15:45:25 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8625


--cNdxnHkX5QqsyA0e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

>   v5.10.125-cip10:
>     repository:
>       https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git

5.10.125 was immediately followed up by 5.10.126 due to bug in
io_uring. If you use that functionality, you may want to speak up.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--cNdxnHkX5QqsyA0e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCYrxzjgAKCRAw5/Bqldv6
8gWrAKCK8KGxF99uH2usDkFzQl1l2Dz4rgCfdC7ixyRcsZVchgK4i/I0k0Oj8Vs=
=15T/
-----END PGP SIGNATURE-----

--cNdxnHkX5QqsyA0e--

