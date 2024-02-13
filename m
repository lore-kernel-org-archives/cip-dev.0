Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 297D2C48260
	for <webhook@archiver.kernel.org>; Tue, 13 Feb 2024 08:33:03 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web11.7357.1707813173123632825
 for <cip-dev@lists.cip-project.org>;
 Tue, 13 Feb 2024 00:32:53 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 69C761C007F; Tue, 13 Feb 2024 09:32:49 +0100 (CET)
Date: Tue, 13 Feb 2024 09:32:49 +0100
From: Pavel Machek <pavel@denx.de>
To: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>, Biju Das <biju.das.jz@bp.renesas.com>,
	llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH 5.10.y-cip] cache: Kconfig: Add dependency for RISCV on
 AX45MP_L2_CACHE config
Message-ID: <ZcspMaCweLlpXES0@duo.ucw.cz>
References: <20240212121914.38493-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="F1Ah9b1UnUoleVi5"
Content-Disposition: inline
In-Reply-To: <20240212121914.38493-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 13 Feb 2024 08:33:03 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14933


--F1Ah9b1UnUoleVi5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> csr_write() is available only for RISC-V which caused build issues with
> randconfig for ax45mp_cache.c. To avoid this issue add a RISCV dependency
> on AX45MP_L2_CACHE config.

Looks good to me, thanks. I will apply it soon if it passes testing
and if there are no other comments.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--F1Ah9b1UnUoleVi5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZcspMQAKCRAw5/Bqldv6
8gXoAJ4wb2wwmFE8HTZ+YIwVQUfg5/EtNQCghQ6ZQuBDjiJMWKi7367p9gOIDHk=
=t0Mt
-----END PGP SIGNATURE-----

--F1Ah9b1UnUoleVi5--

