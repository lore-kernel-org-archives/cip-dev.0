Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 167DCC19F2B
	for <webhook@archiver.kernel.org>; Thu,  4 Aug 2022 09:17:04 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web11.2724.1659604614926827218
 for <cip-dev@lists.cip-project.org>;
 Thu, 04 Aug 2022 02:16:55 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 9916F1C000A; Thu,  4 Aug 2022 11:16:51 +0200 (CEST)
Date: Thu, 4 Aug 2022 11:16:51 +0200
From: Pavel Machek <pavel@denx.de>
To: nobuhiro1.iwamatsu@toshiba.co.jp
Cc: biju.das.jz@bp.renesas.com, cip-dev@lists.cip-project.org,
	pavel@denx.de, chris.paterson2@renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com
Subject: Re: [PATCH 5.10.y-cip 00/13] Add more support to RZ/G2LC
Message-ID: <20220804091651.GA20458@duo.ucw.cz>
References: <20220803165358.2156150-1-biju.das.jz@bp.renesas.com>
 <TYWPR01MB9420B86CFD0071893D86D2A7929F9@TYWPR01MB9420.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="h31gzZEtNLTqOjlF"
Content-Disposition: inline
In-Reply-To: 
 <TYWPR01MB9420B86CFD0071893D86D2A7929F9@TYWPR01MB9420.jpnprd01.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 04 Aug 2022 09:17:04 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9115


--h31gzZEtNLTqOjlF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> I reviewed this series, LGTM.
> I can apply this, if there are no other commands.
>   https://gitlab.com/cip-project/cip-kernel/linux-cip/-/pipelines/6043999=
02

Series looks good to me, too. Go ahead with the application.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--h31gzZEtNLTqOjlF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCYuuOgwAKCRAw5/Bqldv6
8kKYAKCl8QimDuVL/j3nyPQc5OLl8hxztgCfX4aes+BmSIfAL5H1bD0cME68oV4=
=8Lso
-----END PGP SIGNATURE-----

--h31gzZEtNLTqOjlF--

