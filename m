Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A75BD0E6D1
	for <webhook@archiver.kernel.org>; Tue, 25 Nov 2025 12:40:49 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.16149.1764074446162369089
 for <cip-dev@lists.cip-project.org>;
 Tue, 25 Nov 2025 04:40:46 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=OnhMJbjb;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 4958B101E0E5C;
	Tue, 25 Nov 2025 13:40:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1764074443; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=SDfMR1vyRLsiFuADu1DOGfioUIEUaO+0qAMcAoXT168=;
	b=OnhMJbjbJuDx6HDDoCHovX74K8MO7jF9f9KRZCknKl0JGC+pcxsEGwC4JD/IBVgk+Rv4QO
	H4avLwdan1vGVkTeS4GEluYNdgItO+R7FdTYLjBcEUKcL741wE7MrS6PJ7LsG9KqhkC34d
	XraAc0xMfEgJ//XRq1JpXTaLIrhp+iGPBKYtKwEIBG6HXb0lXtJTn8Jsz05Fke9m2XZ0hz
	JrZQpTMKgB4Iu1JU8SWzlrOZI6y14RUAOToQelc1cCQhWR/cR5z/TGSSqvh+/EDi3nFhVR
	8vEQo8x/coWwgkQWSxuInbXxnh4Dc/Mi11PmitBEQ8TlbeMHwCub13mSCO0ZhQ==
Date: Tue, 25 Nov 2025 13:40:39 +0100
From: Pavel Machek <pavel@denx.de>
To: Claudiu <claudiu.beznea@tuxon.dev>
Cc: nobuhiro1.iwamatsu@toshiba.co.jp, cip-dev@lists.cip-project.org
Subject: Re: [PATCH 6.1.y-cip 0/2] ASoC: Renesas: Backport audio fixes
Message-ID: <aSWjxzkhMUOCr/Ek@duo.ucw.cz>
References: <20251122105127.2783085-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="CFnJGKDiM1Uv38Cu"
Content-Disposition: inline
In-Reply-To: <20251122105127.2783085-1-claudiu.beznea.uj@bp.renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 25 Nov 2025 12:40:49 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20727


--CFnJGKDiM1Uv38Cu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Series backports audio fixes necessary for the Renesas RZ/G3S SoC
> and the Renesas RZ SMARC Carrier-II board.

Thank you, applied and pushed out.

Best regards,
								Pavel
--=20
In cooperation with DENX Software Engineering GmbH, HRB 165235 Munich,
Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--CFnJGKDiM1Uv38Cu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaSWjxwAKCRAw5/Bqldv6
8ngcAJ497XNTN/cQnc8nHTX4uI1fgVwJRgCgnKr1M/yTwxdw+zUzwxMmkD4vX84=
=30a8
-----END PGP SIGNATURE-----

--CFnJGKDiM1Uv38Cu--

