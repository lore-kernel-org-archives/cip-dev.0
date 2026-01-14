Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37CD4D3CC85
	for <webhook@archiver.kernel.org>; Wed, 14 Jan 2026 22:14:38 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.22780.1768428871226773071
 for <cip-dev@lists.cip-project.org>;
 Wed, 14 Jan 2026 14:14:31 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=ZNY5Ps2I;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id BDFBD10D41E;
	Wed, 14 Jan 2026 23:14:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1768428869;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=fL1zODXh0LpP4INK+qg9JrfmhgO7nrgK2c6ya2CpsR4=;
	b=ZNY5Ps2I5CzHVhyn436QA32r17H0zneAZwsNmCrlw/BhiaC5RVbVxj77JvTClsNzbcp9aE
	pcYLn8MONh4YL7Zs51Uj1cR0nQtKWBGyQyMinMiFYMIBjJT2NuOBsG/1P4E9plLVNoq64O
	GuX/D11sH2NjD8iUOL7JhlGfNHB51xxzHNGIonBAS8FcAPFEs2p3JUDJ8I1ElXtnd72UgQ
	P4CH/Rn/NCnrRQeOqW9Pva+AqZIXRbUDZEi0JhabwBcYVcjsAyXqiMEpzlTNp182QvjPTH
	R5A6FiBmwUtYd6kVoEoF0DIHnZ9RbF6V/jKEzJXBcfutB26IFuFhG+Q+Gnkokg==
Date: Wed, 14 Jan 2026 23:14:27 +0100
From: Pavel Machek <pavel@nabladev.com>
To: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
Cc: cip-dev@lists.cip-project.org, pavel@nabladev.com,
	nobuhiro.iwamatsu.x90@mail.toshiba
Subject: Re: [PATCH 6.12.y-cip 0/4] Add RZ/V2N I2C support
Message-ID: <aWgVQ/RYsVWl4+m2@duo.ucw.cz>
References: <20260114125359.8668-1-ovidiu.panait.rb@renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="10smN/cePMEEuqLP"
Content-Disposition: inline
In-Reply-To: <20260114125359.8668-1-ovidiu.panait.rb@renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 14 Jan 2026 22:14:38 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21559


--10smN/cePMEEuqLP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This patch series adds I2C support for the Renesas RZ/V2N SoC.
>=20
> Patches were cherry-picked from mainline kernel.

Series looks ok	to me, I can apply it if there are no other comments
and if it passes testing.

Reviewed-by: Pavel Machek <pavel@nabladev.com>

Best regards,
                                                                Pavel
--=20
In cooperation with Nabla.

--10smN/cePMEEuqLP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaWgVQwAKCRAw5/Bqldv6
8hYiAKCSCKqZXe8znxE3q4G2WCl3+7yQuACfYTw1kRx9lzgZvnIxm3MS/ZWNK9o=
=iYkw
-----END PGP SIGNATURE-----

--10smN/cePMEEuqLP--

