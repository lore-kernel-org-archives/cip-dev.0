Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79D70C83F1D
	for <webhook@archiver.kernel.org>; Tue, 15 Jul 2025 08:36:56 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.web11.3473.1752568609608892966
 for <cip-dev@lists.cip-project.org>;
 Tue, 15 Jul 2025 01:36:50 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=ERxaQzke;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A589D10397286;
	Tue, 15 Jul 2025 10:36:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1752568607; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=G51tPfz2TQvKNe/UwMBs08F47b1+hyEHVj7xoam49Jk=;
	b=ERxaQzkel14fvdBrInflu+C+qL5751yNslGNaqkdNdhtH9UO5o/K7azG1fHXL/i/VrWhlw
	czxGT7wA60e8324rPjqvtAbc2FGhMt+DincqLnximInjN0sL13mH0Ok35/aJch+RopQyRN
	SHVObN5yf69NAYpSD8Dh+KD1fbpEdO1Ln67QnSXEvwiobPPaYQTECkDAqLkgZjazZrKxll
	F4q8OdeFhYvcykFtiypVvkonjudxdTJNW3/6zggIehMEHFJfc2yNZK8kOZZE9TDC03Mf0r
	KAC6ljG87VjKOElT2Rudkl80LvAhFPbpSyBf1zeUd36+KitbP3JJVAC0XesTjw==
Date: Tue, 15 Jul 2025 10:36:40 +0200
From: Pavel Machek <pavel@denx.de>
To: nobuhiro1.iwamatsu@toshiba.co.jp
Cc: biju.das.jz@bp.renesas.com, prabhakar.mahadev-lad.rj@bp.renesas.com,
	cip-dev@lists.cip-project.org
Subject: Re: [PATCH 6.12.y-cip 00/36] Add RZ/G3E CANFD support
Message-ID: <aHYTGOz8K/zKA08z@duo.ucw.cz>
References: <20250714101650.80381-1-biju.das.jz@bp.renesas.com>
 <TY7PR01MB148185D54E4F592CCD62938D79257A@TY7PR01MB14818.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="80lXVyTIqjf6fg5e"
Content-Disposition: inline
In-Reply-To: <TY7PR01MB148185D54E4F592CCD62938D79257A@TY7PR01MB14818.jpnprd01.prod.outlook.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 15 Jul 2025 08:36:56 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19534


--80lXVyTIqjf6fg5e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!


> I reviewed this series, looks good to me.
> I can apply, if there are no other comments and test was OK.
>   Test: https://gitlab.com/cip-project/cip-kernel/linux-cip/-/pipelines/1=
926889907
>=20
> Reviewed-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>

Thank you, I added "Reviewed-by:" tag and pushed the series.

Best regards,
								Pavel
--=20
In cooperation with DENX Software Engineering GmbH, HRB 165235 Munich,
Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--80lXVyTIqjf6fg5e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaHYTGAAKCRAw5/Bqldv6
8irFAJwJQIaIB2ZFrawwCNq8OvK5/S43kACgqepDN5AbULDRQKJ/gsju6xRs9ko=
=g2RP
-----END PGP SIGNATURE-----

--80lXVyTIqjf6fg5e--

