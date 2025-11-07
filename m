Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04542CCF9F8
	for <webhook@archiver.kernel.org>; Fri,  7 Nov 2025 09:13:59 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.7491.1762506830908361136
 for <cip-dev@lists.cip-project.org>;
 Fri, 07 Nov 2025 01:13:51 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=RhPq2hX1;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 6325D103D145E;
	Fri,  7 Nov 2025 10:13:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1762506829; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=gzUV30RUw7xMMipWCNpcMauaAZA8o4GC3Xvt1RGrE1o=;
	b=RhPq2hX1kU+1b9KiUGm77JUlWnmE6WmtqNECUj+xmNR5pHbXdyNev1jgRjAxfPKQ4cCWIn
	O0V9J2m7hfIJINGWKZurF1o7n+2ApjEyaPAb+Jieqh0ki1KGjHD+uiBfudJ90s7guC7edu
	g+/wdRKgGh6lBhrWUEsUpfOHBJCuwx4BikEwS7hXOXMwn2xky6iYMKjwzqupoDb9yuqSGa
	NRmOWFPDTTdZaTSDciMn/gFsfAqfqZ31OO1c7yjOuM7hWiwhk0+bEFVyCsDtpNGj0y6YmT
	CSLcVbvkAUHDD9zLdX9+NGbxsCr5lzdcGH8/PXTxPgK2fhsF7LT9wyhylLv3GA==
Date: Fri, 7 Nov 2025 10:13:44 +0100
From: Pavel Machek <pavel@denx.de>
To: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
Cc: cip-dev@lists.cip-project.org, nobuhiro1.iwamatsu@toshiba.co.jp
Subject: Re: [PATCH 6.12.y-cip 0/9] Add RZ/V2H GBETH support
Message-ID: <aQ24SPi6NFwiyA5p@duo.ucw.cz>
References: <20251106104024.28947-1-ovidiu.panait.rb@renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mYzWLAUxjaU9G6Sq"
Content-Disposition: inline
In-Reply-To: <20251106104024.28947-1-ovidiu.panait.rb@renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 07 Nov 2025 09:13:59 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20467


--mYzWLAUxjaU9G6Sq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This patch series adds GBETH support for the Renesas RZ/V2H SoC,
> to the linux-6.12.y-cip kernel.
>=20
> Patches were cherry-picked from mainline kernel.
>=20
> Note: this series depends on the following RZ/G3E series:
> https://lore.kernel.org/cip-dev/20251103113817.36331-1-john.madieu.xa@bp.=
renesas.com/T/#t

This series looks ok to me. I can apply it if it passes testing and if
there are no other comments.

Reviewed-by: Pavel Machek <pavel@denx.de>

Best regards,
								Pavel
--=20
In cooperation with DENX Software Engineering GmbH, HRB 165235 Munich,
Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--mYzWLAUxjaU9G6Sq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaQ24SAAKCRAw5/Bqldv6
8jhUAJ9uQxgInwJDNZfn4yjr0PiVy71OhwCgnadGjyOgSZGOVEdFZZCExt13AG4=
=UB6M
-----END PGP SIGNATURE-----

--mYzWLAUxjaU9G6Sq--

