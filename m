Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82FB2C44500
	for <webhook@archiver.kernel.org>; Thu, 22 Jan 2026 10:42:18 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.34581.1769078535290244239
 for <cip-dev@lists.cip-project.org>;
 Thu, 22 Jan 2026 02:42:15 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=WZAWl6Mq;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E40A410D57D;
	Thu, 22 Jan 2026 11:42:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1769078532;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=NHvpEblXts15/eaXqhBVsj4TYvlROl2c68msj3LmXpo=;
	b=WZAWl6MqIZjBsmc9N8NoL9srkhsYD4vbzU9wNpNGN3By5kpMWilYHM0kqH4megpUhUOogR
	FwxfI8OX7YS3hy7g4GmWTZgF7NBzYK3ui88wvQQB1+JMqCXHbCkyFEi7Jh9ciSf6lQyO/T
	6L7eU1I8MEso46MC/lRdRdasIQ60m2wdy//SZV8WSRkYSp+UzXJ9+79wc8lVWIgVNQaSdE
	lP6RTRBiAJGnhqit3cdS/9TlZeWdETEYZ5UA9tAU5Z1/x9q/8S2zhHLugISgYsMd/xiEF7
	zq7dr6xhL1lgvaSqNsl4k9J5xrkf/1AIe7vI9kH/ZjyAe6pXcWaECufftiL+Jw==
Date: Thu, 22 Jan 2026 11:42:08 +0100
From: Pavel Machek <pavel@nabladev.com>
To: Claudiu <claudiu.beznea@tuxon.dev>
Cc: pavel@nabladev.com, nobuhiro.iwamatsu.x90@mail.toshiba,
	cip-dev@lists.cip-project.org
Subject: Re: [PATCH 6.1.y-cip v3 00/19] RZ/{G2L, G2LC, G2UL, G3S, Five, V2L}:
 Backport MSTOP support
Message-ID: <aXH/AGuUd/oTihKn@duo.ucw.cz>
References: <20260115083451.1064048-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="OhEft50vYq5AKBLF"
Content-Disposition: inline
In-Reply-To: <20260115083451.1064048-1-claudiu.beznea.uj@bp.renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 22 Jan 2026 10:42:18 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21699


--OhEft50vYq5AKBLF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Series backports the MSTOP (Module Stop) support for the Renesas
> RZ/G2L, RZ/G2LC, RZ/G2UL, RZ/G3S, RZ/Five, RZ/V2L SoCs.
>=20
> The purpose of MSTOP is to reduce power consumption by stopping
> unnecessary module's functions.
>=20
> If any master accesses a module that has the clock stopped and the
> MSTOP bit set, a bus error will occur.
>=20
> Due to this, to avoid CPU generating synchronous aborts, changes
> to PM domain specific code were needed. The changes backported in
> this series were adjusted to be executed only for the above
> mentioned Renesas SoCs.
>=20
> Please share your thoughts on this approach.

Thank you, applied and pushed out.

Best regards,
								Pavel
--=20
In cooperation with Nabla.

--OhEft50vYq5AKBLF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaXH/AAAKCRAw5/Bqldv6
8jtlAKCWSVrJlW/sVwPgEQuZkWGgFWPHJgCeI/ywBquGoLNKj24a11ZLvJjvgOA=
=ky6l
-----END PGP SIGNATURE-----

--OhEft50vYq5AKBLF--

