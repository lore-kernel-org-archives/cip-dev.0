Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B23BC0218C
	for <webhook@archiver.kernel.org>; Sat, 25 Jan 2025 20:08:28 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.web10.17457.1737835704986071857
 for <cip-dev@lists.cip-project.org>;
 Sat, 25 Jan 2025 12:08:25 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=cp+WPJnA;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B6FDA101ECB20;
	Sat, 25 Jan 2025 21:08:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1737835703;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=izsgQb67Iqj9TRLWf2JkpG0N5Pvr+Vf580izkJoTpLw=;
	b=cp+WPJnATwvPkdWjG7moBKFWRqvMuNquGemuXFFE5iMyMjBHr6VADKfhKRrIjq0W51vyuD
	lGlFMjK7oZ6zPM4EqyKOeUVc/P/ERmbazrDDb7VK9utXnUGeQDSZ8ORiOAf1D+gmmSR7J1
	ZG+ueTdmU/H47WR3sWjZ/JR4DB9vv6iddQn7xMdkmmgEgfBmBpqOdV9n7bIFBPlxf6n650
	ZRU79k27+/jrdHRXfC/bnY+DrDcQvZCdxq9o3qoTKtneVtwIwFsPMMofJJnE0vq1vP4Puy
	1TM5bGUdwCgZQRqnAZfI8LzjGmTpZh6Lurlb6OCGvPqfx6OX97czaaOb306LKA==
Date: Sat, 25 Jan 2025 21:08:19 +0100
From: Pavel Machek <pavel@denx.de>
To: Claudiu <claudiu.beznea@tuxon.dev>
Cc: nobuhiro1.iwamatsu@toshiba.co.jp, pavel@denx.de,
	cip-dev@lists.cip-project.org
Subject: Re: [PATCH v5.10.y-cip v2 00/16] renesas: rzg3s: backport the RTC
 support
Message-ID: <Z5VEs7I3qRtgeNOk@duo.ucw.cz>
References: <20250124090041.1401132-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Lga/3utvtx1uz9mk"
Content-Disposition: inline
In-Reply-To: <20250124090041.1401132-1-claudiu.beznea.uj@bp.renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 25 Jan 2025 20:08:28 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17664


--Lga/3utvtx1uz9mk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>=20
> Hi,
>=20
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

I have some comments for 10/ , but those should not block merge.

Series looks good to me, I can apply it if it passes testing and if
there are no other comments.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--Lga/3utvtx1uz9mk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZ5VEswAKCRAw5/Bqldv6
8tqbAJwKcxjzDuAo3G6Oj4g32TbzXNsfLwCdGxEdwfF7nYT3WoSQd5CYLprzcjg=
=3EvG
-----END PGP SIGNATURE-----

--Lga/3utvtx1uz9mk--

