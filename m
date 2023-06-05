Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A68E8C77B73
	for <webhook@archiver.kernel.org>; Mon,  5 Jun 2023 15:27:43 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web10.11458.1685978853969033891
 for <cip-dev@lists.cip-project.org>;
 Mon, 05 Jun 2023 08:27:34 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 7DDA91C0AB3; Mon,  5 Jun 2023 17:27:32 +0200 (CEST)
Date: Mon, 5 Jun 2023 17:27:32 +0200
From: Pavel Machek <pavel@denx.de>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>,
	Chris Paterson <chris.paterson2@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH 5.10.y-cip 0/7] Add SCI support for RZ/G2L alike SoCs
Message-ID: <ZH3+5PRse1Kdzoni@duo.ucw.cz>
References: <20230605110512.111017-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0W8aZcYrpIYfzTGB"
Content-Disposition: inline
In-Reply-To: <20230605110512.111017-1-biju.das.jz@bp.renesas.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 05 Jun 2023 15:27:43 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11813


--0W8aZcYrpIYfzTGB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This patch series aims to add SCI support for RZ/G2L alike SoCs.
> While at it, added DMA fixes for SCIF IP.
>=20
> All these patches are cherry-picked from the mainline except patch#7 as
> we don't have proper DT overlay support in 5.10.

This series looks okay to me, I can apply it if it passes testing and
if there are no other comments.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--0W8aZcYrpIYfzTGB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZH3+5AAKCRAw5/Bqldv6
8rO2AKCfyEFlnetMCS6kRgKZuMCauy8I2QCfbFp1ryMfqGbMy7t0mDwHE/mJ5Y4=
=pGJi
-----END PGP SIGNATURE-----

--0W8aZcYrpIYfzTGB--

