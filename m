Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37673C67871
	for <webhook@archiver.kernel.org>; Thu, 27 Oct 2022 08:18:58 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web09.4158.1666858727316454357
 for <cip-dev@lists.cip-project.org>;
 Thu, 27 Oct 2022 01:18:48 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 117EA1C09DB; Thu, 27 Oct 2022 10:18:44 +0200 (CEST)
Date: Thu, 27 Oct 2022 10:18:43 +0200
From: Pavel Machek <pavel@denx.de>
To: nobuhiro1.iwamatsu@toshiba.co.jp
Cc: biju.das.jz@bp.renesas.com, cip-dev@lists.cip-project.org,
	pavel@denx.de, chris.paterson2@renesas.com, biju.das@bp.renesas.com
Subject: Re: [PATCH 5.10.y-cip 00/12] RZ/G2{L,LC,UL}/RZ/V2L improvements
Message-ID: <20221027081843.GA10348@duo.ucw.cz>
References: <20221025144131.1309463-1-biju.das.jz@bp.renesas.com>
 <TYWPR01MB94201E032FD08E985002D82392309@TYWPR01MB9420.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="IS0zKkzwUGydFO0o"
Content-Disposition: inline
In-Reply-To: <TYWPR01MB94201E032FD08E985002D82392309@TYWPR01MB9420.jpnprd01.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 27 Oct 2022 08:18:58 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9877


--IS0zKkzwUGydFO0o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> I reviewed this series, If there are no other comments, I can apply.
> Test pipelines:
>   https://gitlab.com/cip-project/cip-kernel/linux-cip/-/pipelines/6773149=
08

As we both reviewed the series, I applied it -- without the first
patch, which is not neccessary for 5.10.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--IS0zKkzwUGydFO0o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCY1o+4wAKCRAw5/Bqldv6
8uWWAJ9jWfeAT6ZcoU80+q+LRoDMQckTSQCbBQIjSjY5eb5xnR23uLIENPUvREU=
=Eeu2
-----END PGP SIGNATURE-----

--IS0zKkzwUGydFO0o--

