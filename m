Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 692F3EA4FBA
	for <webhook@archiver.kernel.org>; Mon, 23 Feb 2026 12:47:55 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.34265.1771850871194428642
 for <cip-dev@lists.cip-project.org>;
 Mon, 23 Feb 2026 04:47:51 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=i56riqud;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 7482C104804;
	Mon, 23 Feb 2026 13:47:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1771850869;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=4IeoTDz73YzwWZqB9FBD9R0uSpfPMAa2xfk53Mr6hts=;
	b=i56riqud0HeTfm+IbLyGcU6fBgVt4B5xJZanJMRChSGDvbjy0GYRn5xYAs658DdMbi6FY3
	khyeT/ERuC0E/zDzC+ysGctVSg6qNYX7BC+UURRtWTKNkSySAq657nb8j61OEGxRSkn5Hx
	s0RjRo6J7pkdXKVIOXW3FF38m3KyDx4auRbx9LUEHIt1Rkx2cEfdqtMnfz5D3YS27pIRdy
	7jzJPzRpmY2gDciOoIo+zefXt6BSqSDPkxgGFmf+eksZA0LIjuCgFUO2MWlY5AXJupQ5CK
	AAWme0+T/TJ7LEO7661ZOy+uSpODHGt/FvJoWk9a6LZalx7UFmjeyLYaD/Hapw==
Date: Mon, 23 Feb 2026 13:47:47 +0100
From: Pavel Machek <pavel@nabladev.com>
To: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
Cc: cip-dev@lists.cip-project.org, pavel@nabladev.com,
	nobuhiro.iwamatsu.x90@mail.toshiba
Subject: Re: [PATCH 6.12.y-cip 0/4] Add RZ/V2N GPU support
Message-ID: <aZxMc0vctvgxRG3r@duo.ucw.cz>
References: <20260223102758.119908-1-ovidiu.panait.rb@renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5bBjpW+7BMU8+jS9"
Content-Disposition: inline
In-Reply-To: <20260223102758.119908-1-ovidiu.panait.rb@renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 23 Feb 2026 12:47:55 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21918


--5bBjpW+7BMU8+jS9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This series adds GPU (Mali-G31) support for the Renesas RZ/V2N SoC.
>=20
> Patches were cherry-picked from mainline kernel.

This looks okay to me.

Reviewed-by: Pavel Machek <pavel@nabladev.com>

I can apply the series if it passes testing and there are no other
comments.

Best regards,
                                                                Pavel
--=20
In cooperation with Nabla.

--5bBjpW+7BMU8+jS9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaZxMcwAKCRAw5/Bqldv6
8uCyAJ9PvafQJMmwlltgUoa0teLkHu5aoACgqsFE14pbNOSklM5kyQZj3kFBgAI=
=dFky
-----END PGP SIGNATURE-----

--5bBjpW+7BMU8+jS9--

