Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B0C1C4706F
	for <webhook@archiver.kernel.org>; Tue, 26 Dec 2023 18:38:53 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web10.86877.1703615928284457281
 for <cip-dev@lists.cip-project.org>;
 Tue, 26 Dec 2023 10:38:48 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id CCB871C0050; Tue, 26 Dec 2023 19:38:46 +0100 (CET)
Date: Tue, 26 Dec 2023 19:38:45 +0100
From: Pavel Machek <pavel@denx.de>
To: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>, Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [PATCH RFC 00/30] Add support for Renesas RZ/Five RISC-V SoC
Message-ID: <ZYsdtS4UkTS/TUsH@duo.ucw.cz>
References: <20231220230646.219816-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8wj9DHyp0K9NsDBA"
Content-Disposition: inline
In-Reply-To: <20231220230646.219816-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 26 Dec 2023 18:38:53 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14199


--8wj9DHyp0K9NsDBA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Sending this series as an RFC mainly beacuse, as the kernel image is not
> generic to all RISC-V platforms as the HW is noncoherent.

Does the hardware also have the "low memory does not work in
userspace" problem? How is that handled?

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--8wj9DHyp0K9NsDBA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZYsdtQAKCRAw5/Bqldv6
8jz3AJ46qpqRT6zckO2ZDJ1MD5QPQNwRxwCgqHJKW7YkT5q+pY5ThfNtuP/YgoU=
=yWmm
-----END PGP SIGNATURE-----

--8wj9DHyp0K9NsDBA--

