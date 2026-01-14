Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57F09D3CC84
	for <webhook@archiver.kernel.org>; Wed, 14 Jan 2026 22:13:58 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.22742.1768428833657230114
 for <cip-dev@lists.cip-project.org>;
 Wed, 14 Jan 2026 14:13:54 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=RwXs2dDP;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 1312010B420;
	Wed, 14 Jan 2026 23:13:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1768428831;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=wNnJlTaCgyhmhv4a/bIkOPh1s5BIHQ0PYyE1NVDEXl0=;
	b=RwXs2dDPV/8XqiFiQoIP11Pt2W9pdFUb3mrBx5xnuTBS5iQ/1AfgHCsrRVdqUWNm4Jj+3o
	w2cgZTfn7F+YuX6AtLOiwgXPwPvjUv80gdyLfrbDxT8ZyR6SlDmkS1UmQaO0QOAdqlSjCs
	07qkYDXap/O8SmBnPrvSdoHER7dku4Fjp3k6nDVZ+8koMSfPnM38rtZ7KrfujcB1uERU+M
	nnDsi6JStw3aANdieHjSHNJtQYJSKZo3FI9xNoJ4FL8hUXEJf7+XTU1VxqPodf7wjzauEE
	rVq6Ct9453pa/J87sLcyOJbkVopLw0Mnz/7E2+W1f8h6NUw/O/aUgPKLIzui8g==
Date: Wed, 14 Jan 2026 23:13:46 +0100
From: Pavel Machek <pavel@nabladev.com>
To: ovidiu.panait.rb@renesas.com
Cc: cip-dev@lists.cip-project.org, pavel@nabladev.com,
	nobuhiro.iwamatsu.x90@mail.toshiba
Subject: Re: [cip-dev] [PATCH 6.1.y-cip 0/4] Add RZ/V2N I2C support
Message-ID: <aWgVGhHl8SbeQMy4@duo.ucw.cz>
References: <20260114125324.8630-1-ovidiu.panait.rb@renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="o7JNqDWTqcDwYUZS"
Content-Disposition: inline
In-Reply-To: <20260114125324.8630-1-ovidiu.panait.rb@renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 14 Jan 2026 22:13:58 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21558


--o7JNqDWTqcDwYUZS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This patch series adds I2C support for the Renesas RZ/V2N SoC.
>=20
> Patches were cherry-picked from mainline kernel.

Series looks ok to me, I can apply it if there are no other comments
and if it passes testing.

Reviewed-by: Pavel Machek <pavel@nabladev.com>

Best regards,
                                                                Pavel
--=20
In cooperation with Nabla.

--o7JNqDWTqcDwYUZS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaWgVGgAKCRAw5/Bqldv6
8r12AKCNFyNe14DVfFwbWrGCi+vDjnDHigCgmWzo4DWM9Nxn8hh/DsW9lLEiKDw=
=+6Qg
-----END PGP SIGNATURE-----

--o7JNqDWTqcDwYUZS--

