Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9C52C27C79
	for <webhook@archiver.kernel.org>; Mon, 17 Jun 2024 11:49:54 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web10.54718.1718624987594107012
 for <cip-dev@lists.cip-project.org>;
 Mon, 17 Jun 2024 04:49:47 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 2A5D91C0082; Mon, 17 Jun 2024 13:49:46 +0200 (CEST)
Date: Mon, 17 Jun 2024 13:49:45 +0200
From: Pavel Machek <pavel@denx.de>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH 5.10.y-cip 07/14] dt-bindings: display: Document Renesas
 RZ/G2L DU bindings
Message-ID: <ZnAi2dawElgdK/b9@duo.ucw.cz>
References: <20240614101308.40407-1-biju.das.jz@bp.renesas.com>
 <20240614101308.40407-8-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="lbQNGZQPfvqVk1s9"
Content-Disposition: inline
In-Reply-To: <20240614101308.40407-8-biju.das.jz@bp.renesas.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 17 Jun 2024 11:49:54 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16262


--lbQNGZQPfvqVk1s9
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> commit c1bb7f9f1e151bb50888666108e66ad2848e030d upstream.
>=20
> The RZ/G2L LCD controller is composed of Frame Compression Processor
> (FCPVD), Video Signal Processor (VSPD), and Display Unit (DU).
>=20
> The DU module supports the following hardware features
> =E2=88=92 Display Parallel Interface (DPI) and MIPI LINK Video Interface
> =E2=88=92 Display timing master
> =E2=88=92 Generates video timings
> =E2=88=92 Selecting the polarity of output DCLK, HSYNC, VSYNC, and DE
> =E2=88=92 Supports Progressive
> =E2=88=92 Input data format (from VSPD): RGB888, RGB666
> =E2=88=92 Output data format: same as Input data format
> =E2=88=92 Supporting Full HD (1920 pixels x 1080 lines) for MIPI-DSI Outp=
ut
> =E2=88=92 Supporting WXGA (1280 pixels x 800 lines) for Parallel Output

This is somehow interesting information, but will likely get lost in
the changelogs. I'd not mind it going to comment somewhere, along with
possible pointer to pdf with datasheet.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--lbQNGZQPfvqVk1s9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZnAi2QAKCRAw5/Bqldv6
8rDLAJ4tDTssZODJhmAkDP7Qt7o0QapPQACgv+0kvKjXHUrn8SoFjLRb0ifSKBM=
=3sAY
-----END PGP SIGNATURE-----

--lbQNGZQPfvqVk1s9--

