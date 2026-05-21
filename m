Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2194CD5BA4
	for <webhook@archiver.kernel.org>; Thu, 21 May 2026 10:41:08 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.33475.1779360065943793869
 for <cip-dev@lists.cip-project.org>;
 Thu, 21 May 2026 03:41:06 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=gI+J6u+i;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 4285010CD55;
	Thu, 21 May 2026 12:41:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1779360063;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=F0zZuv/JECZZT6GgHMvnhQbNeSWgvaRhjo/4Qj8r9EA=;
	b=gI+J6u+idANqXKe5VvWuT7zaPo9C18/U024UnOevdlZ8aXz6VLGFEUvxwko97Bh2i0k6Qk
	eceEJMx++6ZwzDOPi0B7mIEfuZVQHY57Mh1AyMxtnEBaYMNf4JzThpzjEBW0QSDNI3ankM
	xEYii9TOSdu7l4j3YihTrsKHU0VnnjMDz/vLZoTnsFORCLj7HiZBpviggJ8oyqhQH4YZbN
	EcMjWE6zh/wIugeDAUVk7nR7rYiT/5G0/GqWNBBdmoQRmUMVx4o/Kas5q2MU5LK55n8ESd
	ufTEFHGqMdTuXvs/e88uAMfqTfDZJPMb5K3aCj5DzvTIIEtmoC5MmPaG+QSQjA==
Date: Thu, 21 May 2026 12:40:59 +0200
From: Pavel Machek <pavel@nabladev.com>
To: John Madieu <john.madieu.xa@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@nabladev.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>, john.madieu@gmail.com
Subject: Re: [PATCH 6.12.y-cip 00/17] PCI: renesas: Add RZ/G3E PCIe
 controller support
Message-ID: <ag7hO3Li6M_jYCjK@duo.ucw.cz>
References: <20260514093935.2212718-1-john.madieu.xa@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bGCqJnjt5zUj6nW8"
Content-Disposition: inline
In-Reply-To: <20260514093935.2212718-1-john.madieu.xa@bp.renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 21 May 2026 10:41:08 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22992


--bGCqJnjt5zUj6nW8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

> The Renesas RZ/G3E SoC features a PCIe controller that shares
> similarities with the existing RZ/G3S PCIe controller, but with several
> key differences. This series adds support for the RZ/G3E PCIe controller
> by extending the existing RZ/G3S driver and device tree bindings.

Despite minor comments, this looks okay to me.

Reviewed-by: Pavel Machek <pavel@nabladev.com>

Best regards,
                                                                Pavel

--bGCqJnjt5zUj6nW8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCag7hOwAKCRAw5/Bqldv6
8sg4AJ98CSJbkUAxSpHebJBPPSiSnXFx8wCfaJ9CY7kkY4efjFXqpav3ZS3PmYI=
=Z3Dj
-----END PGP SIGNATURE-----

--bGCqJnjt5zUj6nW8--

