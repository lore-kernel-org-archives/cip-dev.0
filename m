Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86A79C46CD3
	for <webhook@archiver.kernel.org>; Tue, 26 Dec 2023 18:32:33 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web10.86756.1703615547843483040
 for <cip-dev@lists.cip-project.org>;
 Tue, 26 Dec 2023 10:32:28 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 4C7031C0050; Tue, 26 Dec 2023 19:32:26 +0100 (CET)
Date: Tue, 26 Dec 2023 19:32:25 +0100
From: Pavel Machek <pavel@denx.de>
To: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>, Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [PATCH RFC 17/30] cache: Add L2 cache management for Andes
 AX45MP RISC-V core
Message-ID: <ZYscOXYQG2r5DUgK@duo.ucw.cz>
References: <20231220230646.219816-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20231220230646.219816-18-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7D/e/ZTyAnm679c1"
Content-Disposition: inline
In-Reply-To: <20231220230646.219816-18-prabhakar.mahadev-lad.rj@bp.renesas.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 26 Dec 2023 18:32:33 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14196


--7D/e/ZTyAnm679c1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> IOCP is a specification option and is disabled on the Renesas RZ/Five
> SoC due to this reason IP blocks using DMA will fail.
>=20
=2E..
>=20
> As a workaround for SoCs with IOCP disabled CMO needs to be handled by
> software. Firstly OpenSBI configures the memory region as

There are too many acronyms here. What is CMO, in particular? And
putting this forward near the IOCP definition might be more helpful.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--7D/e/ZTyAnm679c1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZYscOQAKCRAw5/Bqldv6
8qegAKC6JVtT2/V4fD/7XKhq0s/uhdAGpACfbnnKTb8k7hjYosSfXKhIZ21H7eU=
=oI64
-----END PGP SIGNATURE-----

--7D/e/ZTyAnm679c1--

