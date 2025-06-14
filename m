Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C71BC71135
	for <webhook@archiver.kernel.org>; Sat, 14 Jun 2025 19:31:29 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.web11.15766.1749929484802311363
 for <cip-dev@lists.cip-project.org>;
 Sat, 14 Jun 2025 12:31:25 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=fOeGdP2q;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 5BD1810271B02;
	Sat, 14 Jun 2025 21:31:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1749929483; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=bNYPmDllQWZRt4d91RxY5ZkBaeq3ae301VuDVk7xUVA=;
	b=fOeGdP2qt+oAOzIM7bdXpxBkZZXGbuNkANbOIDOCO/c+3X5pSvfHwzb1qQGcCaSIu7IVPg
	+B+5b+9fr7xI0tkEH8C67NoYINORpddkAkDuE2yMZjiLdDXNVlcvFUDJ+8cH48g85p1KoN
	i+aGkYdUj3AuJ+HxAYIcEtVRNGZZt9m0gWA4HUlfYkb7V14f+NR+kpEOwm6zMCG5UOXQPC
	X+jy/5kJjwrMSxunzCK6uwE/qfsvMRflFuW9qGkO+edqX28XnVsaaVcIUxNB5SwmFZEo7k
	jLsHPsnXi1mCjQ4s3HSJczl2f9VFYis038obKUB6jCxCznFfC5V0E/9BVc1IoA==
Date: Sat, 14 Jun 2025 21:31:19 +0200
From: Pavel Machek <pavel@denx.de>
To: Claudiu <claudiu.beznea@tuxon.dev>
Cc: nobuhiro1.iwamatsu@toshiba.co.jp, cip-dev@lists.cip-project.org
Subject: Re: [PATCH 6.12.y-cip 00/14] RZ/G3S: Backport ADC support
Message-ID: <aE3OB5ICKIY+77EP@duo.ucw.cz>
References: <20250613101613.296649-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="SAd1n9Rf5mLthKda"
Content-Disposition: inline
In-Reply-To: <20250613101613.296649-1-claudiu.beznea.uj@bp.renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 14 Jun 2025 19:31:29 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19089


--SAd1n9Rf5mLthKda
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Series backports the Renesas RZ/G3S ADC support to v6.12.y CIP.

This looks okay to me. I can apply it if it passes testing and there
are no other comments.

Best regards,
                                                                Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--SAd1n9Rf5mLthKda
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaE3OBwAKCRAw5/Bqldv6
8hOBAJ91xEVBh7+vy6wla7K5KERdF9LAjACfbcX+xug6WWIcK6rIhrgzXV+SiCI=
=EVWV
-----END PGP SIGNATURE-----

--SAd1n9Rf5mLthKda--

