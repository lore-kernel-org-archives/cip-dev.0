Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B027C433EF
	for <webhook@archiver.kernel.org>; Thu, 31 Mar 2022 09:28:15 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web08.5049.1648718893661232859
 for <cip-dev@lists.cip-project.org>;
 Thu, 31 Mar 2022 02:28:14 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 106B51C0B96; Thu, 31 Mar 2022 11:28:10 +0200 (CEST)
Date: Thu, 31 Mar 2022 11:28:08 +0200
From: Pavel Machek <pavel@denx.de>
To: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>, Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [PATCH 5.10.y-cip 00/39] Add SD/eMMC support for Renesas RZ/G2L
 SoC
Message-ID: <20220331092808.GA20092@amd>
References: <20220330185454.10887-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qMm9M+Fa2AknHoGS"
Content-Disposition: inline
In-Reply-To: <20220330185454.10887-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 31 Mar 2022 09:28:15 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7894


--qMm9M+Fa2AknHoGS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This patch series adds support for SD/eMMC on Renesas RZ/G2L SoC and
> enables this interfaces on Renesas RZ/G2L SMARC EVK.
>=20
> All the patches have been cherry picked from v5.17 release.

I tried to apply the patches on top of 5.10.106-cip4, and could
not. Can you double check series applies properly?

8bb6e30b765989a3c0924158316d689e16317cd1
    CIP: Bump version suffix to -cip4 after merge from stable
commit 66f600a7a5460b6acab5272ac9f54f842927a50d
    Merge tag 'v5.10.106' into linux-5.10.y-cip

Best regards,
							Pavel
						=09
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--qMm9M+Fa2AknHoGS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAmJFdCgACgkQMOfwapXb+vL2LACeMhOX8NF+l3ptz3wp44PaROdM
LV0AnjTxiF8TPzTioX9se5VB3tdbN5aW
=Wnsc
-----END PGP SIGNATURE-----

--qMm9M+Fa2AknHoGS--

