Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06583C88E71
	for <webhook@archiver.kernel.org>; Mon, 14 Sep 2026 12:09:36 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.18524.1789387774302053341
 for <cip-dev@lists.cip-project.org>;
 Mon, 14 Sep 2026 05:09:34 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=bFZmsjLg;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 61439103EBB;
	Mon, 14 Sep 2026 14:09:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1789387768;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=dBZOYkNAkHRLEhxg440yciGWg5lhWbYOEHBLtrW6YQU=;
	b=bFZmsjLgQoRmY7elVwIkfYeHZMAox6ZteVs8x4LbDPM1YpsZ4GtyH+j9Hiw+KxxJHRK6CU
	lZ30dm7ssoAVelymTZHTWBzUGJV+lYamZxw1F6YByPutTCNASXFZ4ZWIWWaQqMrf0Scjaq
	2qYnEJt1eY0Gt0xnK//tVInC4NOC6kqYdlmEXty0oSz5iXmhN8Sed+07UXudrZQaeML1yV
	fwsEkoiyhDIioamp36iY8teyE06/kSkM7fKU0yM3alhSS0SiaKBJrsoYGdPTIp6uxxG6a2
	X+qOP/xrqaxQUwzPrgmCieTdMup4mVfkR6azANqUzJ/Ks1OVOEKQJacLVt4XMQ==
Date: Mon, 14 Sep 2026 14:09:27 +0200
From: Pavel Machek <pavel@nabladev.com>
To: nobuhiro.iwamatsu.x90@mail.toshiba
Cc: claudiu.beznea@tuxon.dev, pavel@nabladev.com,
	cip-dev@lists.cip-project.org
Subject: Re: [cip-dev] [PATCH linux-6.12.y-cip 0/2] mmc: renesas_sdhi:
 Backport support for RZ/G2{E,N}
Message-ID: <aqfj98a8wtQw6a-w@duo.ucw.cz>
References: <20260911140311.2119765-1-claudiu.beznea@tuxon.dev>
 <TY7PR01MB148188FD3311B30DB2C98085DCDBB2@TY7PR01MB14818.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3cGFCUDYPODiXpkI"
Content-Disposition: inline
In-Reply-To: <TY7PR01MB148188FD3311B30DB2C98085DCDBB2@TY7PR01MB14818.jpnprd01.prod.outlook.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 14 Sep 2026 12:09:36 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24175


--3cGFCUDYPODiXpkI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> >  drivers/mmc/host/renesas_sdhi_internal_dmac.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >=20
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

--3cGFCUDYPODiXpkI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaqfj9wAKCRAw5/Bqldv6
8n1pAJ9jVdJdWAjFqpYQJiBN9No1imijxACfRuTkOt02KC6UwhziUZlCZA4162I=
=O+wh
-----END PGP SIGNATURE-----

--3cGFCUDYPODiXpkI--

