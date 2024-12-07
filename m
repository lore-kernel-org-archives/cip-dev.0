Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C974E7717B
	for <webhook@archiver.kernel.org>; Sat,  7 Dec 2024 17:35:59 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web11.64063.1733592954548541504
 for <cip-dev@lists.cip-project.org>;
 Sat, 07 Dec 2024 09:35:55 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=fail (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id EC99C1C00A0; Sat,  7 Dec 2024 18:35:51 +0100 (CET)
Date: Sat, 7 Dec 2024 18:35:51 +0100
From: Pavel Machek <pavel@denx.de>
To: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>, Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [PATCH 6.1.y-cip 00/16] Add RPC-IF support for RZ/G2UL SoC
Message-ID: <Z1SHd8kL1316T9WX@duo.ucw.cz>
References: <20241206091122.67133-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="dP4/mZW6HpbDFQQb"
Content-Disposition: inline
In-Reply-To: <20241206091122.67133-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 07 Dec 2024 17:35:59 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17370


--dP4/mZW6HpbDFQQb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This patch series aims to add RPC-IF support for RZ/G2UL SoC and enable it
> on SMARC platform, along with enabling tx width to 4 on RZ/G2L SMARC
> platforms.
>=20
> All the patches have been cherry picked from upstream kernel.

It is a bit strange that 5.10 series is smaller than this.

But this looks okay, too, and I can merge it if it passes testing etc.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--dP4/mZW6HpbDFQQb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZ1SHdwAKCRAw5/Bqldv6
8gk0AJ9Y/IXG4iBApnbYNNnJK4rwmQ30hwCfVCdgsBquCj3eRm51Ngo4xIjVW5E=
=FfNt
-----END PGP SIGNATURE-----

--dP4/mZW6HpbDFQQb--

