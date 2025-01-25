Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1D8DC0218C
	for <webhook@archiver.kernel.org>; Sat, 25 Jan 2025 20:14:08 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.web11.17352.1737836046245495579
 for <cip-dev@lists.cip-project.org>;
 Sat, 25 Jan 2025 12:14:06 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=VeLCgOJm;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 0CD8C104811D5;
	Sat, 25 Jan 2025 21:14:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1737836044;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cRd/4mWPhI9NoudmJRWEX5w/FHfJgabKaZctNkmsYCA=;
	b=VeLCgOJmSKUybZEqfCvyI3BxtINx2Z8M6RpFNJrWYjC0m2G7hBUpls2lrPkDk+QKXVehy2
	3qhxQ7UDMSuhdM8Z5h5YugAZETe9Q4goWASj3JH5xJ7cV23nNKgDMhg5EFciyDHbuJF/+Q
	J5/MyFbFTUlPczj3jFpFxSI1BAcfNk21B98v54ntH5915jNiPsm1cKV5Hp/u0Ed+g28l76
	72el7HD8gd6YS0H9FJFsbqKXDQGHe5bY9WiNxikDH05pBjlnPBOT+FUMZyIUABQgoCpLY4
	lk2dxe6yyfR9XIuyr3AkE0ZsmPjIW7hPThkeh3FgzIF5kl5iTZPDG+P9n4m0Lw==
Date: Sat, 25 Jan 2025 21:14:00 +0100
From: Pavel Machek <pavel@denx.de>
To: Claudiu <claudiu.beznea@tuxon.dev>
Cc: nobuhiro1.iwamatsu@toshiba.co.jp, pavel@denx.de,
	cip-dev@lists.cip-project.org
Subject: Re: [PATCH v6.1.y-cip v2 00/14] renesas: rzg3s: backport the RTC
 support
Message-ID: <Z5VGCAsMbTyyDmmK@duo.ucw.cz>
References: <20250124090008.1401077-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qSGveCeqpPgltwIA"
Content-Disposition: inline
In-Reply-To: <20250124090008.1401077-1-claudiu.beznea.uj@bp.renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 25 Jan 2025 20:14:08 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17665


--qSGveCeqpPgltwIA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Series backports the RTC support for the Renesas RZ/G3S SoC.
> Along with a clock driver for the clock provided the VBATTB
> is included as this is critical for the RTC to work, as it feeds
> the RTC counter.
>=20
> For the VBATTB clock driver the following patches were also
> backported:
> - clk: gate: Add devm_clk_hw_register_gate()
> - clk: mux: Introduce devm_clk_hw_register_mux_parent_hws()
> - clk: fixed-factor: add fwname-based constructor functions
>=20
> and adjusted accordingly, if needed.
>=20
> For the same VBATTB clock driver the
> devm_clk_hw_register_gate_parent_data() was backported from the upstream
> commit d54c1fd4a51e ("Add clock driver for Sunplus SP7021 SoC") in
> the patch "clk: Add devm_clk_hw_register_gate_parent_data()".

Similar to 5.10 situation: I gave my comments for 8/ in 5.10
discussion, but those should not block merge.

Series looks good to me, I can apply it if it passes testing and if
there are no other comments.

Best regards,
                                                                Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--qSGveCeqpPgltwIA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZ5VGCAAKCRAw5/Bqldv6
8mxIAJ9JrJ4F1pmYveEpO59sUION0yTiWQCfZXciJW7fd5mv/6dE4rUfe0fgLpQ=
=UBFd
-----END PGP SIGNATURE-----

--qSGveCeqpPgltwIA--

