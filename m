Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 296ECC4332F
	for <webhook@archiver.kernel.org>; Mon,  4 Apr 2022 23:51:30 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web10.2780.1649113844945123563
 for <cip-dev@lists.cip-project.org>;
 Mon, 04 Apr 2022 16:10:46 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 0B3BB1C0B66; Tue,  5 Apr 2022 01:10:41 +0200 (CEST)
Date: Tue, 5 Apr 2022 01:10:40 +0200
From: Pavel Machek <pavel@denx.de>
To: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>, Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [PATCH 5.10.y-cip 00/29] Add RSPI/OSTM/WDT/TSU/OPP support to
 Renesas RZ/G2L SoC
Message-ID: <20220404231039.GA19122@amd>
References: <20220404123553.25851-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="AhhlLboLdkugWU4S"
Content-Disposition: inline
In-Reply-To: <20220404123553.25851-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 04 Apr 2022 23:51:30 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7993


--AhhlLboLdkugWU4S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This patch series adds support for following to Renesas RZ/RGL SoC:
> * RSPI
> * WDT
> * OSTM
> * TSU/OPP/IPA
>=20
> All the patches have been cherry-picked from v5.17 release.

Thanks for the series. It passes testing and I do not see any problems
that would prevent merge. I can merge it if there are no other
comments.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--AhhlLboLdkugWU4S
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAmJLeu8ACgkQMOfwapXb+vJ1BgCdG4uk57fFjpoufDNFWNVwYWEP
pGwAoJfQqqgLkMfQKG2xAgxsd5tRzxuw
=qK/O
-----END PGP SIGNATURE-----

--AhhlLboLdkugWU4S--

