Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6C11ECAAA1
	for <webhook@archiver.kernel.org>; Sun, 11 Sep 2022 09:26:41 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web08.8294.1662888395062406174
 for <cip-dev@lists.cip-project.org>;
 Sun, 11 Sep 2022 02:26:36 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 864031C0003; Sun, 11 Sep 2022 11:26:33 +0200 (CEST)
Date: Sun, 11 Sep 2022 11:26:32 +0200
From: Pavel Machek <pavel@denx.de>
To: nobuhiro1.iwamatsu@toshiba.co.jp
Cc: cip-dev@lists.cip-project.org, pavel@denx.de, uli@fpond.eu,
	masami.ichikawa@cybertrust.co.jp, jan.kiszka@siemens.com,
	Chris.Paterson2@renesas.com
Subject: Re: [ANNOUNCE] Release v4.19.257-cip81 and v5.10.140-cip16
Message-ID: <20220911092632.GA27786@duo.ucw.cz>
References: 
 <TYWPR01MB942063F981E39F7AA306FA0892439@TYWPR01MB9420.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ikeVEW9yuYc//A+q"
Content-Disposition: inline
In-Reply-To: 
 <TYWPR01MB942063F981E39F7AA306FA0892439@TYWPR01MB9420.jpnprd01.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sun, 11 Sep 2022 09:26:41 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9486


--ikeVEW9yuYc//A+q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

>=20
> CIP kernel team has released Linux kernel v4.19.257-cip81 and v5.10.140-c=
ip16 The linux-4.19.y-cip tree has been updated base version from v4.19.256=
 to v4.19.257, and the linux-5.10.y-cip tree has been updated base version =
=66rom v5.10.138 to v5.10.140.
> RZ/G2UL SoC and reference board support have been added to 5.10.y-cip tre=
e with this update.
>

Thank you. I just pushed -rt tree based on 5.10.140.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--ikeVEW9yuYc//A+q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCYx2pyAAKCRAw5/Bqldv6
8oReAJ9I4ZaEymE8DG0glqtWsPlcyQWNUgCePwbZWRIwsWmY2yU6daoh5Ti9rto=
=3bRU
-----END PGP SIGNATURE-----

--ikeVEW9yuYc//A+q--

