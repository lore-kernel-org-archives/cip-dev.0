Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E1A3C7618D
	for <webhook@archiver.kernel.org>; Tue, 13 Dec 2022 18:52:29 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web11.82620.1670957544243788708
 for <cip-dev@lists.cip-project.org>;
 Tue, 13 Dec 2022 10:52:25 -0800
Authentication-Results: mx.groups.io;
 dkim=missing; spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 775661C0A00; Tue, 13 Dec 2022 19:52:20 +0100 (CET)
Date: Tue, 13 Dec 2022 19:52:22 +0100
From: Pavel Machek <pavel@denx.de>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>,
	Chris Paterson <chris.paterson2@renesas.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH 5.10.y-cip 0/7] CANFD Improvement
Message-ID: <Y5jJ5sHkfKqfUSBR@amd.ucw.cz>
References: <20221213172316.1848032-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Ty5rt0KfSwYf6SQX"
Content-Disposition: inline
In-Reply-To: <20221213172316.1848032-1-biju.das.jz@bp.renesas.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 13 Dec 2022 18:52:29 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10229


--Ty5rt0KfSwYf6SQX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This patch series aims to fix IRQ storm issue as well as
> some enhancements to Renesas CANFD driver.

Series looks ok to me, I can apply it if it passes testing and if
there are no other comments.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--Ty5rt0KfSwYf6SQX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCY5jJ5gAKCRAw5/Bqldv6
8qf0AJ0VX1P8g0BcPgFKY7whuv7u2QDOQQCcCAi/Dyfpjd14ZlOPMjIGS5uKKKU=
=kE0W
-----END PGP SIGNATURE-----

--Ty5rt0KfSwYf6SQX--

