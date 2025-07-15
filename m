Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0734C83F1D
	for <webhook@archiver.kernel.org>; Tue, 15 Jul 2025 09:52:26 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.web10.4703.1752573142151435014
 for <cip-dev@lists.cip-project.org>;
 Tue, 15 Jul 2025 02:52:22 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=MDlw+ymS;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 6DD3A103972A9;
	Tue, 15 Jul 2025 11:52:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1752573140; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=JDFfVXBahZWDSvm+Zzbbam1HUIcVyw4QRpMfV2LeVBI=;
	b=MDlw+ymSKQ2a1bOYs9ViMou+l8+lle9TrkiFmsybnp//p5qPSpNnpHIksk6C+2Q2VEjQ6R
	nkdOfPmncBxhO4borGPKejL7uehd4WdjyL2lffpfHL5UikvM210lqJG0VG6+bwLWRrY5Ga
	8AZ9mUqD1h1gf72bzIkD68Qj6tae195nzr6/WtPggVvPCvGxJZnJs1gBX+Fbj2HaNpNIeJ
	oFvoZOanEi6C+tPFVnhJpJ+Sxem2QvecvUPlfxFcuM1+/b5dzwdEE0tRg5w6FXejCAzklC
	qab1b1nJw77R9aLC2Pem36bIVyh9zxam+NvB4zo11AY+GEt/R2xZMAdQiVeKBg==
Date: Tue, 15 Jul 2025 11:52:13 +0200
From: Pavel Machek <pavel@denx.de>
To: nobuhiro1.iwamatsu@toshiba.co.jp
Cc: biju.das.jz@bp.renesas.com, prabhakar.mahadev-lad.rj@bp.renesas.com,
	cip-dev@lists.cip-project.org
Subject: Re: [PATCH 6.1.y-cip 00/57] Add RZ/G3E CANFD support
Message-ID: <aHYkzfU4CK+2mVNk@duo.ucw.cz>
References: <20250714100802.80035-1-biju.das.jz@bp.renesas.com>
 <TY7PR01MB1481840869EEEC9F33313D7379257A@TY7PR01MB14818.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qQe1dFcFVwPGnZqq"
Content-Disposition: inline
In-Reply-To: <TY7PR01MB1481840869EEEC9F33313D7379257A@TY7PR01MB14818.jpnprd01.prod.outlook.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 15 Jul 2025 09:52:26 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19535


--qQe1dFcFVwPGnZqq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

>=20
> I reviewed this series, looks good to me.
> I can apply, if there are no other comments and test was OK.
>   Test: https://gitlab.com/cip-project/cip-kernel/linux-cip/-/pipelines/1=
926888333
>=20
> Reviewed-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>

Thank you, I added your Reviewed-by tag and applied the series.

Best regards,
                                                                Pavel
--=20
In cooperation with DENX Software Engineering GmbH, HRB 165235 Munich,
Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--qQe1dFcFVwPGnZqq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaHYkzQAKCRAw5/Bqldv6
8mF1AJ96yBLpa3KYQJjLm+cNvEpgs38cJQCgj/DmKOsoxpKxT/zL1Rho9Sfj5u8=
=Z/aZ
-----END PGP SIGNATURE-----

--qQe1dFcFVwPGnZqq--

