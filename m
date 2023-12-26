Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAD5CC46CD3
	for <webhook@archiver.kernel.org>; Tue, 26 Dec 2023 18:30:23 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web10.86713.1703615416638804154
 for <cip-dev@lists.cip-project.org>;
 Tue, 26 Dec 2023 10:30:17 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 93C361C0050; Tue, 26 Dec 2023 19:30:13 +0100 (CET)
Date: Tue, 26 Dec 2023 19:30:12 +0100
From: Pavel Machek <pavel@denx.de>
To: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>, Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [PATCH RFC 00/30] Add support for Renesas RZ/Five RISC-V SoC
Message-ID: <ZYsbtHsG+SLme8vl@duo.ucw.cz>
References: <20231220230646.219816-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xMGxSmsNo8sZE/fh"
Content-Disposition: inline
In-Reply-To: <20231220230646.219816-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 26 Dec 2023 18:30:23 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14195


--xMGxSmsNo8sZE/fh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

Ok, so I went through the series, and there's nothing too
horrible. I'll have some comments sent to individual patches. I'm not
a great fan of 5/, as it touches generic code, but.

Testing did not reveal any breakage... which is not surprising as we
don't test r-v at the moment.

> Sending this series as an RFC mainly beacuse, as the kernel image is not
> generic to all RISC-V platforms as the HW is noncoherent.

I don't understand the "image is not generic". I see the hw is buggy
and needs the workarounds provided in the series, but kernel
configured for your hw should work elsewhere, too (slowly), no?

> Complete defconfig file for RZ/Five can be found at [0].

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--xMGxSmsNo8sZE/fh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZYsbtAAKCRAw5/Bqldv6
8gWkAKDDYo6KRAErOUoVgmf9Mo9dPhHr+gCfav71n0iR75D1iaRe4CIyGt+/G6U=
=4Udr
-----END PGP SIGNATURE-----

--xMGxSmsNo8sZE/fh--

