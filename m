Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B397CC3DA7F
	for <webhook@archiver.kernel.org>; Sat, 10 Aug 2024 20:25:21 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web10.12662.1723321519037093810
 for <cip-dev@lists.cip-project.org>;
 Sat, 10 Aug 2024 13:25:19 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 7059D1C0099; Sat, 10 Aug 2024 22:25:16 +0200 (CEST)
Date: Sat, 10 Aug 2024 22:25:15 +0200
From: Pavel Machek <pavel@denx.de>
To: nobuhiro1.iwamatsu@toshiba.co.jp
Cc: cip-dev@lists.cip-project.org, pavel@denx.de, jan.kiszka@siemens.com,
	masami.ichikawa@cybertrust.co.jp, uli@fpond.eu,
	Chris.Paterson2@renesas.com
Subject: Re: [ANNOUNCE] Release v5.10.223-cip51
Message-ID: <ZrfMq6o3hhYAzfLQ@duo.ucw.cz>
References: <OS0PR01MB63887DCF9F2F6CB68BFD718E92BA2@OS0PR01MB6388.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="LA7DIM8CglxfOJIt"
Content-Disposition: inline
In-Reply-To: <OS0PR01MB63887DCF9F2F6CB68BFD718E92BA2@OS0PR01MB6388.jpnprd01.prod.outlook.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 10 Aug 2024 20:25:21 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16767


--LA7DIM8CglxfOJIt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> CIP kernel team has released Linux kernel v5.10.223-cip51.
> The linux-5.10.y-cip tree has been updated base version from v5.10.221 to=
 v5.10.223.
> And this release includes patches for Renesas SoC and its reference
> board.

Thanks a lot!

Next due is 6.1-cip-rt. We do have v6.1.102-rt37, but v6.1 is at
v6.1.101-cip25. So, unless 6.1-rt is released, soon, my plan is to
release v6.1.102-cip26, then do -rt release on top of that.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--LA7DIM8CglxfOJIt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZrfMqwAKCRAw5/Bqldv6
8o/rAKCbKtkQKDxxbZKYnnYqMAzox2YLawCfY07Q3cZxl12r5ENr/IFaPMUwPGI=
=h3kZ
-----END PGP SIGNATURE-----

--LA7DIM8CglxfOJIt--

