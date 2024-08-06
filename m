Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6DF4C52D70
	for <webhook@archiver.kernel.org>; Tue,  6 Aug 2024 18:20:22 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web10.14177.1722968409266171405
 for <cip-dev@lists.cip-project.org>;
 Tue, 06 Aug 2024 11:20:09 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id CDD081C0082; Tue,  6 Aug 2024 20:20:06 +0200 (CEST)
Date: Tue, 6 Aug 2024 20:20:04 +0200
From: Pavel Machek <pavel@denx.de>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH 6.1.y-cip 00/30] Add support for RZ/{G2L,G2LC,G2UL,V2L}
 Camera Data Receiving Unit
Message-ID: <ZrJpVA7OnJk1sPmC@duo.ucw.cz>
References: <20240805164342.211857-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="9Hgc9lcORXAN42TD"
Content-Disposition: inline
In-Reply-To: <20240805164342.211857-1-biju.das.jz@bp.renesas.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 06 Aug 2024 18:20:22 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16754


--9Hgc9lcORXAN42TD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This patch series aim to add support for RZ/{G2L,G2LC,G2UL,V2L} Camera
> Data Receiving Unit(a.k.a CRU)

Thanks for series. I'm still reviewing it, but don't expect anything
but minor comments. I can apply this if it passes testing and there
are no other comments.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--9Hgc9lcORXAN42TD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZrJpVAAKCRAw5/Bqldv6
8gnsAJwLKsNHzz6wK0ojZga/ntsE02byQQCgsGXPlqI4RlSJaOzF/Mm3V1ZY2bA=
=BUOB
-----END PGP SIGNATURE-----

--9Hgc9lcORXAN42TD--

