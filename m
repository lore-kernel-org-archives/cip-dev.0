Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EB8EEB64D9
	for <webhook@archiver.kernel.org>; Thu, 15 Jun 2023 08:23:59 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web10.13255.1686817429660574886
 for <cip-dev@lists.cip-project.org>;
 Thu, 15 Jun 2023 01:23:50 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id CEEB61C0E65; Thu, 15 Jun 2023 10:23:45 +0200 (CEST)
Date: Thu, 15 Jun 2023 10:23:45 +0200
From: Pavel Machek <pavel@denx.de>
To: nobuhiro1.iwamatsu@toshiba.co.jp
Cc: biju.das.jz@bp.renesas.com, cip-dev@lists.cip-project.org,
	pavel@denx.de, chris.paterson2@renesas.com,
	fabrizio.castro.jz@renesas.com
Subject: Re: [PATCH 5.10.y-cip 0/7] RZ/V2M UART FIFO support
Message-ID: <ZIrKkbyFwCFbg1vY@duo.ucw.cz>
References: <20230613132339.150671-1-biju.das.jz@bp.renesas.com>
 <TYCPR01MB941805A1C76870231B1BE9D4925AA@TYCPR01MB9418.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="LtP448D7vov+QnJy"
Content-Disposition: inline
In-Reply-To: <TYCPR01MB941805A1C76870231B1BE9D4925AA@TYCPR01MB9418.jpnprd01.prod.outlook.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 15 Jun 2023 08:23:59 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12041


--LtP448D7vov+QnJy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> I reviewed this series. Looks fine to me.
> I can apply, if there are no other comments and issues.
>=20
> Test: https://gitlab.com/cip-project/cip-kernel/linux-cip/-/pipelines/899=
104272
> Reviewed-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>

Thanks for review. I added your reviewed-by tag and applied the
series.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--LtP448D7vov+QnJy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZIrKkQAKCRAw5/Bqldv6
8kMgAKDBzOhicEoqqjiFEres3M1Ziq9PXgCgioEmo4GGKyi6A1Kkoluyg85chco=
=I+Qj
-----END PGP SIGNATURE-----

--LtP448D7vov+QnJy--

