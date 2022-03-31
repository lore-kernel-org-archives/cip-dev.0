Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22912C433EF
	for <webhook@archiver.kernel.org>; Thu, 31 Mar 2022 08:59:00 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web10.4861.1648717138785542894
 for <cip-dev@lists.cip-project.org>;
 Thu, 31 Mar 2022 01:58:59 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 84A291C0B87; Thu, 31 Mar 2022 10:58:55 +0200 (CEST)
Date: Thu, 31 Mar 2022 10:58:53 +0200
From: Pavel Machek <pavel@denx.de>
To: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>, Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [PATCH 5.10.y-cip 00/39] Add SD/eMMC support for Renesas RZ/G2L
 SoC
Message-ID: <20220331085852.GA18107@amd>
References: <20220330185454.10887-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="n8g4imXOkfNTN/H1"
Content-Disposition: inline
In-Reply-To: <20220330185454.10887-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 31 Mar 2022 08:59:00 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7893


--n8g4imXOkfNTN/H1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This patch series adds support for SD/eMMC on Renesas RZ/G2L SoC and
> enables this interfaces on Renesas RZ/G2L SMARC EVK.
>=20
> All the patches have been cherry picked from v5.17 release.

Thanks for the series.

Review did not find anything that would prevent merge, so I'll proceed
with testing. If it tests okay and there are no other comments, I'll
likely apply the patches.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--n8g4imXOkfNTN/H1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAmJFbUwACgkQMOfwapXb+vKuLQCfSnauCYB592y7YUNZqKPgqA79
Ky0AoLE9ZC5Ql/n/zWQFSKicUD38r9H3
=35GY
-----END PGP SIGNATURE-----

--n8g4imXOkfNTN/H1--

