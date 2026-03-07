Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48A8CFC9EF1
	for <webhook@archiver.kernel.org>; Sat,  7 Mar 2026 10:37:26 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.6929.1772879838509136492
 for <cip-dev@lists.cip-project.org>;
 Sat, 07 Mar 2026 02:37:19 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=d9Cv9D7P;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id BDBB810C1C3;
	Sat,  7 Mar 2026 11:37:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1772879836;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=9Df0OBQWTg+tT5N7rkbDunGAoh9ruVfjglYGVtRaKHw=;
	b=d9Cv9D7PpuBRoPB5psVqmI/6MaiAw2ZDNg+XBxv9lP4gp0SKMrw/n1AcWgWGl+dw8l3d6z
	7PjyVIZ+54GLfuc4/aHhfcPIBr3yoJUiy/AawvvntiSkCc/dTIbtY6lH9HTSg2PO/GiJD8
	L8jGp+ubX46yjRN9x3KUvBGEj3Ky4ZsfOFw++O93vTx1YvSKYlv+dCrzfjDmjYgkwodH+2
	I9SqgL7Uqg+vGbsB5zlBcogF/cFwu3R3joex710DVc7a7OGS/IpRaSONxZkxGXuHupKDYt
	pgLW7W4VTJYEss3UD+Ieqb9v/N22fZXUgW6u7/vcTdgNdBlUUHV6mANSQBsNeQ==
Date: Sat, 7 Mar 2026 11:37:11 +0100
From: Pavel Machek <pavel@nabladev.com>
To: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
Cc: cip-dev@lists.cip-project.org, pavel@nabladev.com,
	nobuhiro.iwamatsu.x90@mail.toshiba
Subject: Re: [PATCH 6.1.y-cip 00/25] Add RZ/V2H display support
Message-ID: <aav/1+zAzAgi6pXJ@duo.ucw.cz>
References: <20260225121003.129467-1-ovidiu.panait.rb@renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="SbOyrb8FYM0f2Bbj"
Content-Disposition: inline
In-Reply-To: <20260225121003.129467-1-ovidiu.panait.rb@renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 07 Mar 2026 10:37:26 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22145


--SbOyrb8FYM0f2Bbj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This series adds display support for the Renesas RZ/V2H SoC and EVK board.
>=20
> All patches were cherry-picked from mainline kernel.

Thank you, applied.

While not strictly neccessary, I would not replies to the patch
comments.

Thanks and best regards,
								Pavel

--SbOyrb8FYM0f2Bbj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaav/1wAKCRAw5/Bqldv6
8lSeAJ4v0pkfWBmt5iNbjQv3y6s3EkAQEgCeO3E0kuU1VpNMup9EzcfuwezTe9w=
=Y0b0
-----END PGP SIGNATURE-----

--SbOyrb8FYM0f2Bbj--

