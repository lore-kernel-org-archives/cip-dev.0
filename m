Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38276C282EC
	for <webhook@archiver.kernel.org>; Fri, 14 Mar 2025 10:26:04 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.web10.10680.1741947956943633086
 for <cip-dev@lists.cip-project.org>;
 Fri, 14 Mar 2025 03:25:57 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=KgJ/P3C2;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 83B4910382F1A;
	Fri, 14 Mar 2025 11:25:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1741947955; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=KfEiO4uvTcKSLaaoKRxVvpOxYngC0dcvdcQliujCk7Y=;
	b=KgJ/P3C2ZsHDDKk5Lp+CXqCNg12C3Y3LYyHAPXjsWiVQP/TfGkN/En2dCsJjBFVNGJiGWA
	h4D4Ot/yk/NUJlGHJ4v3NzkD5ycP+HpO8hY/sb5/XKXIXuYKfgHJhjNBVQVTcGYBf3lkwR
	IrzyegyiutQNOzMH0kqoWotKrnQxcphCJZwlrMxR9M4MgGPtSHty4vskLo8Ps79VdqxIb2
	P0qf86svJk5xO2bcZ/tcMdK52vNuGzzkbBrcOdJ+kJYhSF/8g241R0DARTfGA2e02DfEMV
	yQvn2K0ASDraVsVx9zhCqwMHB4Fr7h4i5+EKPaV3jb4eOIPxtjPi5QJITKyY2w==
Date: Fri, 14 Mar 2025 11:25:48 +0100
From: Pavel Machek <pavel@denx.de>
To: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>, Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: Re: [PATCH 6.1.y-cip 21/85] soc: renesas: Add RZ/G3E (R9A09G047)
 config option
Message-ID: <Z9QELAp5qdsDUqkX@duo.ucw.cz>
References: <20250312112302.1605750-1-tommaso.merciai.xr@bp.renesas.com>
 <20250312112302.1605750-22-tommaso.merciai.xr@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Bgvds+ayHLfZd15r"
Content-Disposition: inline
In-Reply-To: <20250312112302.1605750-22-tommaso.merciai.xr@bp.renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 14 Mar 2025 10:26:04 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18211


--Bgvds+ayHLfZd15r
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> From: Biju Das <biju.das.jz@bp.renesas.com>
>=20
> commit 	12e0bd600e3c2f33f9db0e3b91f6b8d8d95b7dbe upstream.

There's strange whitespace between "commit" and hash.

> Add a configuration option for the RZ/G3E SoC.

But what I wanted to say is that this seems like good place where to
split the series. If you are enabling it, it should already be
booting.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--Bgvds+ayHLfZd15r
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZ9QELAAKCRAw5/Bqldv6
8o9XAJ9zenr7hbSP4NLNAVj9HIJmbcWligCdFvvrmwZKyUpBCZO1GoxGnzLDiAY=
=k9xU
-----END PGP SIGNATURE-----

--Bgvds+ayHLfZd15r--

