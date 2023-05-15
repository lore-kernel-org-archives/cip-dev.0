Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5D42C7EE25
	for <webhook@archiver.kernel.org>; Mon, 15 May 2023 20:29:34 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web11.1513.1684182565535060624
 for <cip-dev@lists.cip-project.org>;
 Mon, 15 May 2023 13:29:25 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id AA7871C0E4B; Mon, 15 May 2023 22:29:23 +0200 (CEST)
Date: Mon, 15 May 2023 22:29:23 +0200
From: Pavel Machek <pavel@denx.de>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>,
	Chris Paterson <chris.paterson2@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH 5.10.y-cip 0/4] Add RZ/G2L DMA Reset support
Message-ID: <ZGKWIxhxy5Kn/Qpd@duo.ucw.cz>
References: <20230515085352.25794-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="BTpU/li/pU5pGfvR"
Content-Disposition: inline
In-Reply-To: <20230515085352.25794-1-biju.das.jz@bp.renesas.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 15 May 2023 20:29:34 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11458


--BTpU/li/pU5pGfvR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This patch series aims to add DMA reset support fot RZ/G2L alike SoCs
>=20
> Also added a patch to remove unused variable.
>=20
> All these patches are cherry-picked from the mainline.

Series looks okay to me, I can apply it if there are no other comments
and if it passes testing.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--BTpU/li/pU5pGfvR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZGKWIwAKCRAw5/Bqldv6
8nOjAJ4rkqc2E58Qc//SR/BRrOf1fV35mACeNCqBX/T9q/Z/2ag1uiPp7R9Rj4c=
=gddV
-----END PGP SIGNATURE-----

--BTpU/li/pU5pGfvR--

