Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9E00C61DF4
	for <webhook@archiver.kernel.org>; Fri, 24 Nov 2023 09:09:25 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web10.131879.1700816960651761052
 for <cip-dev@lists.cip-project.org>;
 Fri, 24 Nov 2023 01:09:21 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id E3FF21C0072; Fri, 24 Nov 2023 10:09:17 +0100 (CET)
Date: Fri, 24 Nov 2023 10:09:17 +0100
From: Pavel Machek <pavel@denx.de>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: Re: [PATCH 6.1.y-cip v2 00/12] Add versa3 clk generator support
Message-ID: <ZWBoPc0CqdvchlTX@duo.ucw.cz>
References: <20231123182854.422379-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="TaO4XZKCp0hNoxoX"
Content-Disposition: inline
In-Reply-To: <20231123182854.422379-1-biju.das.jz@bp.renesas.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 24 Nov 2023 09:09:25 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13714


--TaO4XZKCp0hNoxoX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This patch series aims to add versa3 clk generator support on
> RZ/G2{L,LC,UL}/RZ/Five SMARC EVKs.
>=20
> All the patches are cherry-picked from the mainline.
>=20
> Also added missing MTU3 binding patches for RZ/{G2UL,Five} SoCs.

Thanks for the series. I already applied the "rz_mtu3 binding
patches", we already reviewed these in v1, and it passes testing, so
I'm applying the series (with the exception of last 3).

Best regards,
								Pavel

--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--TaO4XZKCp0hNoxoX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZWBoPQAKCRAw5/Bqldv6
8tzuAJ0dr94wd0GEF+bS7y1pz06+vhlhOQCeKWETuEOyv33dWhGT71bySl8rsxM=
=QJNf
-----END PGP SIGNATURE-----

--TaO4XZKCp0hNoxoX--

