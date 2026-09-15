Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F992C88E75
	for <webhook@archiver.kernel.org>; Tue, 15 Sep 2026 13:41:15 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.23397.1789479671861964853
 for <cip-dev@lists.cip-project.org>;
 Tue, 15 Sep 2026 06:41:12 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=M5vasMFR;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 33E971040EE;
	Tue, 15 Sep 2026 15:41:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1789479666;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=sGZZvI3tRi34K+nERMwrGlyxje1v/KQkHJv4VKMtGCI=;
	b=M5vasMFRziml5uKww/S9muf8wSCeHL5XLOau4kuHDCHoD02SIpwaPUWuyIWW4GmeqfnDPn
	U7lugwSMNPM/n3yUOp9YycGRBPAC7rdLJpXxAg8otyS3n0r+qWHiDvw1EPjR3jMzTtnUMq
	TqY2uIZtCSJXpAuYFB/wxm1+6DXbegOuJOsIKxDLyyQ92gjjU+NsjCUq5oYlENfsf24SWh
	fUZcSGrSYsTSJah25Iton5ZLLZG2pgeeQQb2ZkDtcGkuJzfv9tW9ReAet1v627zjT+rHgc
	1lkicE9OMniXL3TMVIhSqPY4zKTydJM5RElTAXzwLgU/Z8ut+QcNva5aQgXsag==
Date: Tue, 15 Sep 2026 15:41:04 +0200
From: Pavel Machek <pavel@nabladev.com>
To: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Cc: nobuhiro.iwamatsu.x90@mail.toshiba, pavel@nabladev.com,
	cip-dev@lists.cip-project.org
Subject: Re: [PATCH linux-6.1.y-cip] pinctrl: renesas: rzg2l: Populate struct
 gpio_chip::set_config
Message-ID: <aqlK8Dj8O1ax-sfu@duo.ucw.cz>
References: <20260915122333.2531384-1-claudiu.beznea@tuxon.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="oZkhMBhUvlYYDRSJ"
Content-Disposition: inline
In-Reply-To: <20260915122333.2531384-1-claudiu.beznea@tuxon.dev>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 15 Sep 2026 13:41:15 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24189


--oZkhMBhUvlYYDRSJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>=20
> commit 60a19a68779b1f24e3160c8e4317d0334a397687 upstream.
>=20
> Populate struct gpio_chip::set_config to allow various GPIO
> settings.

This looks okay to me.

Reviewed-by: Pavel Machek <pavel@nabladev.com>

I can apply it if it passes testing and there are no other comments.

Best regards,
                                                                Pavel

--oZkhMBhUvlYYDRSJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaqlK8AAKCRAw5/Bqldv6
8i+GAKCZyJaLwuXxoiHkwWw9PqAEXWTQEACffFMRHNN7gJRnQtWhHZib19yIPOw=
=h++P
-----END PGP SIGNATURE-----

--oZkhMBhUvlYYDRSJ--

