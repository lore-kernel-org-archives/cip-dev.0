Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7201DC54E60
	for <webhook@archiver.kernel.org>; Tue, 19 Mar 2024 11:10:39 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web10.12629.1710846635256995288
 for <cip-dev@lists.cip-project.org>;
 Tue, 19 Mar 2024 04:10:35 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id BC5A11C006B; Tue, 19 Mar 2024 12:10:31 +0100 (CET)
Date: Tue, 19 Mar 2024 12:10:31 +0100
From: Pavel Machek <pavel@denx.de>
To: Pavel Machek <pavel@denx.de>
Cc: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [PATCH 5.10.y-cip 0/3] Add RPC-IF support for RZ/G2{EHMN}
Message-ID: <Zflyp/RX5b7hOXWc@duo.ucw.cz>
References: <20240315170304.31604-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <Zfgn7KcyVy2vaK/c@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="IDvPVu0Vr/e9sbVk"
Content-Disposition: inline
In-Reply-To: <Zfgn7KcyVy2vaK/c@duo.ucw.cz>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 19 Mar 2024 11:10:39 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15363


--IDvPVu0Vr/e9sbVk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > This patch series adds RPC-IF support for RZ/G2{EHMN} SoCs. Note by
> > default the RPC-IF is not enabled on the boards as the hyperflash is
> > locked by TF-A. To unlock the hyperflash one must build TF-A with
> > "RCAR_RPC_HYPERFLASH_LOCKED=3D0" flag and enable it in the board DTS.
> >=20
> > Note: All the patches have been cherry picked from upstream kernel.
>=20
> The series looks ok to me, thank you. I can apply it if it passes
> testing and if there are no other comments. I guess this should be
> applied before corresponding 4.19 patch.

Thank you, applied.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--IDvPVu0Vr/e9sbVk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZflypwAKCRAw5/Bqldv6
8v2hAJ9ubJfuNgZOdDj24uJjrm+gxjeTqgCgmF03ApalLHmzolKj2x4pNi74j1I=
=L8vj
-----END PGP SIGNATURE-----

--IDvPVu0Vr/e9sbVk--

