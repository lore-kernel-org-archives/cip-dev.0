Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27932C4332F
	for <webhook@archiver.kernel.org>; Thu, 14 Dec 2023 09:52:27 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web11.18616.1702547544752309976
 for <cip-dev@lists.cip-project.org>;
 Thu, 14 Dec 2023 01:52:25 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id C3A4B1C006F; Thu, 14 Dec 2023 10:52:21 +0100 (CET)
Date: Thu, 14 Dec 2023 10:52:21 +0100
From: Pavel Machek <pavel@denx.de>
To: nobuhiro1.iwamatsu@toshiba.co.jp
Cc: pavel@denx.de, biju.das.jz@bp.renesas.com,
	cip-dev@lists.cip-project.org,
	prabhakar.mahadev-lad.rj@bp.renesas.com
Subject: Re: [PATCH 00/14] Add Mali-G31 GPU support for RZ/G2L SoC
Message-ID: <ZXrQVTubjAWNv36H@duo.ucw.cz>
References: <20231212124035.151367-1-biju.das.jz@bp.renesas.com>
 <ZXlpN+5ODcVIfZj3@duo.ucw.cz>
 <TYVPR01MB11245F51F54A2EE4E6505040C928CA@TYVPR01MB11245.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="INDRH40Y3w16sb2T"
Content-Disposition: inline
In-Reply-To: <TYVPR01MB11245F51F54A2EE4E6505040C928CA@TYVPR01MB11245.jpnprd01.prod.outlook.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 14 Dec 2023 09:52:27 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14093


--INDRH40Y3w16sb2T
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > > RZ/G2L SoC embeds Mali-G31 bifrost GPU.
> > > This patch series aims to add support for the same.
> > >
> > > Please don't apply patch#7 to patch#14as it is added for testing purp=
ose.
> > >
> > > It is tested with 5.10.y-cip + out of tree patch for (DU) + [1]
> >=20
> > I reviewed series, and the parts you want applied are really quite simp=
le. I can
> > apply them if there are no other comments (and provided tests pass).
> >=20
>=20
> I reviewed this series. There doesn't seem to be any comments.
> I will apply and push.

In simple testing including the "do not apply" revealed no problems,
https://gitlab.com/cip-project/cip-kernel/linux-cip/tree/ci/pavel/linux-tes=
t,
and patches look ok to me.

Reviewed-by: Pavel Machek <pavel@denx.de>

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--INDRH40Y3w16sb2T
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZXrQVQAKCRAw5/Bqldv6
8ighAJ9JKimufDpUogI7RbuU4P3BsFFKZACeIAqKpIpQ43v4mhI5CAnT8KEU8EM=
=PB6F
-----END PGP SIGNATURE-----

--INDRH40Y3w16sb2T--

