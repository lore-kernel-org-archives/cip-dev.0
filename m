Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B8C3C19F2D
	for <webhook@archiver.kernel.org>; Sat, 13 Aug 2022 14:17:14 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web11.5140.1660400226457984001
 for <cip-dev@lists.cip-project.org>;
 Sat, 13 Aug 2022 07:17:07 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 0014D1C0006; Sat, 13 Aug 2022 16:17:03 +0200 (CEST)
Date: Sat, 13 Aug 2022 16:17:03 +0200
From: Pavel Machek <pavel@denx.de>
To: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>, Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [PATCH 5.10.y-cip 00/11] Renesas RPCI-IF and RSPI driver fixes
 and improvements
Message-ID: <20220813141703.GA32244@duo.ucw.cz>
References: <20220812101317.12380-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="UugvWAfsgieZRqgk"
Content-Disposition: inline
In-Reply-To: <20220812101317.12380-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 13 Aug 2022 14:17:14 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9204


--UugvWAfsgieZRqgk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This patch series backports RPCI-IF and RSPI driver fixes and
> improvements.
>=20
> Note: All the patches have been cherry picked from v5.19 kernel.

Series looks okay to me, I can apply it if there are no other comments
and if it passes testing.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--UugvWAfsgieZRqgk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCYveyXwAKCRAw5/Bqldv6
8nxyAKCctpD0Lh9dOPj4cEsHFmNm6uc2FgCeNCGaGWB07GKd6ZO3+d0Uh/QnBTo=
=Q7PO
-----END PGP SIGNATURE-----

--UugvWAfsgieZRqgk--

