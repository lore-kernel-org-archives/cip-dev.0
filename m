Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF3F8CA0EFA
	for <webhook@archiver.kernel.org>; Sat, 23 Aug 2025 06:44:28 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.web11.2083.1755931467608194105
 for <cip-dev@lists.cip-project.org>;
 Fri, 22 Aug 2025 23:44:28 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=GY2h+2uV;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E43FE101F54FB;
	Sat, 23 Aug 2025 08:44:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1755931465; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=Y9QLGJeWNPxlov26Slli6Vcc5pvfnRc6RcVd0ul8Hbw=;
	b=GY2h+2uVQZHa6x/VBMlE1AaZLfJg8SAie/bCodFDfJL6rNTzU0K0pkp6HrsfrQAULo/aD7
	SSEd+K8qs+aTfppTiwx8L8YQsCI3LJdQd6CS5fAs6b8rN4L/93YUjGCs7yxfkb0YRxRwvJ
	d9kbuuxFAZZbS6pVkr8pneY5GmUlYu6gm6ev/l0PN6UJgeXlPKkxi4W9ma1b6Q/QdxV5IT
	t5RrzOkp2xV5KtvD4was/4B5AW1yPkW3Xy85zMAPiL3LAKRCXD/P7mTHp+BZ6vr5DNSYl0
	qjmbrEvBPnLGTHAGYGwb46CN42bPy1o2ilenluDHmEcagf2CVtPJsKG75yfpVw==
Date: Sat, 23 Aug 2025 08:44:19 +0200
From: Pavel Machek <pavel@denx.de>
To: nobuhiro.iwamatsu.x90@mail.toshiba
Cc: biju.das.jz@bp.renesas.com, cip-dev@lists.cip-project.org,
	prabhakar.mahadev-lad.rj@bp.renesas.com
Subject: Re: [PATCH 6.12.y-cip 00/23] Add RZ/G3E XSPI support
Message-ID: <aKljQ3snzUFjtkCf@duo.ucw.cz>
References: <20250820084645.6988-1-biju.das.jz@bp.renesas.com>
 <TY7PR01MB1481849D89F677869EAED3818CD3DA@TY7PR01MB14818.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4E7axJRwWKwGa4SX"
Content-Disposition: inline
In-Reply-To: <TY7PR01MB1481849D89F677869EAED3818CD3DA@TY7PR01MB14818.jpnprd01.prod.outlook.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 23 Aug 2025 06:44:28 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19952


--4E7axJRwWKwGa4SX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> I reviewed this series, LGTM.
> I can apply, if there are no other comments and test is no issue.
>   https://gitlab.com/cip-project/cip-kernel/linux-cip/-/pipelines/1997754=
244
>=20
> Reviewed-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>

Thank you, applied and pushed out.

Best regards,
								Pavel

--=20
In cooperation with DENX Software Engineering GmbH, HRB 165235 Munich,
Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--4E7axJRwWKwGa4SX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaKljQwAKCRAw5/Bqldv6
8iF8AJ9zvKXOe9A+CRrEcnq5rm5IRCadiwCfduap8kOfTjSy9dxu5NtGsHzjT48=
=9C7S
-----END PGP SIGNATURE-----

--4E7axJRwWKwGa4SX--

