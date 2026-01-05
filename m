Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE47DCD0416
	for <webhook@archiver.kernel.org>; Mon,  5 Jan 2026 21:57:43 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.76574.1767650259033260622
 for <cip-dev@lists.cip-project.org>;
 Mon, 05 Jan 2026 13:57:39 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=H+hQLLru;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 1A5991082F0;
	Mon,  5 Jan 2026 22:57:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1767650256;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=44p/HsdnMj7SEk92VuF+0H7IvLAdr1BXhbmmBdE8Aro=;
	b=H+hQLLru3wYyELhK/79/U5eBJTfO9pqsMDzeY78rRLm7IprKQpqE6lujUhdatITtYYncbe
	xClfv4gCthDaw6WpAa/AX4Mr5kwXYj+kLNRI1PfjI4NgWYYOo4Kc/60gphpv9rXZHClAW6
	EtxwI5VeiOscjDDvaSRFmIxq/93SBFBciD1yeBobuq4/5M+l9rW7GfxlIjaG2VS7RqG6My
	NwTF2slFgTixvOTU3DFgcAq1KDzKzraVu98qz9eK7eYgWOD72/Y6YAbJAIlwpb++BEvqMf
	xOj1N9LxS/RuPGLyUeros/ZWWNPWQOpf/df/jeksJXK4NgCmo3oJ2yZkbw6Shg==
Date: Mon, 5 Jan 2026 22:57:34 +0100
From: Pavel Machek <pavel@nabladev.com>
To: nobuhiro.iwamatsu.x90@mail.toshiba
Cc: claudiu.beznea@tuxon.dev, cip-dev@lists.cip-project.org
Subject: Re: [PATCH 6.12.y-cip 0/6] RZ/G3S: Backport TSU support
Message-ID: <aVwzztZNCZN84Kw3@duo.ucw.cz>
References: <20251217103222.4183089-1-claudiu.beznea.uj@bp.renesas.com>
 <TY7PR01MB14818367AD749019DCAAF7364CDB3A@TY7PR01MB14818.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="EbyGyRvaWE+Iwajc"
Content-Disposition: inline
In-Reply-To: <TY7PR01MB14818367AD749019DCAAF7364CDB3A@TY7PR01MB14818.jpnprd01.prod.outlook.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 05 Jan 2026 21:57:43 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21317


--EbyGyRvaWE+Iwajc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > Hi,
> >=20
> > Series backports the TSU (Thermal Sensor Unit) support for RZ/G3S.
>=20
> I reviewed this series for each branches, looks good to me.
> I can apply this if testing is no issue and there are no other comments.
>   https://gitlab.com/cip-project/cip-kernel/linux-cip/-/pipelines/2232119=
913
>   https://gitlab.com/cip-project/cip-kernel/linux-cip/-/pipelines/2232120=
629
>   https://gitlab.com/cip-project/cip-kernel/linux-cip/-/pipelines/2232120=
713
>=20
> Reviewed-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>

Thanks for review, I applied the series and pushed the result.

Best regards,
								Pavel
--=20
In cooperation with Nabla.

--EbyGyRvaWE+Iwajc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaVwzzgAKCRAw5/Bqldv6
8qaaAJ9x6fIupIw5QZ/0Obe8j1uukulNUACeMUkbPjNWSExAKpuwLTNjUXEX66w=
=Bj7a
-----END PGP SIGNATURE-----

--EbyGyRvaWE+Iwajc--

