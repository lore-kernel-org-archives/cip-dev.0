Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38F55C71135
	for <webhook@archiver.kernel.org>; Sat, 14 Jun 2025 19:26:09 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.web11.15696.1749929165765409218
 for <cip-dev@lists.cip-project.org>;
 Sat, 14 Jun 2025 12:26:06 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=UCxFgq2u;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 0EA7910271B06;
	Sat, 14 Jun 2025 21:26:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1749929163; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=w/Hr74BVvxlMc7g17GLpKgI0/0RYfLWeyex5TFhql4Q=;
	b=UCxFgq2u7+l787PZvQA32M0OKYO7nSqHoCuJpoFKy4u7wHaFBQ/XxKS2W3Rgz7TNDHoq7S
	XjlvA1qg4/yw2ZMGbuQmyV+SphD7amwZanNVtHx62jsy2Sat0/MfukB5V67EibVOD6eApB
	lMDcW8hNdCERuRnmh2ocHYqNXF8sL1ycPaB8M/tJ+RYcIaUWWv0+ToKzRX++rOtL2+fFu9
	im06JPxKALLXK6QSfIQOThgfoxmut9M/xmgvy/8OOPoFffMvWb4mNW5WefB9JCo+wAEO8v
	rj/ega3MoQmkQjVWtwC1psmULenM7fBcrqdERStqmxkuiXwhjErswiBWkEjg5Q==
Date: Sat, 14 Jun 2025 21:25:58 +0200
From: Pavel Machek <pavel@denx.de>
To: Claudiu <claudiu.beznea@tuxon.dev>
Cc: nobuhiro1.iwamatsu@toshiba.co.jp, cip-dev@lists.cip-project.org
Subject: Re: [PATCH 5.10.y-cip 00/12] RZ/G3S: Backport ADC support
Message-ID: <aE3MxuPYJ65a5r3u@duo.ucw.cz>
References: <20250613101501.262091-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Gf6Y7q9hcZuhPg4Y"
Content-Disposition: inline
In-Reply-To: <20250613101501.262091-1-claudiu.beznea.uj@bp.renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 14 Jun 2025 19:26:09 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19087


--Gf6Y7q9hcZuhPg4Y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>=20
> Series backports the Renesas RZ/G3S ADC support to v5.10.y CIP.

This looks okay to me. I can apply it if it passes testing and there
are no other comments.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--Gf6Y7q9hcZuhPg4Y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaE3MxgAKCRAw5/Bqldv6
8gFcAKCjpYim4fwdxs4iU2F2MDnNDc6jwwCgl7MNzrHF2CiKNCBINxg2YrSCej0=
=XrPV
-----END PGP SIGNATURE-----

--Gf6Y7q9hcZuhPg4Y--

