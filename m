Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 046E2C54E5D
	for <webhook@archiver.kernel.org>; Thu, 14 Mar 2024 21:10:26 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web11.4252.1710450619298900620
 for <cip-dev@lists.cip-project.org>;
 Thu, 14 Mar 2024 14:10:19 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id CEF6F1C0085; Thu, 14 Mar 2024 22:10:17 +0100 (CET)
Date: Thu, 14 Mar 2024 22:10:17 +0100
From: Pavel Machek <pavel@denx.de>
To: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>, Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [PATCH 4.19.y-cip 0/9] Add RPC-IF support for RZ/G2{EHMN}
Message-ID: <ZfNnuX/S9Z72GCuT@duo.ucw.cz>
References: <20240314192950.27343-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="GMIg7k1rVXokB+9M"
Content-Disposition: inline
In-Reply-To: <20240314192950.27343-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 14 Mar 2024 21:10:26 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15321


--GMIg7k1rVXokB+9M
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This patch series adds RPC-IF support for RZ/G2{EHMN} SoCs. Note by
> default the RPC-IF is not enabled on the boards as the hyperflash is
> locked by TF-A. To unlock the hyperflash one must build TF-A with
> "RCAR_RPC_HYPERFLASH_LOCKED=3D0" flag and enable it in the board DTS.

Series looks okay to me, and it passes testing. I can apply it if
there are no other comments.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--GMIg7k1rVXokB+9M
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZfNnuQAKCRAw5/Bqldv6
8iMMAKCw8hCERnTAChIadKTZgmiZSs01pQCgo+BCnB16Wo0ZfhvG3odQlRzjSgA=
=i4Uw
-----END PGP SIGNATURE-----

--GMIg7k1rVXokB+9M--

