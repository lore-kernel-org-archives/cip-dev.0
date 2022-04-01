Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A7C4C3A5A7
	for <webhook@archiver.kernel.org>; Mon,  4 Apr 2022 18:46:42 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web12.4909.1648848795226657068
 for <cip-dev@lists.cip-project.org>;
 Fri, 01 Apr 2022 14:33:16 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id A68AF1C0B79; Fri,  1 Apr 2022 23:33:09 +0200 (CEST)
Date: Fri, 1 Apr 2022 23:33:09 +0200
From: Pavel Machek <pavel@denx.de>
To: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>, Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [RESEND PATCH 5.10.y-cip 00/40] Add SD/eMMC support for Renesas
 RZ/G2L SoC
Message-ID: <20220401213309.GA7846@duo.ucw.cz>
References: <20220401194234.14057-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="liOOAslEiF7prFVr"
Content-Disposition: inline
In-Reply-To: <20220401194234.14057-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 04 Apr 2022 18:46:42 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7952


--liOOAslEiF7prFVr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This patch series adds support for SD/eMMC on Renesas RZ/G2L SoC and
> enables this interfaces on Renesas RZ/G2L SMARC EVK.
>=20
> All the patches have been cherry picked from v5.17 release.
>=20
> Resending as I had missed a patch (0001) earlier, reset of the patches
> havent been changed. And also for some reason patches didnt make into
> patchwork.

Testing was successful and the review only uncovered small details, so
I applied and pushed the series. Thanks!

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--liOOAslEiF7prFVr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCYkdvlQAKCRAw5/Bqldv6
8r85AJ9HRwnRJmMEQ7RQMRbKg0iv4acI7gCggTZZucrGd08DXtpdtzd/mHEErQI=
=r+qj
-----END PGP SIGNATURE-----

--liOOAslEiF7prFVr--

