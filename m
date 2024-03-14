Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93326C54E5D
	for <webhook@archiver.kernel.org>; Thu, 14 Mar 2024 20:01:02 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web10.2547.1710446455729921911
 for <cip-dev@lists.cip-project.org>;
 Thu, 14 Mar 2024 13:00:56 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 6F8061C007B; Thu, 14 Mar 2024 21:00:53 +0100 (CET)
Date: Thu, 14 Mar 2024 21:00:52 +0100
From: Pavel Machek <pavel@denx.de>
To: cip-dev@lists.cip-project.org
Subject: Re: [cip-dev] [PATCH 4.19.y-cip 0/9] Add RPC-IF support for
 RZ/G2{EHMN}
Message-ID: <ZfNXdMYpPVIc99Zd@duo.ucw.cz>
References: <20240314192950.27343-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <TYWPR01MB11862FC46D37E44BE7A415016B7292@TYWPR01MB11862.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="kRTsSvOnXt/1Sy0s"
Content-Disposition: inline
In-Reply-To: <TYWPR01MB11862FC46D37E44BE7A415016B7292@TYWPR01MB11862.jpnprd01.prod.outlook.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 14 Mar 2024 20:01:02 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15319


--kRTsSvOnXt/1Sy0s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > This patch series adds RPC-IF support for RZ/G2{EHMN} SoCs. Note by
> > default the RPC-IF is not enabled on the boards as the hyperflash is
> > locked by TF-A. To unlock the hyperflash one must build TF-A with
> > "RCAR_RPC_HYPERFLASH_LOCKED=3D0" flag and enable it in the board
> > DTS.
>=20
> I hope that Pavel doesn't reject this series because of this! :P

In context of today's conversation, this:

> > Krzysztof Kozlowski (1):
> >   memory: renesas-rpc-if: fix possible NULL pointer dereference of
> >     resource

might be much better reason to reject the series :-).

Let me take a look...

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--kRTsSvOnXt/1Sy0s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZfNXdAAKCRAw5/Bqldv6
8rrFAJ49h1bJdX/lK+qHq1GyAWy8WZUB4gCfQdqOMHOHti3sdg5a3uv0x/t/uOY=
=3N1P
-----END PGP SIGNATURE-----

--kRTsSvOnXt/1Sy0s--

