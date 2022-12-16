Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E1F2C4332F
	for <webhook@archiver.kernel.org>; Fri, 16 Dec 2022 09:39:23 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web10.9234.1671183560278202751
 for <cip-dev@lists.cip-project.org>;
 Fri, 16 Dec 2022 01:39:21 -0800
Authentication-Results: mx.groups.io;
 dkim=missing; spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id C94D01C09F4; Fri, 16 Dec 2022 10:39:18 +0100 (CET)
Date: Fri, 16 Dec 2022 10:39:18 +0100
From: Pavel Machek <pavel@denx.de>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>,
	Chris Paterson <chris.paterson2@renesas.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH 5.10.y-cip 0/7] CANFD Improvement
Message-ID: <Y5w8xvLC9X684FZA@duo.ucw.cz>
References: <20221213172316.1848032-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="BaW9kNy9BAB3iUlq"
Content-Disposition: inline
In-Reply-To: <20221213172316.1848032-1-biju.das.jz@bp.renesas.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 16 Dec 2022 09:39:23 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10237


--BaW9kNy9BAB3iUlq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This patch series aims to fix IRQ storm issue as well as
> some enhancements to Renesas CANFD driver.

Thank you, applied.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--BaW9kNy9BAB3iUlq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCY5w8xgAKCRAw5/Bqldv6
8qGaAKC0Pq8rPcNbBChaThVkXNA5eDNe2QCgrS44QzVbfEefZtbfBwcuj1uf+jE=
=VzvR
-----END PGP SIGNATURE-----

--BaW9kNy9BAB3iUlq--

