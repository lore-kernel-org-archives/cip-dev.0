Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EA10E77187
	for <webhook@archiver.kernel.org>; Wed, 18 Dec 2024 19:58:57 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.web10.114270.1734551935503899647
 for <cip-dev@lists.cip-project.org>;
 Wed, 18 Dec 2024 11:58:55 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=dWHv2Afd;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 020C51048559C;
	Wed, 18 Dec 2024 20:58:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1734551933;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zsEads+Fg2jQKI6wrcEGYEo+n4lxs8h85ILeK3aFcfI=;
	b=dWHv2AfdwRXdk8JI9ugV5rUXqZzvSuc8lZoT4erYcCDfOilTfkAbRACnihpq7EQlAKgNdk
	kJ+1DIMjbS+tIemkgzOcKRZXW6ufdmG8RfdUhP6r8lLiSWvSUtkIqEActzbKle3qmT2bMo
	XGSYn27p+fkCqfZl0ObwUolceiUCWf/9TW+XGhEHEnFEwixQwQwQ+3xwZ3m1zucJZfj1ry
	c9JuPVVDG/X8EAYcaHBIzPBQzmkLwwGdP3kEvMicwUW3veOH8J10ENqlapwVwcZ8lCTYX5
	BtwNW2VPWa7tdaVX7zjJj1CIjX+VAF7/cut33ohGT3TtJGL1npKx2pgu07XvmQ==
Date: Wed, 18 Dec 2024 20:58:47 +0100
From: Pavel Machek <pavel@denx.de>
To: Claudiu <claudiu.beznea@tuxon.dev>
Cc: nobuhiro1.iwamatsu@toshiba.co.jp, pavel@denx.de,
	cip-dev@lists.cip-project.org, biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com
Subject: Re: [cip dev][PATCH 5.10.y-cip 00/10] watchdog: rzg2l_wdt: Backport
 RZ/G3S support
Message-ID: <Z2Mpdy+fmmzZejIp@duo.ucw.cz>
References: <20241218122317.2365272-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="pi9241judzDrQbeV"
Content-Disposition: inline
In-Reply-To: <20241218122317.2365272-1-claudiu.beznea.uj@bp.renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 18 Dec 2024 19:58:57 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17468


--pi9241judzDrQbeV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>=20
> Series backports the watchdog support for the Renesas RZ/G3S SoC.

I still don't believe you got error handling right, but I guess we can
apply this (and 6.1 version) if it passes testing and there are no
other comments.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--pi9241judzDrQbeV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZ2MpdwAKCRAw5/Bqldv6
8rQCAJ9K0UTziEAVitU7nZdSE3xETQ3aMgCffBWVNRFo/catopXp+A+TlzHkj+s=
=cVYP
-----END PGP SIGNATURE-----

--pi9241judzDrQbeV--

