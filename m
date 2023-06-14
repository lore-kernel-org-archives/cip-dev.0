Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA4B0EB64DA
	for <webhook@archiver.kernel.org>; Wed, 14 Jun 2023 10:04:24 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web11.7939.1686737060345871607
 for <cip-dev@lists.cip-project.org>;
 Wed, 14 Jun 2023 03:04:21 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id DECA21C0D23; Wed, 14 Jun 2023 12:04:16 +0200 (CEST)
Date: Wed, 14 Jun 2023 12:04:16 +0200
From: Pavel Machek <pavel@denx.de>
To: nobuhiro1.iwamatsu@toshiba.co.jp
Cc: biju.das.jz@bp.renesas.com, cip-dev@lists.cip-project.org,
	pavel@denx.de, chris.paterson2@renesas.com,
	fabrizio.castro.jz@renesas.com
Subject: Re: [PATCH 6.1.y-cip] dt-bindings: usb: ti,hd3ss3220: Update
 interrupt property as optional
Message-ID: <ZImQoNWLM8+mUkei@duo.ucw.cz>
References: <20230612072546.80479-1-biju.das.jz@bp.renesas.com>
 <TYWPR01MB942090D9FB9D207AB142B59A9254A@TYWPR01MB9420.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8VKkas6jd07RA8iM"
Content-Disposition: inline
In-Reply-To: <TYWPR01MB942090D9FB9D207AB142B59A9254A@TYWPR01MB9420.jpnprd01.prod.outlook.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 14 Jun 2023 10:04:24 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12003


--8VKkas6jd07RA8iM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Looks good to me.
> Reviewed-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>

Thank you, looks good to me to, I'll apply it.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--8VKkas6jd07RA8iM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZImQoAAKCRAw5/Bqldv6
8q16AJ9hABuA2xQMTbYi32E11zFxolBiBgCgodSzirJYsnBoQzgD4p3VNCKHwmE=
=TB2L
-----END PGP SIGNATURE-----

--8VKkas6jd07RA8iM--

