Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AE5FC83F1A
	for <webhook@archiver.kernel.org>; Mon, 14 Jul 2025 10:25:31 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.web10.75116.1752488726660569327
 for <cip-dev@lists.cip-project.org>;
 Mon, 14 Jul 2025 03:25:27 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=PhwUvjwL;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E531A10397286;
	Mon, 14 Jul 2025 12:25:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1752488724; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=QNSbGi70ZBzwAZSAZWB/iSc96mXtHULQG6tIZn/uvuE=;
	b=PhwUvjwLBUAuuV+0Vvx270rhS76Mnc5ss+RcdkcdWTDe6JHNJw18MrzxbjQ6G4jjeSfDWi
	8sR1IYCUSoMeLAreyn351BTCCrqYIwYqnd95ze2fkRLq/+eIuPn42WSMA3+VoG84QTwS0n
	IAqmfEjPDFgEtX79Y/speRj/S+Fs9YZSA69jeD0uQLYYbJVA4oMpxQPWLOsgBeI1aF2Hrf
	Wz4HRKhE/ckDjKswoNu/HtTqrsO2N5tIhvcoBH8V65BB/0Tjx9dIZ7mXfR/rpR4UVW/p1y
	iYW09RVHIDAmI1MO5wBdLKnSpkcrLR026PjH6mc9u/AuujK/zCHV/9EbSKxgkQ==
Date: Mon, 14 Jul 2025 12:25:18 +0200
From: Pavel Machek <pavel@denx.de>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: nobuhiro1.iwamatsu@toshiba.co.jp,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	cip-dev@lists.cip-project.org
Subject: Re: [PATCH 6.1.y-cip 0/8] RZ/G2L DU enhancements
Message-ID: <aHTbDixfES4EK1it@duo.ucw.cz>
References: <20250711163222.191633-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Sk6v0Kpqal6N3ig7"
Content-Disposition: inline
In-Reply-To: <20250711163222.191633-1-biju.das.jz@bp.renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 14 Jul 2025 10:25:31 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19523


--Sk6v0Kpqal6N3ig7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This patch series for enhancing RZ/G2L DU driver.
> All the patches are cherry-picked from mainline.

Thank you, applied.

Best regards,
								Pavel
--=20
In cooperation with DENX Software Engineering GmbH, HRB 165235 Munich,
Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--Sk6v0Kpqal6N3ig7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaHTbDgAKCRAw5/Bqldv6
8sE1AKCxQyTTcfXTeH4AXbF+2f25Vc5neACgnmsAJRL/PzGec1EZShpVx69TNsk=
=HG8b
-----END PGP SIGNATURE-----

--Sk6v0Kpqal6N3ig7--

