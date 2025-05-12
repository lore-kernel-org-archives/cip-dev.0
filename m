Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC0DDC3ABCD
	for <webhook@archiver.kernel.org>; Mon, 12 May 2025 11:45:04 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.web11.48354.1747050301236306161
 for <cip-dev@lists.cip-project.org>;
 Mon, 12 May 2025 04:45:01 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=K+LVu5o7;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 4E1B5101EC1F3;
	Mon, 12 May 2025 13:44:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1747050299; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=r43J8EPCqBjyla53TepPevNMKTqXJtqfWU+O3zJ67gA=;
	b=K+LVu5o7jg3gBcyvjg+Zwej7+QBXnr5eg2xzjKoxKHAYjBVh3wvNfetabPB/TKnS8VvDb0
	eOTYXuLj05U/eJ4tGbP+0xulEukfY8Apse6Mlqp0RvGO9siK1GT92CSJdCQrxbCk4mJkrF
	78bj+Yvl1s01QQWaMpp7PtB3SjPAOgz+EUL922axfmZaOg9ZM3hJxIpYHARFxgZ7M6MRe1
	cL9oHAFpR4WE+/YkZc2eUyoMMOmuQIG/+rwQo0Rlyehn61n6XrHIXx/slePg/11A11SxZ1
	yDjWILKiCxLBEzOZGAQCi6DawsEpREGRxZkhuey5OUoSLm+m7xoaNUant3056Q==
Date: Mon, 12 May 2025 13:44:53 +0200
From: Pavel Machek <pavel@denx.de>
To: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Cc: nobuhiro1.iwamatsu@toshiba.co.jp, cip-dev@lists.cip-project.org
Subject: Re: [PATCH 5.10.y-cip 03/37] ASoC: da7213: Add new kcontrol for
 tonegen
Message-ID: <aCHfNffAfYMPSkaP@duo.ucw.cz>
References: <20250509093442.4015145-1-claudiu.beznea.uj@bp.renesas.com>
 <20250509093442.4015145-4-claudiu.beznea.uj@bp.renesas.com>
 <aCGq0e9FcQ1ShAAq@duo.ucw.cz>
 <3b2097ac-20e1-4e5d-a9d6-2b2bfbf0cc1b@tuxon.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="NRmppKVkJ4NfD4Oo"
Content-Disposition: inline
In-Reply-To: <3b2097ac-20e1-4e5d-a9d6-2b2bfbf0cc1b@tuxon.dev>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 12 May 2025 11:45:04 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18897


--NRmppKVkJ4NfD4Oo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> >> From: David Rau <David.Rau.opensource@dm.renesas.com>
> >>
> >> commit 64c3259b5f86963c5214e63cfadedaa2278ba0ed upstream.
> >>
> >> Add new kcontrol for tone generator
> >=20
> > DTMF in hardware? What are you using DTMF for these days? And is it
> > really useful to have special silicon and special code in driver to
> > accelerate it?
>=20
> We are currently don't use this with the RZ/G3S SoC. I've backported this
> patch as it was needed to have the DA7213_TONE_GEN_OFF_PER macro used in
> patch 05/37 "ASoC: da7213: Populate max_register to regmap_config".
>=20
> Would you like me to try another approach 05/37? E.g. Use directly the
> latest available offset for v5.10?

No, its okay as it is. I was just wondering how people uses DTMF in
2025.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--NRmppKVkJ4NfD4Oo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaCHfNQAKCRAw5/Bqldv6
8gIUAJ9Wzk8h/19v/bhkwaOTxtbNzuCNIACeM+OjoiIN2y80fM+l+rrSnfkiNNU=
=8WBP
-----END PGP SIGNATURE-----

--NRmppKVkJ4NfD4Oo--

