Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC076C5AE59
	for <webhook@archiver.kernel.org>; Tue,  3 Jun 2025 09:39:27 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.web11.7341.1748943562092409381
 for <cip-dev@lists.cip-project.org>;
 Tue, 03 Jun 2025 02:39:22 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=fEupeWVP;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 26AED10397298;
	Tue,  3 Jun 2025 11:39:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1748943560; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=wAWN8LbttLZrE6rqpW4NOv/Gfl0/2Iw6Jmt4uECyOmk=;
	b=fEupeWVPmkFZAwdw2HF719xI6uaLuQJFr73Uz7eZjkcbe5TE7HNezbcIhzOhjCW6ijPPRH
	41HpOzzOqZhjj2klbE5QSUEY8zn91cz1lhzYazYe+dyLuWjdDa9IiAD8EDHzE2clEqUGQk
	z0nECHrCvUhe/nsJ7He77btI6tMdI6BW5B3qFRCB4s0KTe08WqtVcvEAy8mQxlt4FhqEMD
	dym6Jz3SnzhuBUTJ9jpjIOKLbnrOPuQYBtmbwH842ZV7KzznUtOj2Vx0xG0rWiItvF4I6t
	FI0rs8+E8tnBYS1YhQAnozsxY8nHS/qziBn9c3nb5LQwacE1uLYk4NgVTPUB6A==
Date: Tue, 3 Jun 2025 11:39:16 +0200
From: Pavel Machek <pavel@denx.de>
To: Claudiu <claudiu.beznea@tuxon.dev>
Cc: nobuhiro1.iwamatsu@toshiba.co.jp, cip-dev@lists.cip-project.org
Subject: Re: [PATCH 6.1.y-cip 0/8] RZ/G3S: Backport SCIF support
Message-ID: <aD7CxMwe7o266v8D@duo.ucw.cz>
References: <20250603091940.3917581-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PYb5BJKa2YN03M17"
Content-Disposition: inline
In-Reply-To: <20250603091940.3917581-1-claudiu.beznea.uj@bp.renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 03 Jun 2025 09:39:27 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18992


--PYb5BJKa2YN03M17
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Series backports the Renesas RZ/G3S SCIF support to v6.1.y CIP.

Looks good to me. I can apply it provided it passes testing and there
are no other comments.

Best regards,
                                                                Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--PYb5BJKa2YN03M17
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaD7CxAAKCRAw5/Bqldv6
8kCMAKCERBq8sDyxP0W928tN4owRHgk9IgCgmXJ7uF4nSySTC/XamNM+BL6JTVo=
=UrOS
-----END PGP SIGNATURE-----

--PYb5BJKa2YN03M17--

