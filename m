Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6705C88E64
	for <webhook@archiver.kernel.org>; Mon, 14 Sep 2026 12:03:34 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.18617.1789387409677360996
 for <cip-dev@lists.cip-project.org>;
 Mon, 14 Sep 2026 05:03:30 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=Td4La4NO;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 898AD1030CA;
	Mon, 14 Sep 2026 14:03:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1789387403;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=EwSW+TjPWtkmkDjr/nvXch5dnSXr6aES0puF98HAy28=;
	b=Td4La4NOG13aq/uWeiPbE6+4XNooIppgAE6Wk96NXmPY8sBFvMPlhw3ni9Q8X/UFXvkd5j
	XQrbW0pEsuPOIWz3QxZHEbAjkwFTo3oJ7RbaBG9KCHTNCsXAf7S2q365Z+epjHeoaRR2zh
	hk1dZo1vmyebQNM06wm+U93/4yfm8vZw27SogJdiFj4JX6n8W5Qujam31eafPYGgrqc0Mc
	rHjNur56N+AzUSqh2XhSWu8zAFHJ2mqBJJUY+MAfA2QxXU4XXUfj2UkgPxwB7+vb/NrJrr
	SHb6ocNk+5jtI7+MQooaz2KbtkXVyFsk6kbkY0WnEoJN6ct/1GwQVUQBrIsxCw==
Date: Mon, 14 Sep 2026 14:03:16 +0200
From: Pavel Machek <pavel@nabladev.com>
To: nobuhiro.iwamatsu.x90@mail.toshiba
Cc: claudiu.beznea@tuxon.dev, pavel@nabladev.com,
	cip-dev@lists.cip-project.org
Subject: Re: [cip-dev] [PATCH linux-5.10.y-cip 00/14] mmc: renesas_sdhi:
 Backport old info1 register layout
Message-ID: <aqfihPH06IEnYlBG@duo.ucw.cz>
References: <20260911140151.2119555-1-claudiu.beznea@tuxon.dev>
 <TY7PR01MB14818F24F9C791A224F65FADDCDBB2@TY7PR01MB14818.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="GQXZld/PU2minRJW"
Content-Disposition: inline
In-Reply-To: <TY7PR01MB14818F24F9C791A224F65FADDCDBB2@TY7PR01MB14818.jpnprd01.prod.outlook.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 14 Sep 2026 12:03:34 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24173


--GQXZld/PU2minRJW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > Some early Gen3 SoCs have the DTRANEND1 bit at a different location tha=
n all
> > later SoCs. Series backports necessary patches to differentiate b/w old=
 and
> > new register layout. While at it, and since the code is aligned for doi=
ng it now,
> > backport the patches to enable RZ/G2N and RZ/G2E though their own
> > compatible.
> >=20
> > All the patches backported here (except RZ/G2N and RZ/G2E ones) are alr=
eady
> > present in v6.1 and v6.12 CIP kernels.
>=20
> I reviewed this series, looks good to me.
> I can apply this if tests are OK and there are no other comments.
>   Test: https://gitlab.com/cip-project/cip-kernel/linux-cip/-/pipelines/2=
845750901
>=20
> Reviewed-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>

This looks okay to me.

Reviewed-by: Pavel Machek <pavel@nabladev.com>

Best regards,
                                                                Pavel

--GQXZld/PU2minRJW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaqfihAAKCRAw5/Bqldv6
8lmfAJsE7FDoW/1sPMncrRylZHKdGWDq3QCgmsZ3oNAEbIJ7r2xZQVaQPPgC54Q=
=5E8o
-----END PGP SIGNATURE-----

--GQXZld/PU2minRJW--

