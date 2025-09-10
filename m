Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B449CA0FED
	for <webhook@archiver.kernel.org>; Wed, 10 Sep 2025 15:33:12 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.web11.21807.1757518384460679736
 for <cip-dev@lists.cip-project.org>;
 Wed, 10 Sep 2025 08:33:04 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=fpBwGoUX;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id F0E501038C108;
	Wed, 10 Sep 2025 17:33:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1757518382; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=n3kAyizqqofcn08YIyja33gzZEcjB6oB2bRJlqU7+eM=;
	b=fpBwGoUXQXOr6bKE6m57xZDTPmtIUgj+RYxSreBdGmf5a/tExbuThvL4dCxHKuy67X1eek
	Oar7EVNJpXVODLMo70vYJxJlJnPg2fNBmuVCops1hZYI2AaOyzbZeJ+SOC0IonGlNYSeVk
	VaRm7P5dwoYhJL2fAgraF/na2Zpca00QRA5sIjS201sHI7Tll8Kj3Y3GCqCDBT3CZvVENs
	lYOPqTaCrPRNtX+mSfbEo92oPnPpiTbHHsMHkpu+rSDcBkH9aOyiYM0Tz2EC3Hk2a8Z/rO
	gLl+EYvRWPAoEF8tl7FZJwMlx4gYsqPltWTed8Ck7uSye0fUKK4vsmOS/3pvLw==
Date: Wed, 10 Sep 2025 17:32:59 +0200
From: Pavel Machek <pavel@denx.de>
To: Claudiu <claudiu.beznea@tuxon.dev>
Cc: nobuhiro1.iwamatsu@toshiba.co.jp, cip-dev@lists.cip-project.org
Subject: Re: [PATCH 5.10.y-cip] arm64: dts: renesas: rzg3s-smarc-som: Fix
 Ethernet aliases
Message-ID: <aMGaKyn6cs39roFh@duo.ucw.cz>
References: <20250827035801.568246-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6RNjSxW57TcdNshP"
Content-Disposition: inline
In-Reply-To: <20250827035801.568246-1-claudiu.beznea.uj@bp.renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 10 Sep 2025 15:33:12 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20035


--6RNjSxW57TcdNshP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi1

> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>=20
> commit be4e4dd8a1994e5730dfdb8dfaf1f2418f8a199d upstream.
>=20
> Fix typos in the Ethernet aliases.  U-Boot uses the ethernetX (X=3D{0, 1,
> ..., N}) aliases to update the DTB with the MAC addresses.  The
> ethernetX or ethX aliases are not used by the Linux RAVB driver.

Thank you, applied.

Best regards,
								Pavel
--=20
In cooperation with DENX Software Engineering GmbH, HRB 165235 Munich,
Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--6RNjSxW57TcdNshP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaMGaKwAKCRAw5/Bqldv6
8kn9AJ9+hYMgnGh8E51PG1+pGRG+8FqMjwCffnxIVPA4LPITFCNEcu6PxfRjuEw=
=f/WW
-----END PGP SIGNATURE-----

--6RNjSxW57TcdNshP--

