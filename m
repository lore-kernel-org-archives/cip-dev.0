Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A61AC3DA49
	for <webhook@archiver.kernel.org>; Thu, 18 Jul 2024 11:02:40 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web10.12657.1721300550683194808
 for <cip-dev@lists.cip-project.org>;
 Thu, 18 Jul 2024 04:02:31 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 1481B1C0099; Thu, 18 Jul 2024 13:02:29 +0200 (CEST)
Date: Thu, 18 Jul 2024 13:02:28 +0200
From: Pavel Machek <pavel@denx.de>
To: nobuhiro1.iwamatsu@toshiba.co.jp
Cc: biju.das.jz@bp.renesas.com, cip-dev@lists.cip-project.org,
	pavel@denx.de, prabhakar.mahadev-lad.rj@bp.renesas.com
Subject: Re: [PATCH 5.10.y-cip 00/31] Add PMIC DA9062 support
Message-ID: <Zpj2RMWuOh+wnr5A@duo.ucw.cz>
References: <20240716082255.56551-1-biju.das.jz@bp.renesas.com>
 <OS3PR01MB6391E5A421C14AFB726EE27092AC2@OS3PR01MB6391.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="C+byITIB/a3fPfjI"
Content-Disposition: inline
In-Reply-To: <OS3PR01MB6391E5A421C14AFB726EE27092AC2@OS3PR01MB6391.jpnprd01.prod.outlook.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 18 Jul 2024 11:02:40 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16586


--C+byITIB/a3fPfjI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> I reviewed this series, looks good to me.
> I can apppy this series, if there are no other comments.
>=20
> Reviewed-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>

Thank you, I applied the series with your reviewed-by tag.

Best regards,
                                                                Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--C+byITIB/a3fPfjI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZpj2RAAKCRAw5/Bqldv6
8ha8AJ4kZBqdTHnUbk1vSOrduBLBWmjKnwCglkAIIqeB6SHY0+tX0Xg9HbGfP9w=
=Rk6v
-----END PGP SIGNATURE-----

--C+byITIB/a3fPfjI--

