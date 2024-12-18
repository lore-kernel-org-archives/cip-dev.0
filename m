Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E8E5E77188
	for <webhook@archiver.kernel.org>; Wed, 18 Dec 2024 15:42:26 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.web11.108498.1734536537991534693
 for <cip-dev@lists.cip-project.org>;
 Wed, 18 Dec 2024 07:42:18 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=R61BfLZ6;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 0C0441048558D;
	Wed, 18 Dec 2024 16:42:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1734536535;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1nBgpfNZao0+KPO5N9/Ul6YMZziErcPVLZGux0GDJaA=;
	b=R61BfLZ6+dvTD4na3DTNHxiIIDkNh82t6+nFMPOiMXOBsoSQSmoCbOiQB0zhewuNeTOeiP
	omMW0qpMuu8LnIhqyAcT2Vry49TQZb6AOwby1YXGU2lfXFAlC0e+wpweHxQafSgYcRK4WG
	NZyKtTgooiVhDGJw+ZEt4JOcWAXA+Jb4gHKQJ7622jEWIFMcZRm4BzeSt7rVfOevZP5zIJ
	Jl0Fstqmrp9WbmEJ1vx0p+Sg2s6lTw8k8A8J/4O1/T9ZUqvACu45/vzVAc0k0IKRAuwu/m
	jZhEA0lKer9LsmQUFjhTjaAKuQ6xt2WVtJULcvUCEwz7FObpk7D7QWZ/Xz5Zaw==
Date: Wed, 18 Dec 2024 16:42:11 +0100
From: Pavel Machek <pavel@denx.de>
To: cip-dev@lists.cip-project.org
Cc: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>, Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [cip-dev] [PATCH 5.10.y-cip] clk: renesas: rzg2l: Fix
 FOUTPOSTDIV clk
Message-ID: <Z2LtUxuoeoWyYcLj@duo.ucw.cz>
References: <20241211181524.28027-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6ncBYD7ViE75z26J"
Content-Disposition: inline
In-Reply-To: <20241211181524.28027-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 18 Dec 2024 15:42:26 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17466


--6ncBYD7ViE75z26J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> commit dabf72b85f298970e86891b5218459c17b57b26a upstream.
>=20
> While computing foutpostdiv_rate, the value of params->pl5_fracin
> is discarded, which results in the wrong refresh rate. Fix the formula
> for computing foutpostdiv_rate.

Sorry for the delay. This looks okay to me, and I can apply it (*).

Best regards,
								Pavel
(*) if it tests ok and nobody raises objections.
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--6ncBYD7ViE75z26J
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZ2LtUwAKCRAw5/Bqldv6
8pPlAJwJMmw+ckZX2GAYQF0xvP2UFOzazgCZAbOEc5ULYisLt7WIWIyyHBy1No0=
=bQIr
-----END PGP SIGNATURE-----

--6ncBYD7ViE75z26J--

