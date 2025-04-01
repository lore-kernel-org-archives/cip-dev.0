Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F83FC36017
	for <webhook@archiver.kernel.org>; Tue,  1 Apr 2025 10:30:01 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.web10.15645.1743503391227972081
 for <cip-dev@lists.cip-project.org>;
 Tue, 01 Apr 2025 03:29:51 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=IJyAj1DW;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 70B8E101CF951;
	Tue,  1 Apr 2025 12:29:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1743503389; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=ooUP81rBPJsh+g5Ti0RP9QSXEqKphGT5j+1hCjhI0XU=;
	b=IJyAj1DWcWnuRn8pHsBjmXVj1nxwmd6upe0Mb3PPUHreQRb/wyC1dwWxPDrBbpdtDSOlgR
	oVJGsY7RnTK23B+4LY07KIIavuAmeyFO1VTwX9f8arDsRhX9WQRk+pVuIey9MCesDjaa6R
	HJT7Un9KWws+LcD4elKiT8tsvd8Id3R6dxk4Cv4/iJRx4LTtAINbng8xc18FZ9BD8HXsgT
	YVH3zmF3jdtpgq12KO+asvADJNkPngmfbtAgfakQVrGW7yCn8la2WYr8DYKLSmRkhbfXii
	YIJioorL1FwpDMi9fv3wZLdH32+eStS2vMybv3JEECP1bIxzauwLpvy21toB2A==
Date: Tue, 1 Apr 2025 12:29:45 +0200
From: Pavel Machek <pavel@denx.de>
To: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: Re: [PATCH 6.12.y-cip 00/13] Add RZ/G3E pinctrl support
Message-ID: <Z+vAGQRiwGV7SrKJ@duo.ucw.cz>
References: <20250331110659.252237-1-tommaso.merciai.xr@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4wyp1P+ez9lAXMsj"
Content-Disposition: inline
In-Reply-To: <20250331110659.252237-1-tommaso.merciai.xr@bp.renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 01 Apr 2025 10:30:01 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18447


--4wyp1P+ez9lAXMsj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This patch series adds pin controller support for the Renesas RZ/G3E(R9A0=
9G047)
> SoC to linux-6.12.y-cip kernel, this series adds also device node for SCIF
> pincontrol into RZ/G3E SMARC EVK board dts.
> The RZ/G3E PFC (Pin Function Controller) is almost similar to the one fou=
nd
> into the RZ/V2H which is in turn similar to the one found into the RZ/G2L=
 SoC,
> for this reason pinctrl-rzg2l.c has been re-used.
>=20
> All patches are cherry-picked from mainline kernel.

I believe 5/ was misapplied and is no longer neccessary.

If it passes testing and there are no other comments, I can apply the
series.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--4wyp1P+ez9lAXMsj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZ+vAGQAKCRAw5/Bqldv6
8t54AKDEan8LSafZ/lw2qqZEVmkIjc7aIQCfe3zgLWuEDvEuMn76K5p5B1Gsets=
=X+cP
-----END PGP SIGNATURE-----

--4wyp1P+ez9lAXMsj--

