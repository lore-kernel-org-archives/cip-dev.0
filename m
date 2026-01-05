Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD853EEE26E
	for <webhook@archiver.kernel.org>; Mon,  5 Jan 2026 11:44:10 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.62305.1767613440369340611
 for <cip-dev@lists.cip-project.org>;
 Mon, 05 Jan 2026 03:44:00 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=dg6c8s5c;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 018A510014B;
	Mon,  5 Jan 2026 12:43:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1767613438;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=hIiAJ9oM8zY+fyffO32q5Wt7sog1aWPr0V+O8widt8g=;
	b=dg6c8s5cJ3/2hX5nWrxm5pYGCpFjQbozXV3vV7Bv4C8G0+Df33OUcz5Bjr6mf4YgyswiR9
	DMVAUX3v8Gu0lHk73myJFJq4xtVvdnXQn6q/1vEZJ74K+Ia5UyLTYMyNn5GyuVS0tHX8J9
	D1TZRTYAr+IwQPizHwHTs9Aq+xhvNjXvWGe3w4G1t9vKLvzGo3VGwmL42Ee96fbHMr/6pd
	sCAzhdaTJ5Uu81LaIb/Nk8AQtalCmIbeAVPs4kYMIIpxaqGWHaWCXcP5LR17d8d7PFCdy+
	lAeFCvv7rWV9UvWEXUkshhj5SgxDw6Tt8wWdDK+C+T4YwRiuvl1o8vdMaGpRoQ==
Date: Mon, 5 Jan 2026 12:43:54 +0100
From: Pavel Machek <pavel@nabladev.com>
To: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [PATCH 6.12.y-cip 16/17] arm64: dts: renesas:
 r9a09g087m44-rzt2h-evk: Enable I2C0 and I2C1 support
Message-ID: <aVuj+prm0lgQdFQz@duo.ucw.cz>
References: <20251229223911.8663-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20251229223911.8663-17-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1CbO4VfZ8xKiZLhS"
Content-Disposition: inline
In-Reply-To: <20251229223911.8663-17-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 05 Jan 2026 11:44:10 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21311


--1CbO4VfZ8xKiZLhS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> commit fc14be9667ee06301c3fff578357c8d78749bb13 upstream.
>=20
> Enable I2C0 and I2C1 on the RZ/N2H evaluation board.
>=20
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Link: https://lore.kernel.org/20250820200659.2048755-6-prabhakar.mahadev-=
lad.rj@bp.renesas.com
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
>  .../dts/renesas/r9a09g087m44-rzn2h-evk.dts    | 56 +++++++++++++++++++
>  1 file changed, 56 insertions(+)
>=20
> diff --git a/arch/arm64/boot/dts/renesas/r9a09g087m44-rzn2h-evk.dts b/arc=
h/arm64/boot/dts/renesas/r9a09g087m44-rzn2h-evk.dts
> index fb2651c4c3383..a068661fc4429 100644
> --- a/arch/arm64/boot/dts/renesas/r9a09g087m44-rzn2h-evk.dts
> +++ b/arch/arm64/boot/dts/renesas/r9a09g087m44-rzn2h-evk.dts
> @@ -10,6 +10,14 @@
>  #include "r9a09g087m44.dtsi"
>  #include "rzt2h-n2h-evk-common.dtsi"
> =20
> +/*
> + * I2C0 and LED8/9 share the same pins use the below
> + * macro to choose (and set approopriate DIP switches).
> + */

I believe this should be "pins; use" to be correct english.

Best regards,
							Pavel
--=20
In cooperation with Nabla.

--1CbO4VfZ8xKiZLhS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaVuj+gAKCRAw5/Bqldv6
8gO4AKDCgWiOunlCckRm2KG3O1zN717lVACfRzeFHhLDa6RH9uQg5NlMOOfVjlU=
=7dA2
-----END PGP SIGNATURE-----

--1CbO4VfZ8xKiZLhS--

