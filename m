Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A191FCC06C
	for <webhook@archiver.kernel.org>; Fri,  6 Mar 2026 20:03:09 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.3570.1772827379987355868
 for <cip-dev@lists.cip-project.org>;
 Fri, 06 Mar 2026 12:03:00 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=TgbFQvHa;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 7FEB91091E1;
	Fri,  6 Mar 2026 21:02:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1772827377;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=7ws7BZQUNFv1pzSivxs5fhOj5Win6qX1hAsUKbOROco=;
	b=TgbFQvHanP2AG43Ocfw9dL/y97mEVGoG6GFW4ybo0ubfQpCyzqQa/nKuYGKh2t67LYiHDl
	MSceIvtILXJo5NR5G7a92mhlzQ410z93N5di5SBfrmaJcGleuxIPCNFS05GVBBebmN/w31
	akTeVfaTV4Nc4Ny1oVkRWagpiVTvSXr3KlnfrYHhgw8HsqiHMHQstUSAPpNVkDvGIbDmhw
	2ZRsynol10JME1YQAQ2GyChDYhjl10G0PwY2m3PaD9m0j/I00mEuEwJ39BIRf8RihEaTJc
	CxUYYy46/maEmTDUJz1NT1MZy8KUG+MoKhTJVOEttI8v/FmkL+UaiDPGwgQ2/g==
Date: Fri, 6 Mar 2026 21:02:53 +0100
From: Pavel Machek <pavel@nabladev.com>
To: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
Cc: cip-dev@lists.cip-project.org, pavel@nabladev.com,
	nobuhiro.iwamatsu.x90@mail.toshiba
Subject: Re: [PATCH 6.12.y-cip 00/24] Add RZ/V2H display support
Message-ID: <aasy7WaX0xhJhMDN@duo.ucw.cz>
References: <20260225121232.129678-1-ovidiu.panait.rb@renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="SZbqJ/PurQ+eOTWK"
Content-Disposition: inline
In-Reply-To: <20260225121232.129678-1-ovidiu.panait.rb@renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 06 Mar 2026 20:03:09 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22143


--SZbqJ/PurQ+eOTWK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This series adds display support for the Renesas RZ/V2H SoC and EVK board.
>=20
> All patches were cherry-picked from mainline kernel.

Thank you, applied.

Best regards,
								Pavel

--SZbqJ/PurQ+eOTWK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaasy7QAKCRAw5/Bqldv6
8oCmAJ9l1BfBZZTGcAB4ucahrnrtGgk9AQCgo118C06yXNzctgzh4cYp0V8R+/Y=
=/6MZ
-----END PGP SIGNATURE-----

--SZbqJ/PurQ+eOTWK--

