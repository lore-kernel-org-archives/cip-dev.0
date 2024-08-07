Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E4EDC3DA7F
	for <webhook@archiver.kernel.org>; Wed,  7 Aug 2024 17:30:11 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web10.39438.1723051802535814180
 for <cip-dev@lists.cip-project.org>;
 Wed, 07 Aug 2024 10:30:02 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 504061C0082; Wed,  7 Aug 2024 19:29:59 +0200 (CEST)
Date: Wed, 7 Aug 2024 19:29:58 +0200
From: Pavel Machek <pavel@denx.de>
To: nobuhiro1.iwamatsu@toshiba.co.jp
Cc: biju.das.jz@bp.renesas.com, cip-dev@lists.cip-project.org,
	pavel@denx.de, prabhakar.mahadev-lad.rj@bp.renesas.com
Subject: Re: [PATCH 6.1.y-cip 00/30] Add support for RZ/{G2L,G2LC,G2UL,V2L}
 Camera Data Receiving Unit
Message-ID: <ZrOvFiLLWG3u1W9r@duo.ucw.cz>
References: <20240805164342.211857-1-biju.das.jz@bp.renesas.com>
 <OS0PR01MB63883C1108CBAA81E8063BCB92B82@OS0PR01MB6388.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+EMeGHznpCFIUjUN"
Content-Disposition: inline
In-Reply-To: <OS0PR01MB63883C1108CBAA81E8063BCB92B82@OS0PR01MB6388.jpnprd01.prod.outlook.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 07 Aug 2024 17:30:11 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16760


--+EMeGHznpCFIUjUN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!


> > Nathan Chancellor (1):
> >   media: rzg2l-cru: Remove unnecessary shadowing of ret in
> >     rzg2l_csi2_s_stream()
>=20
> I reviewed this series, there are no problems.
> I can apply this series if there are no other comments.
>=20
> Reviewed-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>

Thanks for review and for patches. I added your Reviewed-by: tag and
pushed the results.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--+EMeGHznpCFIUjUN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZrOvFgAKCRAw5/Bqldv6
8iYAAJ0VRZMv4k3CfyqBiDloNDBY7y+vtQCggXuAbnFnqj2EXGQo9eFnwLi+XzM=
=t429
-----END PGP SIGNATURE-----

--+EMeGHznpCFIUjUN--

