Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3917AC3600C
	for <webhook@archiver.kernel.org>; Mon, 31 Mar 2025 09:07:30 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.web10.47705.1743412040356405393
 for <cip-dev@lists.cip-project.org>;
 Mon, 31 Mar 2025 02:07:20 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=IYRSOORg;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 8AC0F10269949;
	Mon, 31 Mar 2025 11:07:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1743412038; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=WOm7FtuVbLKuM+5DXpU0Ws3MQ6Tfi+6YspwAk3a7kCQ=;
	b=IYRSOORghLL23m6+BC6+R6/2/SbCOWBPpGmayrhdkVflQKbsbSboPcI/0/1mzLNtN6Lt0b
	r5SAcBtFbjbgWQHyjXx2sg0qcR8AhimXXxYY1Glk07lxgha4Ok0Ci+kwytU/DVUBa3ncbd
	e6eZcYoBpEa2LwwhLuGXqCmMVpmPoSjgg/NUEANZrwLfLJzTmpaLSd9UfrZv0fXnmr9RyQ
	WJrWpArD6646vnWHfkHiN0g69dNAFsD9ZONVkx1JvcpNaeBUrGzLTXmMbjTAwzMVGwjJrL
	etA2rJCJAD0p3P3tTtygdQUaSASC4b9dI1O/N99kAhlAJe/fANNYI3Q4TPNo9w==
Date: Mon, 31 Mar 2025 11:07:10 +0200
From: Pavel Machek <pavel@denx.de>
To: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: Re: [PATCH 6.1.y-cip 00/21] Add support for Renesas RZ/G3E SoC and
 SMARC-EVK platform
Message-ID: <Z+pbPvuQ8jcpDAwX@duo.ucw.cz>
References: <20250321110021.3612805-1-tommaso.merciai.xr@bp.renesas.com>
 <Z+P5EcmP5S5leD9O@duo.ucw.cz>
 <Z-QEcdrAz23PkN7h@tom-desktop>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="YS6SDlGeT5cWPmTH"
Content-Disposition: inline
In-Reply-To: <Z-QEcdrAz23PkN7h@tom-desktop>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 31 Mar 2025 09:07:30 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18386


--YS6SDlGeT5cWPmTH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > > This patch series adds initial support for the Renesas RZ/G3E SoC and
> > > RZ/G3E SMARC EVK platform to linux-6.1.y-cip kernel. The RZ/G3E devic=
e is a
> > > general-purpose microprocessor with a quad-core CA-55, single core CM=
-33,
> > > Ethos-U55 NPU, Mali-G52 3-D Graphics and other peripherals.
> > >=20
> > > All patches are cherry-picked from mainline kernel.
> >=20
> > Thank you, applied.
>=20
> Thanks for the update! :)
>=20
> Next step will be: pinctrl support
>=20
> This for 6.1.y-cip will be a patchset from:
>=20
> [6.1.y-cip,23/85] dt-bindings: pinctrl: renesas: Add alpha-numerical port=
 support for RZ/V2H
> ..
> to
> [6.1.y-cip,64/85] arm64: dts: renesas: r9a09g047: Add pincontrol node
> +
> [6.1.y-cip,77/85] arm64: dts: renesas: r9a09g047e57-smarc: Add SCIF pinco=
ntrol

Series of 40 patches is still a bit big, but if you can't split them
more... just submit, we'll likely deal with them eventually. Both 6.1
and 6.12 versions, please.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--YS6SDlGeT5cWPmTH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZ+pbPgAKCRAw5/Bqldv6
8hQ3AJ4z/XW+kbHcVi8K+tcXIT9oNpuXcQCglSzJ1D7PoGtwjBb/YbbTJ2hD7B0=
=Of6i
-----END PGP SIGNATURE-----

--YS6SDlGeT5cWPmTH--

