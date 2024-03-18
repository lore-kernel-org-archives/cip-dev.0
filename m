Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 516E5C54E58
	for <webhook@archiver.kernel.org>; Mon, 18 Mar 2024 11:39:34 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web11.41158.1710761966642653698
 for <cip-dev@lists.cip-project.org>;
 Mon, 18 Mar 2024 04:39:26 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 24A851C007E; Mon, 18 Mar 2024 12:39:25 +0100 (CET)
Date: Mon, 18 Mar 2024 12:39:24 +0100
From: Pavel Machek <pavel@denx.de>
To: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>, Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [PATCH 5.10.y-cip 0/3] Add RPC-IF support for RZ/G2{EHMN}
Message-ID: <Zfgn7KcyVy2vaK/c@duo.ucw.cz>
References: <20240315170304.31604-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Ug/sUkPdh66BpgKS"
Content-Disposition: inline
In-Reply-To: <20240315170304.31604-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 18 Mar 2024 11:39:34 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15347


--Ug/sUkPdh66BpgKS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This patch series adds RPC-IF support for RZ/G2{EHMN} SoCs. Note by
> default the RPC-IF is not enabled on the boards as the hyperflash is
> locked by TF-A. To unlock the hyperflash one must build TF-A with
> "RCAR_RPC_HYPERFLASH_LOCKED=3D0" flag and enable it in the board DTS.
>=20
> Note: All the patches have been cherry picked from upstream kernel.

The series looks ok to me, thank you. I can apply it if it passes
testing and if there are no other comments. I guess this should be
applied before corresponding 4.19 patch.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--Ug/sUkPdh66BpgKS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZfgn7AAKCRAw5/Bqldv6
8sFnAKCa7swIiJ+M0xFekq3+uQi2nG0fNgCdG7lxEur187FZalef6Z4uyU8lOBQ=
=LOrQ
-----END PGP SIGNATURE-----

--Ug/sUkPdh66BpgKS--

