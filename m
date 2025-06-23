Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 719E7C77B7F
	for <webhook@archiver.kernel.org>; Mon, 23 Jun 2025 11:11:09 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.web11.17143.1750677066861661375
 for <cip-dev@lists.cip-project.org>;
 Mon, 23 Jun 2025 04:11:07 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=Me9bYqK1;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B160510246DB8;
	Mon, 23 Jun 2025 13:10:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1750677064; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=1ph97100VM82Ht87+4NyLzl7+gBQnp0kBK8ZH8MSKoU=;
	b=Me9bYqK1BgMrRy8+SLUsaC/kfBJ9++WZ9n1iGTR8pyCHfqMrL/MSCGXw8OoFqTJ/dBAd/0
	Zx+a/VvXRxp+ecdRrOt3B1aFEwNvuTHsG9NER1CJJggjIaxSVANYU7cxpeKmtkApKriGgI
	B9yY4QB+bWQwF2MWKVQVrrUxcRI2cE9G0qCLm3Mmn20W37hIGjwUiaj22kbynJe/tnlcru
	ms1jHlL1dYDG+6b2iIwONgwf0+mG0q70WsCsOshhLjGeeMJ7nz7Q3bAcKobo/QsmN4WWc1
	em6XIjaA3LGaR1SxPG5Rgo1I7fju1cmxaChmKwXV6fJpO98nXZTZ0oYma1oV/w==
Date: Mon, 23 Jun 2025 13:10:57 +0200
From: Pavel Machek <pavel@denx.de>
To: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: Re: [PATCH 6.12.y-cip 0/7] Add support for RZ/G3E WDT
Message-ID: <aFk2QQJUVBuWYKiS@duo.ucw.cz>
References: <20250623102857.1493371-1-tommaso.merciai.xr@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="dmrJZtgYk1+rc5ld"
Content-Disposition: inline
In-Reply-To: <20250623102857.1493371-1-tommaso.merciai.xr@bp.renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 23 Jun 2025 11:11:09 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19182


--dmrJZtgYk1+rc5ld
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This patch series aims to add Watchdog Timer (WDT) support for the
> Renesas RZ/G3E SoCs.
>=20
> The RZ/G3E WDT IP is similar to RZ/V2H WDT. WDT0 can be used for CM33 cold
> reset, system reset and asserting WDTUDFCM pin where as WDT1 can be used
> for CA55 cold reset, system reset and asserting WDTUDFCA pin. Other 2
> watchdogs can be used for system reset. So define WDT{1..3} in SoC
> dtsi.

Looks good to me. I can	apply it if it passes testing and there	are no
other comments.

Reviewed-by: Pavel Machek <pavel@denx.de>

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--dmrJZtgYk1+rc5ld
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaFk2QQAKCRAw5/Bqldv6
8vw3AJ0aZE4LFdkrElrI9OWLBEySdrmT6ACeMfw5F0khKl4POUKz6bTcpgKr7o0=
=uQRl
-----END PGP SIGNATURE-----

--dmrJZtgYk1+rc5ld--

