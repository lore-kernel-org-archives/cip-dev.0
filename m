Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02106C369C2
	for <webhook@archiver.kernel.org>; Tue, 22 Apr 2025 10:14:55 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.web11.36490.1745316887178728168
 for <cip-dev@lists.cip-project.org>;
 Tue, 22 Apr 2025 03:14:47 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=eKtGBy7y;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E22D2103B92C6;
	Tue, 22 Apr 2025 12:14:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1745316885; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=YeJxUv0rJ5oJn6aWmjP3tPYNMx3e6Pa4urjd2VsMfvg=;
	b=eKtGBy7yne7BM5+fOQ2G+1+JquAHVoowEWKyge341DDfNA5m4nPTCeRXvXySUflpI3DxXZ
	/lUUnhoRDmgYcTgLfPToNe3tPKtT/qJiM+CN61ZgqLUJSJzlrpBWSPH3C5FFUSDqGdg9uK
	E2iDHjrX829MkSI1aAr8uG94lu1yQ6xGZQaoQq5TLUSnBgRDv1zwpcrfXNFhwccH0SeRqO
	9Np/QRUT4jAwqIlI/e1bWHzC29IIFmhU19nKfjYztzDfzmPt/L4kch1ywZ84BmSR1wYwqY
	yFGARiey90Xkng2K5I9iWzEcldhwVP2RXyX02o8VtjhqMk7Wjtqn63OX0FT/Mw==
Date: Tue, 22 Apr 2025 12:14:38 +0200
From: Pavel Machek <pavel@denx.de>
To: prabhakar.mahadev-lad.rj@bp.renesas.com
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [cip-dev] [PATCH 5.10.y-cip 0/4] clk: renesas: r9a07g043:
 Add/Fix missing clocks
Message-ID: <aAdsDn4Roqy1Jpu8@duo.ucw.cz>
References: <20250421165921.631205-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3aRWe0KsL86DG/98"
Content-Disposition: inline
In-Reply-To: <20250421165921.631205-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 22 Apr 2025 10:14:55 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18546


--3aRWe0KsL86DG/98
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Hi All,
>=20
> Add/Fix missing clocks for RZ/Five SoC, also included
> miscellaneous fixes while at it.
>=20
> Note, all the patches have been cherry-picked from upstream
> kernel.

Patches look ok to me.

Reviewed-by: Pavel Machek <pavel@denx.de>

This one is missing in 6.12:

>   clk: renesas: r9a07g043: Fix HP clock source for RZ/Five

We should have 6.12 versions before we apply this.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--3aRWe0KsL86DG/98
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaAdsDgAKCRAw5/Bqldv6
8j55AJ0YHhsso+S4XcMZ6m+Y+i12XXsaVACguVQt2NNZi//kvvGSvsSTb+GffP4=
=zxjs
-----END PGP SIGNATURE-----

--3aRWe0KsL86DG/98--

