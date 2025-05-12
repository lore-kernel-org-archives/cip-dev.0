Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42F1BC3ABCB
	for <webhook@archiver.kernel.org>; Mon, 12 May 2025 16:07:56 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.web10.54161.1747066071131494510
 for <cip-dev@lists.cip-project.org>;
 Mon, 12 May 2025 09:07:51 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=AaFv8xqx;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 190CB101EC1F1;
	Mon, 12 May 2025 18:07:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1747066069; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=HV9VEYHc4UBOJzLjHriDiQHPhyZEyPPWimOjqovsEyQ=;
	b=AaFv8xqxRPqEahXkCEhJUdCYwtsX3Vl3m6EoYgRHgw4eDN6eZrNbqAu/lNmTAleevesgw6
	D9xwD3+A19JDV3ev/rw1WMR4CSjdiCAKkX29HQgKi0i4TC+CeJMHrNzFcIEdQVIeY2/dLj
	c11ZYkFEPXUxwN2BkjO0uCpBp2JCiCfNzDfb0vtGOUeoxBWo7As8Ge3FOSCRO/cp/fvZpp
	RAWVKakdXgO/qOGxGCF2oBWNJnYyduZ1f/f2nCrYX1/SaR0haHulZBAqzA941/WYsGvZ31
	1FaW6nqNAB9IvzxQThlE8FpiiiJ30nq9dwXwcf5TXcJJ7ixjPn9cqvuWRLHS/A==
Date: Mon, 12 May 2025 18:07:45 +0200
From: Pavel Machek <pavel@denx.de>
To: Claudiu <claudiu.beznea@tuxon.dev>
Cc: nobuhiro1.iwamatsu@toshiba.co.jp, cip-dev@lists.cip-project.org
Subject: Re: [PATCH 6.1.y-cip 00/34] RZ/G3S: Backport audio support
Message-ID: <aCIc0bh5tfFJP1f1@duo.ucw.cz>
References: <20250509093318.4014916-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3LTC+xyLpSMRmIrR"
Content-Disposition: inline
In-Reply-To: <20250509093318.4014916-1-claudiu.beznea.uj@bp.renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 12 May 2025 16:07:56 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18899


--3LTC+xyLpSMRmIrR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Series backports the Renesas RZ/G3S audio support to v6.1.y CIP.

Thank you, applied.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--3LTC+xyLpSMRmIrR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaCIc0QAKCRAw5/Bqldv6
8kLGAKCfnMrD9HSSCunUyZTQifTPQEvdIwCfZxJulL9f/k7KiIB+FZTP6ZaCFDo=
=n03J
-----END PGP SIGNATURE-----

--3LTC+xyLpSMRmIrR--

