Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ECFFC48286
	for <webhook@archiver.kernel.org>; Tue,  6 Feb 2024 08:29:24 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web10.17297.1707208161054364802
 for <cip-dev@lists.cip-project.org>;
 Tue, 06 Feb 2024 00:29:21 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 1640F1C0081; Tue,  6 Feb 2024 09:29:17 +0100 (CET)
Date: Tue, 6 Feb 2024 09:29:16 +0100
From: Pavel Machek <pavel@denx.de>
To: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>, Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [PATCH 5.10.y-cip 00/48] Add support for Renesas RZ/Five RISC-V
 SoC
Message-ID: <ZcHt3L9g6EtZ1OJj@duo.ucw.cz>
References: <20240205124135.14779-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gVTAPA/hZvRgID8v"
Content-Disposition: inline
In-Reply-To: <20240205124135.14779-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 06 Feb 2024 08:29:24 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14775


--gVTAPA/hZvRgID8v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This patch series aims to add support for Renesas RZ/Five RISC-V SoC,
> support for this SoC has already been added to 6.1-cip kernel.
>=20
> RFC->v1
> * Patch #35 updated according uptstream for easier maitainance.
>   Rest of the patches have been unchanged.
> * Merged RFC series [0] and preporatory series [1].
> * Previous test run results can be found at [2].
> * RISC-V Renesas defconfig file can be found at [3].

I tried to apply/test the series, and besides 1..4 being already
applied, these failed, too:

Can you double-check?

> Christoph Hellwig (5):
>   dma-direct: add support for dma_coherent_default_memory
>   dma-mapping: allow using the global coherent pool for !ARM
>   dma-mapping: simplify dma_init_coherent_memory
>   dma-mapping: add a dma_init_global_coherent helper
>   dma-mapping: make the global coherent pool conditional

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--gVTAPA/hZvRgID8v
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZcHt3AAKCRAw5/Bqldv6
8vSqAKCC3bfyTqRXJt8tiv7Obj8f4FxqFwCgoJ2dekw3uJwtWVfd6pX3+us5qcQ=
=/ReL
-----END PGP SIGNATURE-----

--gVTAPA/hZvRgID8v--

