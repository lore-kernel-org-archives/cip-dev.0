Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99801C5B543
	for <webhook@archiver.kernel.org>; Wed,  4 Jun 2025 17:03:54 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.web10.22140.1749056629049447338
 for <cip-dev@lists.cip-project.org>;
 Wed, 04 Jun 2025 10:03:49 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=Ih3OfUzV;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B91E210397298;
	Wed,  4 Jun 2025 19:03:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1749056627; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=+QqHJoOAdZyqRviUeaawwESK451cm4Nz5TjeU0HIN1Y=;
	b=Ih3OfUzVuKxAxDeJ1FA6HAC3rKSRGPnuF4OVSL2PPsMG0qusQnpoNg2DGxl4XbFZ/FUCGr
	UNYanofAm3QNmt6/IiFmKZJHBfBc+zmcV2hqaMtejraCzXtOe8JamYpx9WpCQQiQyL2rtp
	R1Vt6hW6g6AVOWRxXXF14LS03JGb+rzqBJBHINE0kLyda/madoo8ySr3cFWSEyhBt6iqMA
	wb/UeIik0hLkj4zo08lfoBeUD4ffYveVfhZFCOiDTo8cmPf1/wFbigsBk4bI0PeUP3v/3k
	a7tM05v7uSvCVlyejb0WS8LzL+fG08XmmCobZz4QKHIGAl9IZjZebQ8lviHz9g==
Date: Wed, 4 Jun 2025 19:03:41 +0200
From: Pavel Machek <pavel@denx.de>
To: Claudiu <claudiu.beznea@tuxon.dev>
Cc: nobuhiro1.iwamatsu@toshiba.co.jp, cip-dev@lists.cip-project.org
Subject: Re: [PATCH 6.1.y-cip v2 0/8] RZ/G3S: Backport SCIF support
Message-ID: <aEB8bXYCD8vtU2u1@duo.ucw.cz>
References: <20250604102341.2524186-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/6Sp68sJ/CkPfjrb"
Content-Disposition: inline
In-Reply-To: <20250604102341.2524186-1-claudiu.beznea.uj@bp.renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 04 Jun 2025 17:03:54 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19012


--/6Sp68sJ/CkPfjrb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Changes in v2:
> - fixed build error by dropping overlay in patch 8/8
>

Looks good to me. Both me and Iwamatsu-san already reviewed this, so I
guess I'll just apply this with his reviewed-by if it passses testing.

Best regards,
                                                                Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--/6Sp68sJ/CkPfjrb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaEB8bQAKCRAw5/Bqldv6
8o2gAJ9V96+5pp9Dr7wB+04IfgMz2ka/WgCeKsYKY9x7HJqqoUUMAoSbvuFjkbk=
=41xP
-----END PGP SIGNATURE-----

--/6Sp68sJ/CkPfjrb--

