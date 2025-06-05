Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46855C5B543
	for <webhook@archiver.kernel.org>; Thu,  5 Jun 2025 10:28:59 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.web11.4063.1749119335490503761
 for <cip-dev@lists.cip-project.org>;
 Thu, 05 Jun 2025 03:28:55 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=AE8YYJym;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id BDED010397298;
	Thu,  5 Jun 2025 12:28:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1749119333; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=nHF9hoW0ai5y+UbVIgGfd7OtMY7CzfUPMEq2zlOBk90=;
	b=AE8YYJymamPrX+laZw38ZfWGbiRfjHPvhmPG7UyUXN2JvSRoa0c3hKkaheQvkp7NC/mBdf
	Y8RvddbrSALjzWxtk4gNGTqAGeFCxgAYAmP1/gJDvuRcwfirnRJd/1Dc1W0soJg/VhH0b0
	sc+T4kC3e6w0AcjA8uXoCT0Asld4C5k9BVYsJcUKv/tj+Ly1lXn8U1NxdIOlPKKUGwc/n3
	QjLhOCUFOf2uVaa2ZOs0NkrrOlUx3CGLKtE51fef5q8j2vt3tGtPJiTHnyz7IwUrkAmHdh
	RJd8XMDifZ3XABNPVNkWtCLOK5LeyW/j5jheyrCfBjXZOtLPiT2W6L3F7sLBDw==
Date: Thu, 5 Jun 2025 12:28:48 +0200
From: Pavel Machek <pavel@denx.de>
To: nobuhiro1.iwamatsu@toshiba.co.jp
Cc: claudiu.beznea@tuxon.dev, cip-dev@lists.cip-project.org
Subject: Re: [cip-dev] [PATCH 5.10.y-cip 0/8] RZ/G3S: Backport SCIF support
Message-ID: <aEFxYFhLKPgJpBKn@duo.ucw.cz>
References: <20250603091903.3917202-1-claudiu.beznea.uj@bp.renesas.com>
 <TY7PR01MB14818FD9A1E03EE9BF60F7EF1926CA@TY7PR01MB14818.jpnprd01.prod.outlook.com>
 <aECfTblonQThFl+1@duo.ucw.cz>
 <TY7PR01MB14818CED682D83FFDB9849B33926CA@TY7PR01MB14818.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="yUo20xYG85819zcE"
Content-Disposition: inline
In-Reply-To: <TY7PR01MB14818CED682D83FFDB9849B33926CA@TY7PR01MB14818.jpnprd01.prod.outlook.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 05 Jun 2025 10:28:59 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19021


--yUo20xYG85819zcE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> I seem to be on the wrong branch you are pushing.
> I will revert the linux-5.10.y-cip-rt branch with force push and update l=
inux-5.10.y-cip.
>=20
> linux-5.10.y-cip-rt:
>   https://gitlab.com/cip-project/cip-kernel/linux-cip/-/commits/linux-5.1=
0.y-cip-rt
>=20
> linux-5.10.y-cip:
>   https://gitlab.com/cip-project/cip-kernel/linux-cip/-/commits/linux-5.1=
0.y-cip

Yep, sorry. Thanks for fixing that.

Best regards,
									Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--yUo20xYG85819zcE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaEFxYAAKCRAw5/Bqldv6
8laeAJ9emWIqnuuVsj0Cu11EscashxYWJQCfUG2hifu3FiCnsfLp3dThVLeQ9eM=
=orHM
-----END PGP SIGNATURE-----

--yUo20xYG85819zcE--

